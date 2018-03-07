#import "GCLVectorSource_Private.h"

#import "GCLFeature_Private.h"
#import "GCLSource_Private.h"
#import "GCLTileSource_Private.h"
#import "GCLStyle_Private.h"
#import "GCLMapView_Private.h"
#import "NSPredicate+GCLAdditions.h"
#import "NSURL+GCLAdditions.h"

#include <mbgl/map/map.hpp>
#include <mbgl/style/sources/vector_source.hpp>
#include <mbgl/renderer/renderer.hpp>

@interface GCLVectorSource ()

@property (nonatomic, readonly) mbgl::style::VectorSource *rawSource;

@end

@implementation GCLVectorSource

- (instancetype)initWithIdentifier:(NSString *)identifier configurationURL:(NSURL *)configurationURL {
    auto source = std::make_unique<mbgl::style::VectorSource>(identifier.UTF8String,
                                                              configurationURL.gcl_URLByStandardizingScheme.absoluteString.UTF8String);
    return self = [super initWithPendingSource:std::move(source)];
}

- (instancetype)initWithIdentifier:(NSString *)identifier tileURLTemplates:(NS_ARRAY_OF(NSString *) *)tileURLTemplates options:(nullable NS_DICTIONARY_OF(GCLTileSourceOption, id) *)options {
    mbgl::Tileset tileSet = GCLTileSetFromTileURLTemplates(tileURLTemplates, options);
    auto source = std::make_unique<mbgl::style::VectorSource>(identifier.UTF8String, tileSet);
    return self = [super initWithPendingSource:std::move(source)];
}

- (mbgl::style::VectorSource *)rawSource {
    return (mbgl::style::VectorSource *)super.rawSource;
}

- (NSURL *)configurationURL {
    auto url = self.rawSource->getURL();
    return url ? [NSURL URLWithString:@(url->c_str())] : nil;
}

- (NSString *)attributionHTMLString {
    auto attribution = self.rawSource->getAttribution();
    return attribution ? @(attribution->c_str()) : nil;
}

- (NS_ARRAY_OF(id <GCLFeature>) *)featuresInSourceLayersWithIdentifiers:(NS_SET_OF(NSString *) *)sourceLayerIdentifiers predicate:(nullable NSPredicate *)predicate {
    
    mbgl::optional<std::vector<std::string>> optionalSourceLayerIDs;
    if (sourceLayerIdentifiers) {
        __block std::vector<std::string> layerIDs;
        layerIDs.reserve(sourceLayerIdentifiers.count);
        [sourceLayerIdentifiers enumerateObjectsUsingBlock:^(NSString * _Nonnull identifier, BOOL * _Nonnull stop) {
            layerIDs.push_back(identifier.UTF8String);
        }];
        optionalSourceLayerIDs = layerIDs;
    }
    
    mbgl::optional<mbgl::style::Filter> optionalFilter;
    if (predicate) {
        optionalFilter = predicate.gcl_filter;
    }
    
    std::vector<mbgl::Feature> features;
    if (self.mapView) {
        features = self.mapView.renderer->querySourceFeatures(self.rawSource->getID(), { optionalSourceLayerIDs, optionalFilter });
    }
    return GCLFeaturesFromMBGLFeatures(features);
}

@end
