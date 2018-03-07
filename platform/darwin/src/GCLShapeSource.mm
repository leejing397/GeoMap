#import "GCLShapeSource_Private.h"

#import "GCLStyle_Private.h"
#import "GCLMapView_Private.h"
#import "GCLSource_Private.h"
#import "GCLFeature_Private.h"
#import "GCLShape_Private.h"

#import "NSPredicate+GCLAdditions.h"
#import "NSURL+GCLAdditions.h"

#include <mbgl/map/map.hpp>
#include <mbgl/style/sources/geojson_source.hpp>
#include <mbgl/renderer/renderer.hpp>

const GCLShapeSourceOption GCLShapeSourceOptionClustered = @"GCLShapeSourceOptionClustered";
const GCLShapeSourceOption GCLShapeSourceOptionClusterRadius = @"GCLShapeSourceOptionClusterRadius";
const GCLShapeSourceOption GCLShapeSourceOptionMaximumZoomLevelForClustering = @"GCLShapeSourceOptionMaximumZoomLevelForClustering";
const GCLShapeSourceOption GCLShapeSourceOptionMaximumZoomLevel = @"GCLShapeSourceOptionMaximumZoomLevel";
const GCLShapeSourceOption GCLShapeSourceOptionBuffer = @"GCLShapeSourceOptionBuffer";
const GCLShapeSourceOption GCLShapeSourceOptionSimplificationTolerance = @"GCLShapeSourceOptionSimplificationTolerance";

@interface GCLShapeSource ()

@property (nonatomic, readwrite) NSDictionary *options;
@property (nonatomic, readonly) mbgl::style::GeoJSONSource *rawSource;

@end

@implementation GCLShapeSource

- (instancetype)initWithIdentifier:(NSString *)identifier URL:(NSURL *)url options:(NS_DICTIONARY_OF(NSString *, id) *)options {
    auto geoJSONOptions = GCLGeoJSONOptionsFromDictionary(options);
    auto source = std::make_unique<mbgl::style::GeoJSONSource>(identifier.UTF8String, geoJSONOptions);
    if (self = [super initWithPendingSource:std::move(source)]) {
        self.URL = url;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier shape:(nullable GCLShape *)shape options:(NS_DICTIONARY_OF(GCLShapeSourceOption, id) *)options {
    auto geoJSONOptions = GCLGeoJSONOptionsFromDictionary(options);
    auto source = std::make_unique<mbgl::style::GeoJSONSource>(identifier.UTF8String, geoJSONOptions);
    if (self = [super initWithPendingSource:std::move(source)]) {
        self.shape = shape;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier features:(NS_ARRAY_OF(GCLShape<GCLFeature> *) *)features options:(nullable NS_DICTIONARY_OF(GCLShapeSourceOption, id) *)options {
    for (id <GCLFeature> feature in features) {
        if (![feature conformsToProtocol:@protocol(GCLFeature)]) {
            [NSException raise:NSInvalidArgumentException format:@"The object %@ included in the features argument does not conform to the GCLFeature protocol.", feature];
        }
    }
    GCLShapeCollectionFeature *shapeCollectionFeature = [GCLShapeCollectionFeature shapeCollectionWithShapes:features];
    return [self initWithIdentifier:identifier shape:shapeCollectionFeature options:options];
}

- (instancetype)initWithIdentifier:(NSString *)identifier shapes:(NS_ARRAY_OF(GCLShape *) *)shapes options:(nullable NS_DICTIONARY_OF(GCLShapeSourceOption, id) *)options {
    GCLShapeCollection *shapeCollection = [GCLShapeCollection shapeCollectionWithShapes:shapes];
    return [self initWithIdentifier:identifier shape:shapeCollection options:options];
}

- (mbgl::style::GeoJSONSource *)rawSource {
    return (mbgl::style::GeoJSONSource *)super.rawSource;
}

- (NSURL *)URL {
    auto url = self.rawSource->getURL();
    return url ? [NSURL URLWithString:@(url->c_str())] : nil;
}

- (void)setURL:(NSURL *)url {
    if (url) {
        self.rawSource->setURL(url.gcl_URLByStandardizingScheme.absoluteString.UTF8String);
        _shape = nil;
    } else {
        self.shape = nil;
    }
}

- (void)setShape:(GCLShape *)shape {
    self.rawSource->setGeoJSON({ shape.geoJSONObject });
    _shape = shape;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@; URL = %@; shape = %@>",
            NSStringFromClass([self class]), (void *)self, self.identifier, self.URL, self.shape];
}

- (NS_ARRAY_OF(id <GCLFeature>) *)featuresMatchingPredicate:(nullable NSPredicate *)predicate {
    
    mbgl::optional<mbgl::style::Filter> optionalFilter;
    if (predicate) {
        optionalFilter = predicate.gcl_filter;
    }
    
    std::vector<mbgl::Feature> features;
    if (self.mapView) {
        features = self.mapView.renderer->querySourceFeatures(self.rawSource->getID(), { {}, optionalFilter });
    }
    return GCLFeaturesFromMBGLFeatures(features);
}

@end

mbgl::style::GeoJSONOptions GCLGeoJSONOptionsFromDictionary(NS_DICTIONARY_OF(GCLShapeSourceOption, id) *options) {
    auto geoJSONOptions = mbgl::style::GeoJSONOptions();

    if (NSNumber *value = options[GCLShapeSourceOptionMaximumZoomLevel]) {
        if (![value isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"MGLShapeSourceOptionMaximumZoomLevel must be an NSNumber."];
        }
        geoJSONOptions.maxzoom = value.integerValue;
    }

    if (NSNumber *value = options[GCLShapeSourceOptionBuffer]) {
        if (![value isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"MGLShapeSourceOptionBuffer must be an NSNumber."];
        }
        geoJSONOptions.buffer = value.integerValue;
    }

    if (NSNumber *value = options[GCLShapeSourceOptionSimplificationTolerance]) {
        if (![value isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"MGLShapeSourceOptionSimplificationTolerance must be an NSNumber."];
        }
        geoJSONOptions.tolerance = value.doubleValue;
    }

    if (NSNumber *value = options[GCLShapeSourceOptionClusterRadius]) {
        if (![value isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"MGLShapeSourceOptionClusterRadius must be an NSNumber."];
        }
        geoJSONOptions.clusterRadius = value.integerValue;
    }

    if (NSNumber *value = options[GCLShapeSourceOptionMaximumZoomLevelForClustering]) {
        if (![value isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"MGLShapeSourceOptionMaximumZoomLevelForClustering must be an NSNumber."];
        }
        geoJSONOptions.clusterMaxZoom = value.integerValue;
    }

    if (NSNumber *value = options[GCLShapeSourceOptionClustered]) {
        if (![value isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"MGLShapeSourceOptionClustered must be an NSNumber."];
        }
        geoJSONOptions.cluster = value.boolValue;
    }

    return geoJSONOptions;
}
