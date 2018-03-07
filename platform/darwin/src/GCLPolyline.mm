#import "GCLPolyline.h"

#import "GCLMultiPoint_Private.h"
#import "GCLGeometry_Private.h"

#import "GCLPolyline+GCLAdditions.h"

#import <mbgl/util/geojson.hpp>
#import <mapbox/polylabel.hpp>

@implementation GCLPolyline

@dynamic overlayBounds;

+ (instancetype)polylineWithCoordinates:(const CLLocationCoordinate2D *)coords
                                  count:(NSUInteger)count
{
    return [[self alloc] initWithCoordinates:coords count:count];
}

- (mbgl::LineString<double>)lineString {
    NSUInteger count = self.pointCount;
    CLLocationCoordinate2D *coordinates = self.coordinates;

    mbgl::LineString<double> geometry;
    geometry.reserve(self.pointCount);
    for (NSUInteger i = 0; i < count; i++) {
        geometry.push_back(mbgl::Point<double>(coordinates[i].longitude, coordinates[i].latitude));
    }

    return geometry;
}

- (mbgl::Annotation)annotationObjectWithDelegate:(id <GCLMultiPointDelegate>)delegate {
    mbgl::LineAnnotation annotation { [self lineString] };
    annotation.opacity = { static_cast<float>([delegate alphaForShapeAnnotation:self]) };
    annotation.color = { [delegate strokeColorForShapeAnnotation:self] };
    annotation.width = { static_cast<float>([delegate lineWidthForPolylineAnnotation:self]) };

    return annotation;
}

- (mbgl::Geometry<double>)geometryObject {
    return [self lineString];
}

- (NSDictionary *)geoJSONDictionary {
    return @{@"type": @"LineString",
             @"coordinates": self.gcl_coordinates};
}

- (BOOL)isEqual:(id)other {
    return self == other || ([other isKindOfClass:[GCLPolyline class]] && [super isEqual:other]);
}

- (CLLocationCoordinate2D)coordinate {
    NSUInteger count = self.pointCount;
    NSAssert(count > 0, @"Polyline must have coordinates");

    CLLocationCoordinate2D *coordinates = self.coordinates;
    CLLocationDistance middle = [self length] / 2.0;
    CLLocationDistance traveled = 0.0;
    
    if (count > 1 || middle > traveled) {
        for (NSUInteger i = 0; i < count; i++) {
            
            GCLRadianCoordinate2D from = GCLRadianCoordinateFromLocationCoordinate(coordinates[i]);
            GCLRadianCoordinate2D to = GCLRadianCoordinateFromLocationCoordinate(coordinates[i + 1]);
            
            if (traveled >= middle) {
                double overshoot = middle - traveled;
                if (overshoot == 0) {
                    return coordinates[i];
                }
                to = GCLRadianCoordinateFromLocationCoordinate(coordinates[i - 1]);
                CLLocationDirection direction = [self direction:from to:to] - 180;
                GCLRadianCoordinate2D otherCoordinate = GCLRadianCoordinateAtDistanceFacingDirection(from,
                                                                                                     overshoot/mbgl::util::EARTH_RADIUS_M,
                                                                                                     GCLRadiansFromDegrees(direction));
                return CLLocationCoordinate2DMake(GCLDegreesFromRadians(otherCoordinate.latitude),
                                                  GCLDegreesFromRadians(otherCoordinate.longitude));
            }
            
            traveled += (GCLDistanceBetweenRadianCoordinates(from, to) * mbgl::util::EARTH_RADIUS_M);
            
        }
    }

    return coordinates[count - 1];
}

- (CLLocationDistance)length
{
    CLLocationDistance length = 0.0;
    
    NSUInteger count = self.pointCount;
    CLLocationCoordinate2D *coordinates = self.coordinates;
    
    for (NSUInteger i = 0; i < count - 1; i++) {        
        length += (GCLDistanceBetweenRadianCoordinates(GCLRadianCoordinateFromLocationCoordinate(coordinates[i]),                                                  GCLRadianCoordinateFromLocationCoordinate(coordinates[i + 1])) * mbgl::util::EARTH_RADIUS_M);
    }
    
    return length;
}

- (CLLocationDirection)direction:(GCLRadianCoordinate2D)from to:(GCLRadianCoordinate2D)to
{
    return GCLDegreesFromRadians(GCLRadianCoordinatesDirection(from, to));
}

@end

@interface GCLMultiPolyline ()

@property (nonatomic, copy, readwrite) NS_ARRAY_OF(GCLPolyline *) *polylines;

@end

@implementation GCLMultiPolyline {
    GCLCoordinateBounds _overlayBounds;
}

@synthesize overlayBounds = _overlayBounds;

+ (instancetype)multiPolylineWithPolylines:(NS_ARRAY_OF(GCLPolyline *) *)polylines {
    return [[self alloc] initWithPolylines:polylines];
}

- (instancetype)initWithPolylines:(NS_ARRAY_OF(GCLPolyline *) *)polylines {
    if (self = [super init]) {
        _polylines = polylines;

        mbgl::LatLngBounds bounds = mbgl::LatLngBounds::empty();

        for (GCLPolyline *polyline in _polylines) {
            bounds.extend(GCLLatLngBoundsFromCoordinateBounds(polyline.overlayBounds));
        }
        _overlayBounds = GCLCoordinateBoundsFromLatLngBounds(bounds);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        _polylines = [decoder decodeObjectOfClass:[NSArray class] forKey:@"polylines"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    [coder encodeObject:_polylines forKey:@"polylines"];
}

- (BOOL)isEqual:(id)other
{
    if (self == other) return YES;
    if (![other isKindOfClass:[GCLMultiPolyline class]]) return NO;

    GCLMultiPolyline *otherMultipoline = other;
    return ([super isEqual:otherMultipoline]
            && [self.polylines isEqualToArray:otherMultipoline.polylines]);
}

- (NSUInteger)hash {
    NSUInteger hash = [super hash];
    for (GCLPolyline *polyline in self.polylines) {
        hash += [polyline hash];
    }
    return hash;
}

- (CLLocationCoordinate2D)coordinate {
    GCLPolyline *polyline = self.polylines.firstObject;
    CLLocationCoordinate2D *coordinates = polyline.coordinates;
    NSAssert([polyline pointCount] > 0, @"Polyline must have coordinates");
    CLLocationCoordinate2D firstCoordinate = coordinates[0];

    return firstCoordinate;
}

- (BOOL)intersectsOverlayBounds:(GCLCoordinateBounds)overlayBounds {
    return GCLCoordinateBoundsIntersectsCoordinateBounds(_overlayBounds, overlayBounds);
}

- (mbgl::Geometry<double>)geometryObject {
    mbgl::MultiLineString<double> multiLineString;
    multiLineString.reserve(self.polylines.count);
    for (GCLPolyline *polyline in self.polylines) {
        multiLineString.push_back([polyline lineString]);
    }
    return multiLineString;
}

- (NSDictionary *)geoJSONDictionary {
    NSMutableArray *coordinates = [NSMutableArray array];
    for (GCLPolylineFeature *feature in self.polylines) {
        [coordinates addObject: feature.gcl_coordinates];
    }
    return @{@"type": @"MultiLineString",
             @"coordinates": coordinates};
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; title = %@, subtitle: = %@, count = %lu; bounds = %@>",
            NSStringFromClass([self class]), (void *)self,
            self.title ? [NSString stringWithFormat:@"\"%@\"", self.title] : self.title,
            self.subtitle ? [NSString stringWithFormat:@"\"%@\"", self.subtitle] : self.subtitle,
            (unsigned long)self.polylines.count,
            GCLStringFromCoordinateBounds(self.overlayBounds)];
}

@end
