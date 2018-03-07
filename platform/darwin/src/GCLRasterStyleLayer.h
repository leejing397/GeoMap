// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLFoundation.h"
#import "GCLStyleValue.h"
#import "GCLForegroundStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 An `GCLRasterStyleLayer` is a style layer that renders raster tiles on the map.
 
 Use a raster style layer to configure the color parameters of raster tiles
 loaded by an `GCLRasterSource` object. For example, you could use a raster
 style layer to render <a href="https://www.mapbox.com/satellite/">Mapbox
 Satellite</a> imagery, a <a
 href="https://www.mapbox.com/help/define-tileset/#raster-tilesets">raster tile
 set</a> uploaded to Mapbox Studio, or a raster map authored in <a
 href="https://tilemill-project.github.io/tilemill/">TileMill</a>, the classic
 Mapbox Editor, or Mapbox Studio Classic.

 You can access an existing raster style layer using the
 `-[GCLStyle layerWithIdentifier:]` method if you know its identifier;
 otherwise, find it using the `GCLStyle.layers` property. You can also create a
 new raster style layer and add it to the style using a method such as
 `-[GCLStyle addLayer:]`.

 ### Example

 ```swift
 let layer = GCLRasterStyleLayer(identifier: "clouds", source: source)
 layer.rasterOpacity = GCLStyleValue(rawValue: 0.5)
 mapView.style?.addLayer(layer)
 ```
 */
GCL_EXPORT
@interface GCLRasterStyleLayer : GCLForegroundStyleLayer

/**
 Returns a raster style layer initialized with an identifier and source.

 After initializing and configuring the style layer, add it to a map view’s
 style using the `-[GCLStyle addLayer:]` or
 `-[GCLStyle insertLayer:belowLayer:]` method.

 @param identifier A string that uniquely identifies the source in the style to
    which it is added.
 @param source The source from which to obtain the data to style. If the source
    has not yet been added to the current style, the behavior is undefined.
 @return An initialized foreground style layer.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier source:(GCLSource *)source;

#pragma mark - Accessing the Paint Attributes

/**
 Increase or reduce the brightness of the image. The value is the maximum
 brightness.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-raster-brightness-max"><code>raster-brightness-max</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *maximumRasterBrightness;

/**
 The transition affecting any changes to this layer’s `maximumRasterBrightness` property.

 This property corresponds to the `raster-brightness-max-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition maximumRasterBrightnessTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *rasterBrightnessMax __attribute__((unavailable("Use maximumRasterBrightness instead.")));

/**
 Increase or reduce the brightness of the image. The value is the minimum
 brightness.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-raster-brightness-min"><code>raster-brightness-min</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *minimumRasterBrightness;

/**
 The transition affecting any changes to this layer’s `minimumRasterBrightness` property.

 This property corresponds to the `raster-brightness-min-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition minimumRasterBrightnessTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *rasterBrightnessMin __attribute__((unavailable("Use minimumRasterBrightness instead.")));

/**
 Increase or reduce the contrast of the image.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *rasterContrast;

/**
 The transition affecting any changes to this layer’s `rasterContrast` property.

 This property corresponds to the `raster-contrast-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition rasterContrastTransition;

/**
 Fade duration when a new tile is added.
 
 This property is measured in milliseconds.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `300`. Set this property to `nil` to
 reset it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *rasterFadeDuration;

/**
 The transition affecting any changes to this layer’s `rasterFadeDuration` property.

 This property corresponds to the `raster-fade-duration-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition rasterFadeDurationTransition;

/**
 Rotates hues around the color wheel.
 
 This property is measured in degrees.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-raster-hue-rotate"><code>raster-hue-rotate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *rasterHueRotation;

/**
 The transition affecting any changes to this layer’s `rasterHueRotation` property.

 This property corresponds to the `raster-hue-rotate-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition rasterHueRotationTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *rasterHueRotate __attribute__((unavailable("Use rasterHueRotation instead.")));

/**
 The opacity at which the image will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *rasterOpacity;

/**
 The transition affecting any changes to this layer’s `rasterOpacity` property.

 This property corresponds to the `raster-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition rasterOpacityTransition;

/**
 Increase or reduce the saturation of the image.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *rasterSaturation;

/**
 The transition affecting any changes to this layer’s `rasterSaturation` property.

 This property corresponds to the `raster-saturation-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition rasterSaturationTransition;

@end

NS_ASSUME_NONNULL_END
