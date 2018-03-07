#include <mbgl/storage/mbtile_file_source.hpp>
#include <mbgl/storage/file_source_request.hpp>
#include <mbgl/storage/response.hpp>
#include <mbgl/util/string.hpp>
#include <mbgl/util/thread.hpp>
#include <mbgl/util/url.hpp>
#include <mbgl/util/util.hpp>
#include <mbgl/util/io.hpp>
#include <sqlite3.hpp>
#include <sqlite3.h>
#include <string>
#import <mbgl/util/compression.hpp>
#include <boost/algorithm/string/classification.hpp>
#include <boost/algorithm/string/split.hpp>
#include <map>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <mbgl/util/event.hpp>
#include <mbgl/util/logging.hpp>
#include <mbtile_info.hpp>

using namespace std;

namespace {

    const char *protocol = "mbtile://";
    const std::size_t protocolLength = 9;

} // namespace

namespace mbgl {

    class MBTileFileSource::Impl {
    private:
        unique_ptr<map<std::string, shared_ptr<mapbox::sqlite::Database>>> dbMap;
        unique_ptr<map<std::string, shared_ptr<MBTileInfo>>> tileInfoMap;
    public:
        Impl(ActorRef<Impl>) {
            dbMap = make_unique<map<std::string, shared_ptr<mapbox::sqlite::Database>>>();
            tileInfoMap = make_unique<map<std::string, shared_ptr<MBTileInfo>>>();
        }

        ~Impl() {
            map<string, shared_ptr<mapbox::sqlite::Database>>::iterator it;
            for(it = dbMap->begin();it != dbMap->end(); it++){
                it->second.reset();
            }
            dbMap.reset();

            map<string, shared_ptr<MBTileInfo>>::iterator infoIt;
            for(infoIt = tileInfoMap->begin();infoIt != tileInfoMap->end(); infoIt++){
                infoIt->second.reset();
            }
            tileInfoMap.reset();
        }

        void request(const std::string &url, ActorRef<FileSourceRequest> req) {
            // Cut off the protocol
            std::string path = mbgl::util::percentDecode(url.substr(protocolLength));
            //解析url
            vector<string> vStr;
            boost::split(vStr, path, boost::is_any_of("&"), boost::token_compress_on);
            string dbPath;
            int x,y,z;
            for (vector<string>::iterator it = vStr.begin(); it != vStr.end(); ++it) {
                string keyValue = *it;
                vector<string> kv;
                boost::split(kv, keyValue, boost::is_any_of("="), boost::token_compress_on);
                if(kv[0].compare("x")==0){
                    x = atoi(kv[1].c_str());
                }else if(kv[0].compare("y")==0){
                    y = atoi(kv[1].c_str());
                } else if(kv[0].compare("z")==0){
                    z = atoi(kv[1].c_str());
                }else if(kv[0].compare("path")==0){
                    dbPath = kv[1];
                }
            }

            shared_ptr<mapbox::sqlite::Database> db;
            shared_ptr<MBTileInfo> tileInfo;

            map<string, shared_ptr<mapbox::sqlite::Database>>::iterator it;
            map<string, shared_ptr<MBTileInfo>>::iterator itInfo;
            it = dbMap->find(dbPath);
            itInfo = tileInfoMap->find(dbPath);
            if(it!=dbMap->end()){
                db = it->second;
                tileInfo = itInfo->second;
            }else{
                db =  std::make_shared<mapbox::sqlite::Database>(dbPath, SQLITE_OPEN_READWRITE);
                dbMap->insert(pair<string,shared_ptr<mapbox::sqlite::Database>>(dbPath,db));
                tileInfo = std::make_shared<MBTileInfo>(db.get());
                tileInfoMap->insert(pair<string,shared_ptr<MBTileInfo>>(dbPath,tileInfo));
            }

            Response response;

            if(!tileInfo->isExists(z,x,y)){
                response.error = std::make_unique<Response::Error>(
                        Response::Error::Reason::NotFound);
            }else{
                auto stmt = db->prepare("SELECT tile_data FROM tiles WHERE zoom_level = ? AND tile_column = ? AND tile_row = ?");
                stmt.bind(1,z);
                stmt.bind(2,x);
                stmt.bind(3,y);
                if (stmt.run()) {
                    std::string tileData = stmt.get<std::string>(0);
                    response.data = std::make_shared<std::string>(tileData);
                } else {
                    response.error = std::make_unique<Response::Error>(
                            Response::Error::Reason::NotFound);
                }
            }

            req.invoke(&FileSourceRequest::setResponse, response);
        }

    };

    MBTileFileSource::MBTileFileSource()
            : impl(std::make_unique<util::Thread<Impl>>("MBTileFileSource")) {
    }

    MBTileFileSource::~MBTileFileSource() {

    };

    std::unique_ptr<AsyncRequest>
    MBTileFileSource::request(const Resource &resource, Callback callback) {
        auto req = std::make_unique<FileSourceRequest>(std::move(callback));

        impl->actor().invoke(&Impl::request, resource.url, req->actor());

        return std::move(req);
    }

    bool MBTileFileSource::acceptsURL(const std::string &url) {
        return url.compare(0, protocolLength, protocol) == 0;
    }




} // namespace mbgl
