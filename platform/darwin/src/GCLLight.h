// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import <CoreLocation/CoreLocation.h>

#import "GCLFoundation.h"
#import "GCLStyleValue.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Whether extruded geometries are lit relative to the map or viewport.
 */
typedef NS_ENUM(NSUInteger, GCLLightAnchor) {
    /**
     The position of the light source is aligned to the rotation of the map.
     */
    GCLLightAnchorMap,
    /**
     The position of the light source is aligned to the rotation of the
     viewport.
     */
    GCLLightAnchorViewport,
};

/**
 A structure containing information about the position of the light source
 relative to lit geometries.
 */
typedef struct GCLSphericalPosition {
    /** Distance from the center of the base of an object to its light. */
    CGFloat radial;
    /** Position of the light relative to 0° (0° when `GCLLight.anchor` is set to viewport corresponds
     to the top of the viewport, or 0° when `GCLLight.anchor` is set to map corresponds to due north,
     and degrees proceed clockwise). */
    CLLocationDirection azimuthal;
    /** Indicates the height of the light (from 0°, directly above, to 180°, directly below). */
    CLLocationDirection polar;
} GCLSphericalPosition;

/**
 Creates a new `GCLSphericalPosition` from the given radial, azimuthal, polar.
 
 @param radial The radial coordinate.
 @param azimuthal The azimuthal angle.
 @param polar The polar angle.
 
 @return Returns a `GCLSphericalPosition` struct containing the position attributes.
 */
NS_INLINE GCLSphericalPosition GCLSphericalPositionMake(CGFloat radial, CLLocationDirection azimuthal, CLLocationDirection polar) {
    GCLSphericalPosition position;
    position.radial = radial;
    position.azimuthal = azimuthal;
    position.polar = polar;
    
    return position;
}

/**
 An `GCLLight` object represents the light source for extruded geometries in `GCLStyle`.
 */
GCL_EXPORT
@interface GCLLight : NSObject

/**
 Whether extruded geometries are lit relative to the map or viewport.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLLightAnchorViewport`.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`

 This property corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-js/style-spec/#light-anchor"><code>anchor</code></a>
 light property in the Mapbox Style Specification.
 */
@property (nonatomic) GCLStyleValue<NSValue *> *anchor;

/**
 Position of the `GCLLight` source relative to lit (extruded) geometries, in a
 `GCLSphericalPosition` struct [radial coordinate, azimuthal angle, polar angle]
 where radial indicates the distance from the center of the base of an object to
 its light, azimuthal indicates the position of the light relative to 0° (0°
 when `GCLLight.anchor` is set to `GCLLightAnchorViewport` corresponds to the
 top of the viewport, or 0° when `GCLLight.anchor` is set to `GCLLightAnchorMap`
 corresponds to due north, and degrees proceed clockwise), and polar indicates
 the height of the light (from 0°, directly above, to 180°, directly below).
 
 The default value of this property is an `GCLStyleValue` object containing an
 `GCLSphericalPosition` struct set to 1.15 radial, 210 azimuthal and 30 polar.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`

 This property corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-js/style-spec/#light-position"><code>position</code></a>
 light property in the Mapbox Style Specification.
 */
@property (nonatomic) GCLStyleValue<NSValue *> *position;

/**
 The transition affecting any changes to this layer’s `position` property.

 This property corresponds to the `position-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition positionTransition;

#if TARGET_OS_IPHONE
/**
 Color tint for lighting extruded geometries.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.whiteColor`.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`

 This property corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-js/style-spec/#light-color"><code>color</code></a>
 light property in the Mapbox Style Specification.
 */
@property (nonatomic) GCLStyleValue<UIColor *> *color;
#else
/**
 Color tint for lighting extruded geometries.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.whiteColor`.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`

 This property corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-js/style-spec/#light-color"><code>color</code></a>
 light property in the Mapbox Style Specification.
 */
@property (nonatomic) GCLStyleValue<NSColor *> *color;
#endif

/**
 The transition affecting any changes to this layer’s `color` property.

 This property corresponds to the `color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition colorTransition;

/**
 Intensity of lighting (on a scale from 0 to 1). Higher numbers will present as
 more extreme contrast.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0.5`.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`

 This property corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-js/style-spec/#light-intensity"><code>intensity</code></a>
 light property in the Mapbox Style Specification.
 */
@property (nonatomic) GCLStyleValue<NSNumber *> *intensity;

/**
 The transition affecting any changes to this layer’s `intensity` property.

 This property corresponds to the `intensity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition intensityTransition;


@end

NS_ASSUME_NONNULL_END
