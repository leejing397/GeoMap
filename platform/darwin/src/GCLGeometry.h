#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CGBase.h>

#import "GCLFoundation.h"

NS_ASSUME_NONNULL_BEGIN

/** Defines the area spanned by an `GCLCoordinateBounds`. */
typedef struct __attribute__((objc_boxable)) GCLCoordinateSpan {
    /** Latitudes spanned by an `GCLCoordinateBounds`. */
    CLLocationDegrees latitudeDelta;
    /** Longitudes spanned by an `GCLCoordinateBounds`. */
    CLLocationDegrees longitudeDelta;
} GCLCoordinateSpan;

/**
 Creates a new `GCLCoordinateSpan` from the given latitudinal and longitudinal
 deltas.
 */
NS_INLINE GCLCoordinateSpan GCLCoordinateSpanMake(CLLocationDegrees latitudeDelta, CLLocationDegrees longitudeDelta) {
    GCLCoordinateSpan span;
    span.latitudeDelta = latitudeDelta;
    span.longitudeDelta = longitudeDelta;
    return span;
}

/**
 Returns `YES` if the two coordinate spans represent the same latitudinal change
 and the same longitudinal change.
 */
NS_INLINE BOOL GCLCoordinateSpanEqualToCoordinateSpan(GCLCoordinateSpan span1, GCLCoordinateSpan span2) {
    return (span1.latitudeDelta == span2.latitudeDelta &&
            span1.longitudeDelta == span2.longitudeDelta);
}

/** An area of zero width and zero height. */
extern GCL_EXPORT const GCLCoordinateSpan GCLCoordinateSpanZero;

/** A rectangular area as measured on a two-dimensional map projection. */
typedef struct __attribute__((objc_boxable)) GCLCoordinateBounds {
    /** Coordinate at the southwest corner. */
    CLLocationCoordinate2D sw;
    /** Coordinate at the northeast corner. */
    CLLocationCoordinate2D ne;
} GCLCoordinateBounds;

/** 
 A quadrilateral area as measured on a two-dimensional map projection.
 `GCLCoordinateQuad` differs from `GCLCoordinateBounds` in that it allows
 representation of non-axis aligned bounds and non-rectangular quadrilaterals.
 The coordinates are described in counter clockwise order from top left.
 */
typedef struct GCLCoordinateQuad {
    /** Coordinate at the top left corner. */
    CLLocationCoordinate2D topLeft;
    /** Coordinate at the bottom left corner. */
    CLLocationCoordinate2D bottomLeft;
    /** Coordinate at the bottom right corner. */
    CLLocationCoordinate2D bottomRight;
    /** Coordinate at the top right corner. */
    CLLocationCoordinate2D topRight;
} GCLCoordinateQuad;


/**
 Creates a new `GCLCoordinateBounds` structure from the given southwest and
 northeast coordinates.
 */
NS_INLINE GCLCoordinateBounds GCLCoordinateBoundsMake(CLLocationCoordinate2D sw, CLLocationCoordinate2D ne) {
    GCLCoordinateBounds bounds;
    bounds.sw = sw;
    bounds.ne = ne;
    return bounds;
}

/**
 Creates a new `GCLCoordinateQuad` structure from the given top left,
  bottom left, bottom right, and top right coordinates.
 */
NS_INLINE GCLCoordinateQuad GCLCoordinateQuadMake(CLLocationCoordinate2D topLeft, CLLocationCoordinate2D bottomLeft, CLLocationCoordinate2D bottomRight, CLLocationCoordinate2D topRight) {
    GCLCoordinateQuad quad;
    quad.topLeft = topLeft;
    quad.bottomLeft = bottomLeft;
    quad.bottomRight = bottomRight;
    quad.topRight = topRight;
    return quad;
}

/**
 Creates a new `GCLCoordinateQuad` structure from the given `GCLCoordinateBounds`.
 The returned quad uses the bounds' northeast coordinate as the top right, and the
  southwest coordinate at the bottom left.
 */
NS_INLINE GCLCoordinateQuad GCLCoordinateQuadFromCoordinateBounds(GCLCoordinateBounds bounds) {
    GCLCoordinateQuad quad;
    quad.topLeft = CLLocationCoordinate2DMake(bounds.ne.latitude, bounds.sw.longitude);
    quad.bottomLeft = bounds.sw;
    quad.bottomRight = CLLocationCoordinate2DMake(bounds.sw.latitude, bounds.ne.longitude);
    quad.topRight = bounds.ne;
    return quad;
}

/** Returns `YES` if the two coordinate bounds are equal to each other. */
NS_INLINE BOOL GCLCoordinateBoundsEqualToCoordinateBounds(GCLCoordinateBounds bounds1, GCLCoordinateBounds bounds2) {
    return (bounds1.sw.latitude == bounds2.sw.latitude &&
            bounds1.sw.longitude == bounds2.sw.longitude &&
            bounds1.ne.latitude == bounds2.ne.latitude &&
            bounds1.ne.longitude == bounds2.ne.longitude);
}

/** Returns `YES` if the two coordinate bounds intersect. */
NS_INLINE BOOL GCLCoordinateBoundsIntersectsCoordinateBounds(GCLCoordinateBounds bounds1, GCLCoordinateBounds bounds2) {
    return (bounds1.ne.latitude  > bounds2.sw.latitude  &&
            bounds1.sw.latitude  < bounds2.ne.latitude  &&
            bounds1.ne.longitude > bounds2.sw.longitude &&
            bounds1.sw.longitude < bounds2.ne.longitude);
}

/** Returns `YES` if the coordinate is within the coordinate bounds. */
NS_INLINE BOOL GCLCoordinateInCoordinateBounds(CLLocationCoordinate2D coordinate, GCLCoordinateBounds bounds) {
    return (coordinate.latitude  >= bounds.sw.latitude  &&
            coordinate.latitude  <= bounds.ne.latitude  &&
            coordinate.longitude >= bounds.sw.longitude &&
            coordinate.longitude <= bounds.ne.longitude);
}

/** Returns the area spanned by the coordinate bounds. */
NS_INLINE GCLCoordinateSpan GCLCoordinateBoundsGetCoordinateSpan(GCLCoordinateBounds bounds) {
    return GCLCoordinateSpanMake(bounds.ne.latitude - bounds.sw.latitude,
                                 bounds.ne.longitude - bounds.sw.longitude);
}

/**
 Returns a coordinate bounds with southwest and northeast coordinates that are
 offset from those of the source bounds.
 */
NS_INLINE GCLCoordinateBounds GCLCoordinateBoundsOffset(GCLCoordinateBounds bounds, GCLCoordinateSpan offset) {
    GCLCoordinateBounds offsetBounds = bounds;
    offsetBounds.sw.latitude += offset.latitudeDelta;
    offsetBounds.sw.longitude += offset.longitudeDelta;
    offsetBounds.ne.latitude += offset.latitudeDelta;
    offsetBounds.ne.longitude += offset.longitudeDelta;
    return offsetBounds;
}

/**
 Returns `YES` if the coordinate bounds covers no area.

 @note A bounds may be empty but have a non-zero coordinate span (e.g., when its
    northeast point lies due north of its southwest point).
 */
NS_INLINE BOOL GCLCoordinateBoundsIsEmpty(GCLCoordinateBounds bounds) {
    GCLCoordinateSpan span = GCLCoordinateBoundsGetCoordinateSpan(bounds);
    return span.latitudeDelta == 0 || span.longitudeDelta == 0;
}

/** Returns a formatted string for the given coordinate bounds. */
NS_INLINE NSString *GCLStringFromCoordinateBounds(GCLCoordinateBounds bounds) {
    return [NSString stringWithFormat:@"{ sw = {%.1f, %.1f}, ne = {%.1f, %.1f}}",
            bounds.sw.latitude, bounds.sw.longitude,
            bounds.ne.latitude, bounds.ne.longitude];
}

/** Returns a formatted string for the given coordinate quad. */
NS_INLINE NSString *GCLStringFromCoordinateQuad(GCLCoordinateQuad quad) {
    return [NSString stringWithFormat:@"{ topleft = {%.1f, %.1f}, bottomleft = {%.1f, %.1f}}, bottomright = {%.1f, %.1f}, topright = {%.1f, %.1f}",
            quad.topLeft.latitude, quad.topLeft.longitude,
            quad.bottomLeft.latitude, quad.bottomLeft.longitude,
            quad.bottomRight.latitude, quad.bottomRight.longitude,
            quad.topRight.latitude, quad.topRight.longitude];
}

/** Returns radians, converted from degrees. */
NS_INLINE CGFloat GCLRadiansFromDegrees(CLLocationDegrees degrees) {
    return (CGFloat)(degrees * M_PI) / 180;
}

/** Returns degrees, converted from radians. */
NS_INLINE CLLocationDegrees GCLDegreesFromRadians(CGFloat radians) {
    return radians * 180 / M_PI;
}

NS_ASSUME_NONNULL_END
