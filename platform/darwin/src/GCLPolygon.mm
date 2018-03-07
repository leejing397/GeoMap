#import "GCLPolygon.h"

#import "GCLMultiPoint_Private.h"
#import "GCLGeometry_Private.h"

#import "GCLPolygon+GCLAdditions.h"

#import <mbgl/util/geojson.hpp>
#import <mapbox/polylabel.hpp>

@implementation GCLPolygon

@dynamic overlayBounds;

+ (instancetype)polygonWithCoordinates:(const CLLocationCoordinate2D *)coords count:(NSUInteger)count {
    return [self polygonWithCoordinates:coords count:count interiorPolygons:nil];
}

+ (instancetype)polygonWithCoordinates:(const CLLocationCoordinate2D *)coords count:(NSUInteger)count interiorPolygons:(NSArray<GCLPolygon *> *)interiorPolygons {
    return [[self alloc] initWithCoordinates:coords count:count interiorPolygons:interiorPolygons];
}

- (instancetype)initWithCoordinates:(const CLLocationCoordinate2D *)coords count:(NSUInteger)count interiorPolygons:(NSArray<GCLPolygon *> *)interiorPolygons {
    if (self = [super initWithCoordinates:coords count:count]) {
        if (interiorPolygons.count) {
            _interiorPolygons = interiorPolygons;
        }
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        _interiorPolygons = [decoder decodeObjectOfClass:[NSArray class] forKey:@"interiorPolygons"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:self.interiorPolygons forKey:@"interiorPolygons"];
}

- (BOOL)isEqual:(id)other {
    if (self == other) return YES;
    if (![other isKindOfClass:[GCLPolygon class]]) return NO;

    GCLPolygon *otherPolygon = (GCLPolygon *)other;
    return ([super isEqual:otherPolygon] &&
            [[self geoJSONDictionary] isEqualToDictionary:[otherPolygon geoJSONDictionary]]);
}

- (NSUInteger)hash {
    return [super hash] + [[self geoJSONDictionary] hash];
}

- (CLLocationCoordinate2D)coordinate {
    // pole of inaccessibility
    auto poi = mapbox::polylabel([self polygon]);
    
    return GCLLocationCoordinate2DFromPoint(poi);
}

- (mbgl::LinearRing<double>)ring {
    NSUInteger count = self.pointCount;
    CLLocationCoordinate2D *coordinates = self.coordinates;

    mbgl::LinearRing<double> result;
    result.reserve(self.pointCount);
    for (NSUInteger i = 0; i < count; i++) {
        result.push_back(mbgl::Point<double>(coordinates[i].longitude, coordinates[i].latitude));
    }
    return result;
}

- (mbgl::Polygon<double>)polygon {
    mbgl::Polygon<double> geometry;
    geometry.push_back(self.ring);
    for (GCLPolygon *polygon in self.interiorPolygons) {
        geometry.push_back(polygon.ring);
    }
    return geometry;
}

- (mbgl::Geometry<double>)geometryObject {
    return [self polygon];
}

- (mbgl::Annotation)annotationObjectWithDelegate:(id <GCLMultiPointDelegate>)delegate {

    mbgl::FillAnnotation annotation { [self polygon] };
    annotation.opacity = { static_cast<float>([delegate alphaForShapeAnnotation:self]) };
    annotation.outlineColor = { [delegate strokeColorForShapeAnnotation:self] };
    annotation.color = { [delegate fillColorForPolygonAnnotation:self] };

    return annotation;
}

- (NSDictionary *)geoJSONDictionary {
    return @{@"type": @"Polygon",
             @"coordinates": self.gcl_coordinates};
}

@end

@interface GCLMultiPolygon ()

@property (nonatomic, copy, readwrite) NS_ARRAY_OF(GCLPolygon *) *polygons;

@end

@implementation GCLMultiPolygon {
    GCLCoordinateBounds _overlayBounds;
}

@synthesize overlayBounds = _overlayBounds;

+ (instancetype)multiPolygonWithPolygons:(NS_ARRAY_OF(GCLPolygon *) *)polygons {
    return [[self alloc] initWithPolygons:polygons];
}

- (instancetype)initWithPolygons:(NS_ARRAY_OF(GCLPolygon *) *)polygons {
    if (self = [super init]) {
        _polygons = polygons;

        mbgl::LatLngBounds bounds = mbgl::LatLngBounds::empty();

        for (GCLPolygon *polygon in _polygons) {
            bounds.extend(GCLLatLngBoundsFromCoordinateBounds(polygon.overlayBounds));
        }
        _overlayBounds = GCLCoordinateBoundsFromLatLngBounds(bounds);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        _polygons = [decoder decodeObjectOfClass:[NSArray class] forKey:@"polygons"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:_polygons forKey:@"polygons"];
}

- (BOOL)isEqual:(id)other {
    if (self == other) return YES;
    if (![other isKindOfClass:[GCLMultiPolygon class]]) return NO;

    GCLMultiPolygon *otherMultiPolygon = other;
    return [super isEqual:other]
    && [self.polygons isEqualToArray:otherMultiPolygon.polygons];
}

- (NSUInteger)hash {
    NSUInteger hash = [super hash];
    for (GCLPolygon *polygon in self.polygons) {
        hash += [polygon hash];
    }
    return hash;
}

- (CLLocationCoordinate2D)coordinate {
    GCLPolygon *firstPolygon = self.polygons.firstObject;
    
    return firstPolygon.coordinate;
}

- (BOOL)intersectsOverlayBounds:(GCLCoordinateBounds)overlayBounds {
    return GCLCoordinateBoundsIntersectsCoordinateBounds(_overlayBounds, overlayBounds);
}

- (mbgl::MultiPolygon<double>)multiPolygon {
    mbgl::MultiPolygon<double> multiPolygon;
    multiPolygon.reserve(self.polygons.count);
    for (GCLPolygon *polygon in self.polygons) {
        mbgl::Polygon<double> geometry;
        geometry.push_back(polygon.ring);
        for (GCLPolygon *interiorPolygon in polygon.interiorPolygons) {
            geometry.push_back(interiorPolygon.ring);
        }
        multiPolygon.push_back(geometry);
    }
    return multiPolygon;
}

- (mbgl::Geometry<double>)geometryObject {
    return [self multiPolygon];
}

- (NSDictionary *)geoJSONDictionary {
    NSMutableArray *coordinates = [[NSMutableArray alloc] initWithCapacity:self.polygons.count];
    for (GCLPolygonFeature *feature in self.polygons) {
        [coordinates addObject: feature.gcl_coordinates];
    }
    return @{@"type": @"MultiPolygon",
             @"coordinates": coordinates};
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; title = %@, subtitle: = %@, count = %lu; bounds = %@>",
            NSStringFromClass([self class]), (void *)self,
            self.title ? [NSString stringWithFormat:@"\"%@\"", self.title] : self.title,
            self.subtitle ? [NSString stringWithFormat:@"\"%@\"", self.subtitle] : self.subtitle,
            (unsigned long)self.polygons.count,
            GCLStringFromCoordinateBounds(self.overlayBounds)];
}

@end
