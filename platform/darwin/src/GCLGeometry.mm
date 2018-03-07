#import "GCLGeometry_Private.h"

#import "GCLFoundation.h"

#import <mbgl/util/projection.hpp>

#if !TARGET_OS_IPHONE && !TARGET_OS_SIMULATOR
#import <Cocoa/Cocoa.h>
#endif

/** Vertical field of view, measured in degrees, for determining the altitude
    of the viewpoint.

    TransformState::getProjMatrix() has a variable vertical field of view that
    defaults to 2 arctan ⅓ rad ≈ 36.9° but MapKit uses a vertical field of view of 30°.
    flyTo() assumes a field of view of 2 arctan ½ rad. */
const CLLocationDegrees GCLAngularFieldOfView = 30;

const GCLCoordinateSpan GCLCoordinateSpanZero = {0, 0};

CGRect GCLExtendRect(CGRect rect, CGPoint point) {
    if (point.x < rect.origin.x) {
        rect.size.width += rect.origin.x - point.x;
        rect.origin.x = point.x;
    }
    if (point.x > rect.origin.x + rect.size.width) {
        rect.size.width += point.x - (rect.origin.x + rect.size.width);
    }
    if (point.y < rect.origin.y) {
        rect.size.height += rect.origin.y - point.y;
        rect.origin.y = point.y;
    }
    if (point.y > rect.origin.y + rect.size.height) {
        rect.size.height += point.y - (rect.origin.y + rect.size.height);
    }
    return rect;
}

mbgl::LatLng GCLLatLngFromLocationCoordinate2D(CLLocationCoordinate2D coordinate) {
    try {
        return mbgl::LatLng(coordinate.latitude, coordinate.longitude);
    } catch (std::domain_error &error) {
        [NSException raise:NSInvalidArgumentException format:@"%s", error.what()];
        return {};
    }
}

GCL_EXPORT
CLLocationDistance GCLAltitudeForZoomLevel(double zoomLevel, CGFloat pitch, CLLocationDegrees latitude, CGSize size) {
    CLLocationDistance metersPerPixel = mbgl::Projection::getMetersPerPixelAtLatitude(latitude, zoomLevel);
    CLLocationDistance metersTall = metersPerPixel * size.height;
    CLLocationDistance altitude = metersTall / 2 / std::tan(GCLRadiansFromDegrees(GCLAngularFieldOfView) / 2.);
    return altitude * std::sin(M_PI_2 - GCLRadiansFromDegrees(pitch)) / std::sin(M_PI_2);
}

GCL_EXPORT
double GCLZoomLevelForAltitude(CLLocationDistance altitude, CGFloat pitch, CLLocationDegrees latitude, CGSize size) {
    CLLocationDistance eyeAltitude = altitude / std::sin(M_PI_2 - GCLRadiansFromDegrees(pitch)) * std::sin(M_PI_2);
    CLLocationDistance metersTall = eyeAltitude * 2 * std::tan(GCLRadiansFromDegrees(GCLAngularFieldOfView) / 2.);
    CLLocationDistance metersPerPixel = metersTall / size.height;
    CGFloat mapPixelWidthAtZoom = std::cos(GCLRadiansFromDegrees(latitude)) * mbgl::util::M2PI * mbgl::util::EARTH_RADIUS_M / metersPerPixel;
    return ::log2(mapPixelWidthAtZoom / mbgl::util::tileSize);
}

GCLRadianDistance GCLDistanceBetweenRadianCoordinates(GCLRadianCoordinate2D from, GCLRadianCoordinate2D to) {
    double a = pow(sin((to.latitude - from.latitude) / 2), 2)
        + pow(sin((to.longitude - from.longitude) / 2), 2) * cos(from.latitude) * cos(to.latitude);
    
    return 2 * atan2(sqrt(a), sqrt(1 - a));
}

GCLRadianDirection GCLRadianCoordinatesDirection(GCLRadianCoordinate2D from, GCLRadianCoordinate2D to) {
    double a = sin(to.longitude - from.longitude) * cos(to.latitude);
    double b = cos(from.latitude) * sin(to.latitude)
    - sin(from.latitude) * cos(to.latitude) * cos(to.longitude - from.longitude);
    return atan2(a, b);
}

GCLRadianCoordinate2D GCLRadianCoordinateAtDistanceFacingDirection(GCLRadianCoordinate2D coordinate,
                                                                   GCLRadianDistance distance,
                                                                   GCLRadianDirection direction) {
    double otherLatitude = asin(sin(coordinate.latitude) * cos(distance)
                                + cos(coordinate.latitude) * sin(distance) * cos(direction));
    double otherLongitude = coordinate.longitude + atan2(sin(direction) * sin(distance) * cos(coordinate.latitude),
                                                         cos(distance) - sin(coordinate.latitude) * sin(otherLatitude));
    return GCLRadianCoordinate2DMake(otherLatitude, otherLongitude);
}

CLLocationDirection GCLDirectionBetweenCoordinates(CLLocationCoordinate2D firstCoordinate, CLLocationCoordinate2D secondCoordinate) {
    // Ported from https://github.com/mapbox/turf-swift/blob/857e2e8060678ef4a7a9169d4971b0788fdffc37/Turf/Turf.swift#L23-L31
    GCLRadianCoordinate2D firstRadianCoordinate = GCLRadianCoordinateFromLocationCoordinate(firstCoordinate);
    GCLRadianCoordinate2D secondRadianCoordinate = GCLRadianCoordinateFromLocationCoordinate(secondCoordinate);
    
    CGFloat a = sin(secondRadianCoordinate.longitude - firstRadianCoordinate.longitude) * cos(secondRadianCoordinate.latitude);
    CGFloat b = (cos(firstRadianCoordinate.latitude) * sin(secondRadianCoordinate.latitude)
                 - sin(firstRadianCoordinate.latitude) * cos(secondRadianCoordinate.latitude) * cos(secondRadianCoordinate.longitude - firstRadianCoordinate.longitude));
    GCLRadianDirection radianDirection = atan2(a, b);
    return radianDirection * 180 / M_PI;
}

CGPoint GCLPointRounded(CGPoint point) {
#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
    CGFloat scaleFactor = [UIScreen instancesRespondToSelector:@selector(nativeScale)] ? [UIScreen mainScreen].nativeScale : [UIScreen mainScreen].scale;
#elif TARGET_OS_MAC
    CGFloat scaleFactor = [NSScreen mainScreen].backingScaleFactor;
#endif
    return CGPointMake(round(point.x * scaleFactor) / scaleFactor, round(point.y * scaleFactor) / scaleFactor);
}
