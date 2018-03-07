#import "GCLFoundation.h"
#import "GCLShapeSource.h"

NS_ASSUME_NONNULL_BEGIN

namespace mbgl {
    namespace style {
        class GeoJSONOptions;
    }
}

@interface GCLShapeSource (Private)
@end

GCL_EXPORT
mbgl::style::GeoJSONOptions GCLGeoJSONOptionsFromDictionary(NS_DICTIONARY_OF(GCLShapeSourceOption, id) *options);

NS_ASSUME_NONNULL_END
