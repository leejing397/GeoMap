// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLFoundation.h"
#import "GCLStyleValue.h"
#import "GCLVectorStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The display of line endings.

 Values of this type are used in the `GCLLineStyleLayer.lineCap`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLLineCap) {
    /**
     A cap with a squared-off end which is drawn to the exact endpoint of the
     line.
     */
    GCLLineCapButt,
    /**
     A cap with a rounded end which is drawn beyond the endpoint of the line at
     a radius of one-half of the line's width and centered on the endpoint of
     the line.
     */
    GCLLineCapRound,
    /**
     A cap with a squared-off end which is drawn beyond the endpoint of the line
     at a distance of one-half of the line's width.
     */
    GCLLineCapSquare,
};

/**
 The display of lines when joining.

 Values of this type are used in the `GCLLineStyleLayer.lineJoin`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLLineJoin) {
    /**
     A join with a squared-off end which is drawn beyond the endpoint of the
     line at a distance of one-half of the line's width.
     */
    GCLLineJoinBevel,
    /**
     A join with a rounded end which is drawn beyond the endpoint of the line at
     a radius of one-half of the line's width and centered on the endpoint of
     the line.
     */
    GCLLineJoinRound,
    /**
     A join with a sharp, angled corner which is drawn with the outer sides
     beyond the endpoint of the path until they meet.
     */
    GCLLineJoinMiter,
};

/**
 Controls the translation reference point.

 Values of this type are used in the `GCLLineStyleLayer.lineTranslationAnchor`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLLineTranslationAnchor) {
    /**
     The line is translated relative to the map.
     */
    GCLLineTranslationAnchorMap,
    /**
     The line is translated relative to the viewport.
     */
    GCLLineTranslationAnchorViewport,
};

/**
 An `GCLLineStyleLayer` is a style layer that renders one or more stroked
 polylines on the map.
 
 Use a line style layer to configure the visual appearance of polyline or
 multipolyline features in vector tiles loaded by an `GCLVectorSource` object or
 `GCLPolyline`, `GCLPolylineFeature`, `GCLMultiPolyline`, or
 `GCLMultiPolylineFeature` instances in an `GCLShapeSource` object.

 You can access an existing line style layer using the
 `-[GCLStyle layerWithIdentifier:]` method if you know its identifier;
 otherwise, find it using the `GCLStyle.layers` property. You can also create a
 new line style layer and add it to the style using a method such as
 `-[GCLStyle addLayer:]`.

 ### Example

 ```swift
 let layer = GCLLineStyleLayer(identifier: "trails-path", source: trails)
 layer.sourceLayerIdentifier = "trails"
 layer.lineWidth = GCLStyleValue(interpolationMode: .exponential,
                                 cameraStops: [14: GCLStyleValue(rawValue: 2),
                                               18: GCLStyleValue(rawValue: 20)],
                                 options: [.interpolationBase: 1.5])
 layer.lineColor = GCLStyleValue(rawValue: .brown)
 layer.lineCap = GCLStyleValue(rawValue: NSValue(GCLLineCap: .round))
 layer.predicate = NSPredicate(format: "%K == %@", "trail-type", "mountain-biking")
 mapView.style?.addLayer(layer)
 ```
 */
GCL_EXPORT
@interface GCLLineStyleLayer : GCLVectorStyleLayer

/**
 Returns a line style layer initialized with an identifier and source.

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

#pragma mark - Accessing the Layout Attributes

/**
 The display of line endings.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLLineCapButt`. Set this property to `nil` to
 reset it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *lineCap;

/**
 The display of lines when joining.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLLineJoinMiter`. Set this property to `nil` to
 reset it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 * `GCLSourceStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
   * `GCLInterpolationModeIdentity`
 * `GCLCompositeStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *lineJoin;

/**
 Used to automatically convert miter joins to bevel joins for sharp angles.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `2`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `lineJoin` is set to an
 `GCLStyleValue` object containing an `NSValue` object containing
 `GCLLineJoinMiter`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *lineMiterLimit;

/**
 Used to automatically convert round joins to miter joins for shallow angles.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1.05`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `lineJoin` is set to an
 `GCLStyleValue` object containing an `NSValue` object containing
 `GCLLineJoinRound`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *lineRoundLimit;

#pragma mark - Accessing the Paint Attributes

/**
 Blur applied to the line, in points.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 * `GCLSourceStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
   * `GCLInterpolationModeIdentity`
 * `GCLCompositeStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *lineBlur;

/**
 The transition affecting any changes to this layer’s `lineBlur` property.

 This property corresponds to the `line-blur-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition lineBlurTransition;

#if TARGET_OS_IPHONE
/**
 The color with which the line will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `linePattern` is set to `nil`.
 Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 * `GCLSourceStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
   * `GCLInterpolationModeIdentity`
 * `GCLCompositeStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
 */
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *lineColor;
#else
/**
 The color with which the line will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `linePattern` is set to `nil`.
 Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 * `GCLSourceStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
   * `GCLInterpolationModeIdentity`
 * `GCLCompositeStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *lineColor;
#endif

/**
 The transition affecting any changes to this layer’s `lineColor` property.

 This property corresponds to the `line-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition lineColorTransition;

/**
 Specifies the lengths of the alternating dashes and gaps that form the dash
 pattern. The lengths are later scaled by the line width. To convert a dash
 length to points, multiply the length by the current line width.
 
 This property is measured in line widths.
 
 This property is only applied to the style if `linePattern` is set to `nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-line-dasharray"><code>line-dasharray</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSArray<NSNumber *> *> *lineDashPattern;

/**
 The transition affecting any changes to this layer’s `lineDashPattern` property.

 This property corresponds to the `line-dasharray-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition lineDashPatternTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSArray<NSNumber *> *> *lineDasharray __attribute__((unavailable("Use lineDashPattern instead.")));

/**
 Draws a line casing outside of a line's actual path. Value indicates the width
 of the inner gap.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 * `GCLSourceStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
   * `GCLInterpolationModeIdentity`
 * `GCLCompositeStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *lineGapWidth;

/**
 The transition affecting any changes to this layer’s `lineGapWidth` property.

 This property corresponds to the `line-gap-width-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition lineGapWidthTransition;

/**
 The line's offset. For linear features, a positive value offsets the line to
 the right, relative to the direction of the line, and a negative value to the
 left. For polygon features, a positive value results in an inset, and a
 negative value results in an outset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 * `GCLSourceStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
   * `GCLInterpolationModeIdentity`
 * `GCLCompositeStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *lineOffset;

/**
 The transition affecting any changes to this layer’s `lineOffset` property.

 This property corresponds to the `line-offset-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition lineOffsetTransition;

/**
 The opacity at which the line will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 * `GCLSourceStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
   * `GCLInterpolationModeIdentity`
 * `GCLCompositeStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *lineOpacity;

/**
 The transition affecting any changes to this layer’s `lineOpacity` property.

 This property corresponds to the `line-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition lineOpacityTransition;

/**
 Name of image in style images to use for drawing image lines. For seamless
 patterns, image width must be a factor of two (2, 4, 8, ..., 512).
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSString *> *linePattern;

/**
 The transition affecting any changes to this layer’s `linePattern` property.

 This property corresponds to the `line-pattern-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition linePatternTransition;

#if TARGET_OS_IPHONE
/**
 The geometry's offset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points downward. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-line-translate"><code>line-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *lineTranslation;
#else
/**
 The geometry's offset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points upward. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-line-translate"><code>line-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *lineTranslation;
#endif

/**
 The transition affecting any changes to this layer’s `lineTranslation` property.

 This property corresponds to the `line-translate-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition lineTranslationTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *lineTranslate __attribute__((unavailable("Use lineTranslation instead.")));

/**
 Controls the translation reference point.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLLineTranslationAnchorMap`. Set this property to
 `nil` to reset it to the default value.
 
 This property is only applied to the style if `lineTranslation` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-line-translate-anchor"><code>line-translate-anchor</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *lineTranslationAnchor;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *lineTranslateAnchor __attribute__((unavailable("Use lineTranslationAnchor instead.")));

/**
 Stroke thickness.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 * `GCLSourceStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
   * `GCLInterpolationModeIdentity`
 * `GCLCompositeStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
   * `GCLInterpolationModeCategorical`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *lineWidth;

/**
 The transition affecting any changes to this layer’s `lineWidth` property.

 This property corresponds to the `line-width-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition lineWidthTransition;

@end

/**
 Methods for wrapping an enumeration value for a style layer attribute in an
 `GCLLineStyleLayer` object and unwrapping its raw value.
 */
@interface NSValue (GCLLineStyleLayerAdditions)

#pragma mark Working with Line Style Layer Attribute Values

/**
 Creates a new value object containing the given `GCLLineCap` enumeration.

 @param lineCap The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLLineCap:(GCLLineCap)lineCap;

/**
 The `GCLLineCap` enumeration representation of the value.
 */
@property (readonly) GCLLineCap GCLLineCapValue;

/**
 Creates a new value object containing the given `GCLLineJoin` enumeration.

 @param lineJoin The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLLineJoin:(GCLLineJoin)lineJoin;

/**
 The `GCLLineJoin` enumeration representation of the value.
 */
@property (readonly) GCLLineJoin GCLLineJoinValue;

/**
 Creates a new value object containing the given `GCLLineTranslationAnchor` enumeration.

 @param lineTranslationAnchor The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLLineTranslationAnchor:(GCLLineTranslationAnchor)lineTranslationAnchor;

/**
 The `GCLLineTranslationAnchor` enumeration representation of the value.
 */
@property (readonly) GCLLineTranslationAnchor GCLLineTranslationAnchorValue;

@end

NS_ASSUME_NONNULL_END
