// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLFoundation.h"
#import "GCLStyleValue.h"
#import "GCLStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 An `GCLBackgroundStyleLayer` is a style layer that covers the entire map. Use a
 background style layer to configure a color or pattern to show below all other
 map content. If the style’s other layers use the Mapbox Streets source, the
 background style layer is responsible for drawing land, whereas the oceans and
 other bodies of water are drawn by `GCLFillStyleLayer` objects.
 
 A background style layer is typically the bottommost layer in a style, because
 it covers the entire map and can occlude any layers below it. You can therefore
 access it by getting the last item in the `GCLStyle.layers` array.
 
 If the background style layer is transparent or omitted from the style, any
 portion of the map view that does not show another style layer is transparent.
 */
GCL_EXPORT
@interface GCLBackgroundStyleLayer : GCLStyleLayer

/**
Returns a background style layer initialized with an identifier.

After initializing and configuring the style layer, add it to a map view’s
style using the `-[GCLStyle addLayer:]` or
`-[GCLStyle insertLayer:belowLayer:]` method.

@param identifier A string that uniquely identifies the source in the style to
which it is added.
*/
- (instancetype)initWithIdentifier:(NSString *)identifier;

#pragma mark - Accessing the Paint Attributes

#if TARGET_OS_IPHONE
/**
 The color with which the background will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `backgroundPattern` is set to
 `nil`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *backgroundColor;
#else
/**
 The color with which the background will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `backgroundPattern` is set to
 `nil`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *backgroundColor;
#endif

/**
 The transition affecting any changes to this layer’s `backgroundColor` property.

 This property corresponds to the `background-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition backgroundColorTransition;

/**
 The opacity at which the background will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *backgroundOpacity;

/**
 The transition affecting any changes to this layer’s `backgroundOpacity` property.

 This property corresponds to the `background-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition backgroundOpacityTransition;

/**
 Name of image in style images to use for drawing an image background. For
 seamless patterns, image width and height must be a factor of two (2, 4, 8,
 ..., 512).
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSString *> *backgroundPattern;

/**
 The transition affecting any changes to this layer’s `backgroundPattern` property.

 This property corresponds to the `background-pattern-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition backgroundPatternTransition;

@end

NS_ASSUME_NONNULL_END
