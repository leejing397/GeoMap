#import "GCLShape.h"
#import <mbgl/util/geometry.hpp>
#import <mbgl/util/geo.hpp>
#import <mbgl/util/geojson.hpp>

bool operator==(const CLLocationCoordinate2D lhs, const CLLocationCoordinate2D rhs);

@interface GCLShape (Private)

/**
 Returns an `mbgl::GeoJSON` representation of the `GCLShape`.
 */
- (mbgl::GeoJSON)geoJSONObject;

/**
 Returns an `mbgl::Geometry<double>` representation of the `GCLShape`.
 */
- (mbgl::Geometry<double>)geometryObject;

/**
 Returns a dictionary with the GeoJSON geometry member object.
 */
- (NSDictionary *)geoJSONDictionary;

@end
