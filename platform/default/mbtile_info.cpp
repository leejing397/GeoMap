//
// Created by GXSN-Pro on 2017/11/16.
//

#include "mbtile_info.hpp"

#include <map>
#include <string>


MBTileInfo::~MBTileInfo(){
    delete levels;
}

MBTileInfo::MBTileInfo (sqlite::Database* db)  {
    auto stmt = db->prepare("SELECT * FROM metadata");
    while (stmt.run()) {
        string key = stmt.get<std::string>(0);
        int  value = stmt.get<int>(1);
        if(key.compare("minLevel")==0){
            minLevel = value;
        } else if(key.compare("maxLevel")==0){
            maxLevel = value;
        }
    }
    stmt.reset();

    levels = new LevelInfo*[maxLevel+1];

    stmt = db->prepare("select level,minX,minY,maxX,maxY from level_info");
        while (stmt.run()) {
            int level = stmt.get<int>(0);
            int minx  = stmt.get<int>(1);
            int miny  = stmt.get<int>(2);
            int maxx  = stmt.get<int>(3);
            int maxy  = stmt.get<int>(4);
            LevelInfo* levelInfo = new LevelInfo(level,minx,maxx,miny,maxy);
            levels[level] = levelInfo;
        }

}

bool MBTileInfo::isExists(int level,int x,int y){
    if(level >= minLevel && level <= maxLevel){
        LevelInfo* info = levels[level];
        return  info->isExists(x,y);
    }
    return false;
}