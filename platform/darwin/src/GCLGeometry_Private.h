#import "GCLGeometry.h"

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
#endif

#import <mbgl/util/geo.hpp>
#import <mbgl/util/geometry.hpp>

#import <array>
typedef double GCLLocationRadians;
typedef double GCLRadianDistance;
typedef double GCLRadianDirection;

/** Defines the coordinate by a `GCLRadianCoordinate2D`. */
typedef struct GCLRadianCoordinate2D {
    GCLLocationRadians latitude;
    GCLLocationRadians longitude;
} GCLRadianCoordinate2D;

/**
 Creates a new `GCLRadianCoordinate2D` from the given latitudinal and longitudinal.
 */
NS_INLINE GCLRadianCoordinate2D GCLRadianCoordinate2DMake(GCLLocationRadians latitude, GCLLocationRadians longitude) {
    GCLRadianCoordinate2D radianCoordinate;
    radianCoordinate.latitude = latitude;
    radianCoordinate.longitude = longitude;
    return radianCoordinate;
}

/// Returns the smallest rectangle that contains both the given rectangle and
/// the given point.
CGRect GCLExtendRect(CGRect rect, CGPoint point);

mbgl::LatLng GCLLatLngFromLocationCoordinate2D(CLLocationCoordinate2D coordinate);

NS_INLINE mbgl::Point<double> GCLPointFromLocationCoordinate2D(CLLocationCoordinate2D coordinate) {
    return mbgl::Point<double>(coordinate.longitude, coordinate.latitude);
}

NS_INLINE CLLocationCoordinate2D GCLLocationCoordinate2DFromPoint(mbgl::Point<double> point) {
    return CLLocationCoordinate2DMake(point.y, point.x);
}

NS_INLINE CLLocationCoordinate2D GCLLocationCoordinate2DFromLatLng(mbgl::LatLng latLng) {
    return CLLocationCoordinate2DMake(latLng.latitude(), latLng.longitude());
}

NS_INLINE GCLCoordinateBounds GCLCoordinateBoundsFromLatLngBounds(mbgl::LatLngBounds latLngBounds) {
    return GCLCoordinateBoundsMake(GCLLocationCoordinate2DFromLatLng(latLngBounds.southwest()),
                                   GCLLocationCoordinate2DFromLatLng(latLngBounds.northeast()));
}

NS_INLINE mbgl::LatLngBounds GCLLatLngBoundsFromCoordinateBounds(GCLCoordinateBounds coordinateBounds) {
    return mbgl::LatLngBounds::hull(GCLLatLngFromLocationCoordinate2D(coordinateBounds.sw),
                                    GCLLatLngFromLocationCoordinate2D(coordinateBounds.ne));
}

NS_INLINE std::array<mbgl::LatLng, 4> GCLLatLngArrayFromCoordinateQuad(GCLCoordinateQuad quad) {
    return { GCLLatLngFromLocationCoordinate2D(quad.topLeft),
    GCLLatLngFromLocationCoordinate2D(quad.topRight),
    GCLLatLngFromLocationCoordinate2D(quad.bottomRight),
    GCLLatLngFromLocationCoordinate2D(quad.bottomLeft) };
}

NS_INLINE GCLCoordinateQuad GCLCoordinateQuadFromLatLngArray(std::array<mbgl::LatLng, 4> quad) {
    return { GCLLocationCoordinate2DFromLatLng(quad[0]),
    GCLLocationCoordinate2DFromLatLng(quad[3]),
    GCLLocationCoordinate2DFromLatLng(quad[2]),
    GCLLocationCoordinate2DFromLatLng(quad[1]) };
}

#if TARGET_OS_IPHONE
NS_INLINE mbgl::EdgeInsets GCLEdgeInsetsFromNSEdgeInsets(UIEdgeInsets insets) {
    return { insets.top, insets.left, insets.bottom, insets.right };
}
#else
NS_INLINE mbgl::EdgeInsets GCLEdgeInsetsFromNSEdgeInsets(NSEdgeInsets insets) {
    return { insets.top, insets.left, insets.bottom, insets.right };
}
#endif

/** Converts a map zoom level to a camera altitude.

    @param zoomLevel The zoom level to convert.
    @param pitch The camera pitch, measured in degrees.
    @param latitude The latitude of the point at the center of the viewport.
    @param size The size of the viewport.
    @return An altitude measured in meters. */
CLLocationDistance GCLAltitudeForZoomLevel(double zoomLevel, CGFloat pitch, CLLocationDegrees latitude, CGSize size);

/** Converts a camera altitude to a map zoom level.

    @param altitude The altitude to convert, measured in meters.
    @param pitch The camera pitch, measured in degrees.
    @param latitude The latitude of the point at the center of the viewport.
    @param size The size of the viewport.
    @return A zero-based zoom level. */
double GCLZoomLevelForAltitude(CLLocationDistance altitude, CGFloat pitch, CLLocationDegrees latitude, CGSize size);

/** Returns GCLRadianCoordinate2D, converted from CLLocationCoordinate2D. */
NS_INLINE GCLRadianCoordinate2D GCLRadianCoordinateFromLocationCoordinate(CLLocationCoordinate2D locationCoordinate) {
    return GCLRadianCoordinate2DMake(GCLRadiansFromDegrees(locationCoordinate.latitude),
                                     GCLRadiansFromDegrees(locationCoordinate.longitude));
}

/**
 Returns the distance in radians given two coordinates.
 */
GCLRadianDistance GCLDistanceBetweenRadianCoordinates(GCLRadianCoordinate2D from, GCLRadianCoordinate2D to);

/**
 Returns direction in radians given two coordinates.
 */
GCLRadianDirection GCLRadianCoordinatesDirection(GCLRadianCoordinate2D from, GCLRadianCoordinate2D to);

/**
 Returns a coordinate at a given distance and direction away from coordinate.
 */
GCLRadianCoordinate2D GCLRadianCoordinateAtDistanceFacingDirection(GCLRadianCoordinate2D coordinate,
                                                                   GCLRadianDistance distance,
                                                                   GCLRadianDirection direction);

/**
 Returns the direction from one coordinate to another.
 */
CLLocationDirection GCLDirectionBetweenCoordinates(CLLocationCoordinate2D firstCoordinate, CLLocationCoordinate2D secondCoordinate);

CGPoint GCLPointRounded(CGPoint point);
