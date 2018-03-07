#import "GCLFoundation.h"
#import "GCLFeature.h"
#import "GCLShape.h"

#import <mbgl/util/geo.hpp>
#import <mbgl/util/feature.hpp>
#import <mbgl/style/conversion/geojson.hpp>

NS_ASSUME_NONNULL_BEGIN

/**
 Returns an array of `GCLFeature` objects converted from the given vector of
 vector tile features.
 */
GCL_EXPORT
NS_ARRAY_OF(GCLShape <GCLFeature> *) *GCLFeaturesFromMBGLFeatures(const std::vector<mbgl::Feature> &features);

/**
 Returns an `GCLFeature` object converted from the given mbgl::Feature
 */
id <GCLFeature> GCLFeatureFromMBGLFeature(const mbgl::Feature &feature);

/**
 Returns an `GCLShape` representing the given geojson. The shape can be
 a feature, a collection of features, or a geometry.
 */
GCLShape* GCLShapeFromGeoJSON(const mapbox::geojson::geojson &geojson);

/**
 Takes an `mbgl::Feature` object, an identifer, and attributes dictionary and
 returns the feature object with converted `mbgl::FeatureIdentifier` and
 `mbgl::PropertyMap` properties.
 */
mbgl::Feature mbglFeature(mbgl::Feature feature, id identifier, NSDictionary *attributes);

/**
 Returns an `NSDictionary` representation of an `GCLFeature`.
 */
NS_DICTIONARY_OF(NSString *, id) *NSDictionaryFeatureForGeometry(NSDictionary *geometry, NSDictionary *attributes, id identifier);

NS_ASSUME_NONNULL_END

#define GCL_DEFINE_FEATURE_INIT_WITH_CODER() \
    - (instancetype)initWithCoder:(NSCoder *)decoder { \
        if (self = [super initWithCoder:decoder]) { \
            NSSet<Class> *identifierClasses = [NSSet setWithArray:@[[NSString class], [NSNumber class]]]; \
            identifier = [decoder decodeObjectOfClasses:identifierClasses forKey:@"identifier"]; \
            attributes = [decoder decodeObjectOfClass:[NSDictionary class] forKey:@"attributes"]; \
        } \
        return self; \
    }

#define GCL_DEFINE_FEATURE_ENCODE() \
    - (void)encodeWithCoder:(NSCoder *)coder { \
        [super encodeWithCoder:coder]; \
        [coder encodeObject:identifier forKey:@"identifier"]; \
        [coder encodeObject:attributes forKey:@"attributes"]; \
    }

#define GCL_DEFINE_FEATURE_IS_EQUAL() \
    - (BOOL)isEqual:(id)other { \
        if (other == self) return YES; \
        if (![other isKindOfClass:[self class]]) return NO; \
        __typeof(self) otherFeature = other; \
        return [super isEqual:other] && [self geoJSONObject] == [otherFeature geoJSONObject]; \
    } \
    - (NSUInteger)hash { \
        return [super hash] + [[self geoJSONDictionary] hash]; \
    }
