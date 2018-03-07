#import "GCLFeature_Private.h"

#import "GCLPointAnnotation.h"
#import "GCLPolyline.h"
#import "GCLPolygon.h"
#import "GCLValueEvaluator.h"

#import "GCLShape_Private.h"
#import "GCLPointCollection_Private.h"
#import "GCLPolyline+GCLAdditions.h"
#import "GCLPolygon+GCLAdditions.h"
#import "NSDictionary+GCLAdditions.h"
#import "NSArray+GCLAdditions.h"

#import "NSExpression+GCLAdditions.h"

#import <mbgl/util/geometry.hpp>
#import <mbgl/style/conversion/geojson.hpp>
#import <mapbox/geometry/feature.hpp>

@interface GCLPointFeature ()
@end

@implementation GCLPointFeature

@synthesize identifier;
@synthesize attributes;

GCL_DEFINE_FEATURE_INIT_WITH_CODER();
GCL_DEFINE_FEATURE_ENCODE();
GCL_DEFINE_FEATURE_IS_EQUAL();

- (id)attributeForKey:(NSString *)key {
    return self.attributes[key];
}

- (NSDictionary *)geoJSONDictionary {
    return NSDictionaryFeatureForGeometry([super geoJSONDictionary], self.attributes, self.identifier);
}

- (mbgl::GeoJSON)geoJSONObject {
    return mbglFeature({[self geometryObject]}, identifier, self.attributes);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@, coordinate = %f, %f, attributes = %@>",
            NSStringFromClass([self class]), (void *)self,
            self.identifier ? [NSString stringWithFormat:@"\"%@\"", self.identifier] : self.identifier,
            self.coordinate.latitude, self.coordinate.longitude,
            self.attributes.count ? self.attributes : @"none"];
}

@end

@interface GCLPolylineFeature ()
@end

@implementation GCLPolylineFeature

@synthesize identifier;
@synthesize attributes;

GCL_DEFINE_FEATURE_INIT_WITH_CODER();
GCL_DEFINE_FEATURE_ENCODE();
GCL_DEFINE_FEATURE_IS_EQUAL();

- (id)attributeForKey:(NSString *)key {
    return self.attributes[key];
}

- (NSDictionary *)geoJSONDictionary {
    return NSDictionaryFeatureForGeometry([super geoJSONDictionary], self.attributes, self.identifier);
}

- (mbgl::GeoJSON)geoJSONObject {
    return mbglFeature({[self geometryObject]}, identifier, self.attributes);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@, count = %lu, bounds = %@, attributes = %@>",
            NSStringFromClass([self class]), (void *)self,
            self.identifier ? [NSString stringWithFormat:@"\"%@\"", self.identifier] : self.identifier,
            (unsigned long)[self pointCount],
            GCLStringFromCoordinateBounds(self.overlayBounds),
            self.attributes.count ? self.attributes : @"none"];
}

@end

@interface GCLPolygonFeature ()
@end

@implementation GCLPolygonFeature

@synthesize identifier;
@synthesize attributes;

GCL_DEFINE_FEATURE_INIT_WITH_CODER();
GCL_DEFINE_FEATURE_ENCODE();
GCL_DEFINE_FEATURE_IS_EQUAL();

- (id)attributeForKey:(NSString *)key {
    return self.attributes[key];
}

- (NSDictionary *)geoJSONDictionary {
    return NSDictionaryFeatureForGeometry([super geoJSONDictionary], self.attributes, self.identifier);
}

- (mbgl::GeoJSON)geoJSONObject {
    return mbglFeature({[self geometryObject]}, identifier, self.attributes);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@, count = %lu, bounds = %@, attributes = %@>",
            NSStringFromClass([self class]), (void *)self,
            self.identifier ? [NSString stringWithFormat:@"\"%@\"", self.identifier] : self.identifier,
            (unsigned long)[self pointCount],
            GCLStringFromCoordinateBounds(self.overlayBounds),
            self.attributes.count ? self.attributes : @"none"];
}

@end

@interface GCLPointCollectionFeature ()
@end

@implementation GCLPointCollectionFeature

@synthesize identifier;
@synthesize attributes;

GCL_DEFINE_FEATURE_INIT_WITH_CODER();
GCL_DEFINE_FEATURE_ENCODE();
GCL_DEFINE_FEATURE_IS_EQUAL();

- (id)attributeForKey:(NSString *)key {
    return self.attributes[key];
}

- (NSDictionary *)geoJSONDictionary {
    return NSDictionaryFeatureForGeometry([super geoJSONDictionary], self.attributes, self.identifier);
}

- (mbgl::GeoJSON)geoJSONObject {
    return mbglFeature({[self geometryObject]}, identifier, self.attributes);
}

@end

@interface GCLMultiPolylineFeature ()
@end

@implementation GCLMultiPolylineFeature

@synthesize identifier;
@synthesize attributes;

GCL_DEFINE_FEATURE_INIT_WITH_CODER();
GCL_DEFINE_FEATURE_ENCODE();
GCL_DEFINE_FEATURE_IS_EQUAL();

- (id)attributeForKey:(NSString *)key {
    return self.attributes[key];
}

- (NSDictionary *)geoJSONDictionary {
    return NSDictionaryFeatureForGeometry([super geoJSONDictionary], self.attributes, self.identifier);
}

- (mbgl::GeoJSON)geoJSONObject {
    return mbglFeature({[self geometryObject]}, identifier, self.attributes);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@, count = %lu, bounds = %@, attributes = %@>",
            NSStringFromClass([self class]), (void *)self,
            self.identifier ? [NSString stringWithFormat:@"\"%@\"", self.identifier] : self.identifier,
            (unsigned long)self.polylines.count,
            GCLStringFromCoordinateBounds(self.overlayBounds),
            self.attributes.count ? self.attributes : @"none"];
}

@end

@interface GCLMultiPolygonFeature ()
@end

@implementation GCLMultiPolygonFeature

@synthesize identifier;
@synthesize attributes;

GCL_DEFINE_FEATURE_INIT_WITH_CODER();
GCL_DEFINE_FEATURE_ENCODE();
GCL_DEFINE_FEATURE_IS_EQUAL();

- (id)attributeForKey:(NSString *)key {
    return self.attributes[key];
}

- (NSDictionary *)geoJSONDictionary {
    return NSDictionaryFeatureForGeometry([super geoJSONDictionary], self.attributes, self.identifier);
}

- (mbgl::GeoJSON)geoJSONObject {
    return mbglFeature({[self geometryObject]}, identifier, self.attributes);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@, count = %lu, bounds = %@, attributes = %@>",
            NSStringFromClass([self class]), (void *)self,
            self.identifier ? [NSString stringWithFormat:@"\"%@\"", self.identifier] : self.identifier,
            (unsigned long)self.polygons.count,
            GCLStringFromCoordinateBounds(self.overlayBounds),
            self.attributes.count ? self.attributes : @"none"];
}

@end

@interface GCLShapeCollectionFeature ()
@end

@implementation GCLShapeCollectionFeature

@synthesize identifier;
@synthesize attributes;

@dynamic shapes;

+ (instancetype)shapeCollectionWithShapes:(NS_ARRAY_OF(GCLShape<GCLFeature> *) *)shapes {
    return [super shapeCollectionWithShapes:shapes];
}

GCL_DEFINE_FEATURE_INIT_WITH_CODER();
GCL_DEFINE_FEATURE_ENCODE();
GCL_DEFINE_FEATURE_IS_EQUAL();

- (id)attributeForKey:(NSString *)key {
    return self.attributes[key];
}

- (NSDictionary *)geoJSONDictionary {
    return NSDictionaryFeatureForGeometry([super geoJSONDictionary], self.attributes, self.identifier);
}

- (mbgl::GeoJSON)geoJSONObject {
    mbgl::FeatureCollection featureCollection;
    featureCollection.reserve(self.shapes.count);
    for (GCLShape <GCLFeature> *feature in self.shapes) {
        auto geoJSONObject = feature.geoJSONObject;
        NSAssert(geoJSONObject.is<mbgl::Feature>(), @"Feature collection must only contain features.");
        featureCollection.push_back(geoJSONObject.get<mbgl::Feature>());
    }
    return featureCollection;
}

@end

/**
 Transforms an `mbgl::geometry::geometry` type into an instance of the
 corresponding Objective-C geometry class.
 */
template <typename T>
class GeometryEvaluator {
public:
    GCLShape <GCLFeature> * operator()(const mbgl::Point<T> &geometry) const {
        GCLPointFeature *feature = [[GCLPointFeature alloc] init];
        feature.coordinate = toLocationCoordinate2D(geometry);
        return feature;
    }

    GCLShape <GCLFeature> * operator()(const mbgl::LineString<T> &geometry) const {
        std::vector<CLLocationCoordinate2D> coordinates = toLocationCoordinates2D(geometry);
        return [GCLPolylineFeature polylineWithCoordinates:&coordinates[0] count:coordinates.size()];
    }

    GCLShape <GCLFeature> * operator()(const mbgl::Polygon<T> &geometry) const {
        return toShape<GCLPolygonFeature>(geometry);
    }

    GCLShape <GCLFeature> * operator()(const mbgl::MultiPoint<T> &geometry) const {
        std::vector<CLLocationCoordinate2D> coordinates = toLocationCoordinates2D(geometry);
        return [[GCLPointCollectionFeature alloc] initWithCoordinates:&coordinates[0] count:coordinates.size()];
    }

    GCLShape <GCLFeature> * operator()(const mbgl::MultiLineString<T> &geometry) const {
        NSMutableArray *polylines = [NSMutableArray arrayWithCapacity:geometry.size()];
        for (auto &lineString : geometry) {
            std::vector<CLLocationCoordinate2D> coordinates = toLocationCoordinates2D(lineString);
            GCLPolyline *polyline = [GCLPolyline polylineWithCoordinates:&coordinates[0] count:coordinates.size()];
            [polylines addObject:polyline];
        }

        return [GCLMultiPolylineFeature multiPolylineWithPolylines:polylines];
    }

    GCLShape <GCLFeature> * operator()(const mbgl::MultiPolygon<T> &geometry) const {
        NSMutableArray *polygons = [NSMutableArray arrayWithCapacity:geometry.size()];
        for (auto &polygon : geometry) {
            [polygons addObject:toShape(polygon)];
        }

        return [GCLMultiPolygonFeature multiPolygonWithPolygons:polygons];
    }

    GCLShape <GCLFeature> * operator()(const mapbox::geometry::geometry_collection<T> &collection) const {
        NSMutableArray *shapes = [NSMutableArray arrayWithCapacity:collection.size()];
        for (auto &geometry : collection) {
            // This is very much like the transformation that happens in MGLFeaturesFromMBGLFeatures(), but these are raw geometries with no associated feature IDs or attributes.
            GCLShape <GCLFeature> *shape = mapbox::geometry::geometry<T>::visit(geometry, *this);
            [shapes addObject:shape];
        }
        return [GCLShapeCollectionFeature shapeCollectionWithShapes:shapes];
    }

private:
    static CLLocationCoordinate2D toLocationCoordinate2D(const mbgl::Point<T> &point) {
        return CLLocationCoordinate2DMake(point.y, point.x);
    }

    static std::vector<CLLocationCoordinate2D> toLocationCoordinates2D(const std::vector<mbgl::Point<T>> &points) {
        std::vector<CLLocationCoordinate2D> coordinates;
        coordinates.reserve(points.size());
        std::transform(points.begin(), points.end(), std::back_inserter(coordinates), toLocationCoordinate2D);
        return coordinates;
    }

    template<typename U = GCLPolygon>
    static U *toShape(const mbgl::Polygon<T> &geometry) {
        auto &linearRing = geometry.front();
        std::vector<CLLocationCoordinate2D> coordinates = toLocationCoordinates2D(linearRing);
        NSMutableArray *innerPolygons;
        if (geometry.size() > 1) {
            innerPolygons = [NSMutableArray arrayWithCapacity:geometry.size() - 1];
            for (auto iter = geometry.begin() + 1; iter != geometry.end(); iter++) {
                auto &innerRing = *iter;
                std::vector<CLLocationCoordinate2D> coordinates = toLocationCoordinates2D(innerRing);
                GCLPolygon *innerPolygon = [GCLPolygon polygonWithCoordinates:&coordinates[0] count:coordinates.size()];
                [innerPolygons addObject:innerPolygon];
            }
        }

        return [U polygonWithCoordinates:&coordinates[0] count:coordinates.size() interiorPolygons:innerPolygons];
    }
};

template <typename T>
class GeoJSONEvaluator {
public:
    GCLShape <GCLFeature> * operator()(const mbgl::Geometry<T> &geometry) const {
        GeometryEvaluator<T> evaluator;
        GCLShape <GCLFeature> *shape = mapbox::geometry::geometry<T>::visit(geometry, evaluator);
        return shape;
    }

    GCLShape <GCLFeature> * operator()(const mbgl::Feature &feature) const {
        GCLShape <GCLFeature> *shape = (GCLShape <GCLFeature> *)GCLFeatureFromMBGLFeature(feature);
        return shape;
    }

    GCLShape <GCLFeature> * operator()(const mbgl::FeatureCollection &collection) const {
        NSMutableArray *shapes = [NSMutableArray arrayWithCapacity:collection.size()];
        for (const auto &feature : collection) {
            [shapes addObject:GCLFeatureFromMBGLFeature(feature)];
        }
        return [GCLShapeCollectionFeature shapeCollectionWithShapes:shapes];
    }
};

NS_ARRAY_OF(GCLShape <GCLFeature> *) *GCLFeaturesFromMBGLFeatures(const std::vector<mbgl::Feature> &features) {
    NSMutableArray *shapes = [NSMutableArray arrayWithCapacity:features.size()];
    for (const auto &feature : features) {
        [shapes addObject:GCLFeatureFromMBGLFeature(feature)];
    }
    return shapes;
}

id <GCLFeature> GCLFeatureFromMBGLFeature(const mbgl::Feature &feature) {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:feature.properties.size()];
    for (auto &pair : feature.properties) {
        auto &value = pair.second;
        ValueEvaluator evaluator;
        attributes[@(pair.first.c_str())] = mbgl::Value::visit(value, evaluator);
    }
    GeometryEvaluator<double> evaluator;
    GCLShape <GCLFeature> *shape = mapbox::geometry::geometry<double>::visit(feature.geometry, evaluator);
    if (feature.id) {
        shape.identifier = mbgl::FeatureIdentifier::visit(*feature.id, ValueEvaluator());
    }
    shape.attributes = attributes;

    return shape;
}

GCLShape* GCLShapeFromGeoJSON(const mapbox::geojson::geojson &geojson) {
    GeoJSONEvaluator<double> evaluator;
    GCLShape *shape = mapbox::geojson::geojson::visit(geojson, evaluator);
    return shape;
}

mbgl::Feature mbglFeature(mbgl::Feature feature, id identifier, NSDictionary *attributes)
{
    if (identifier) {
        NSExpression *identifierExpression = [NSExpression expressionForConstantValue:identifier];
        feature.id = [identifierExpression gcl_featureIdentifier];
    }
    feature.properties = [attributes gcl_propertyMap];
    return feature;
}

NS_DICTIONARY_OF(NSString *, id) *NSDictionaryFeatureForGeometry(NSDictionary *geometry, NSDictionary *attributes, id identifier) {
    NSMutableDictionary *feature = [@{@"type": @"Feature",
                                      @"properties": (attributes) ?: [NSNull null],
                                      @"geometry": geometry} mutableCopy];
    feature[@"id"] = identifier;
    return [feature copy];
}
