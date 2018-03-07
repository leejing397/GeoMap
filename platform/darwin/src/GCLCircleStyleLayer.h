// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLFoundation.h"
#import "GCLStyleValue.h"
#import "GCLVectorStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Orientation of circle when map is pitched.

 Values of this type are used in the `GCLCircleStyleLayer.circlePitchAlignment`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLCirclePitchAlignment) {
    /**
     The circle is aligned to the plane of the map.
     */
    GCLCirclePitchAlignmentMap,
    /**
     The circle is aligned to the plane of the viewport.
     */
    GCLCirclePitchAlignmentViewport,
};

/**
 Controls the scaling behavior of the circle when the map is pitched.

 Values of this type are used in the `GCLCircleStyleLayer.circleScaleAlignment`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLCircleScaleAlignment) {
    /**
     Circles are scaled according to their apparent distance to the camera.
     */
    GCLCircleScaleAlignmentMap,
    /**
     Circles are not scaled.
     */
    GCLCircleScaleAlignmentViewport,
};

/**
 Controls the translation reference point.

 Values of this type are used in the `GCLCircleStyleLayer.circleTranslationAnchor`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLCircleTranslationAnchor) {
    /**
     The circle is translated relative to the map.
     */
    GCLCircleTranslationAnchorMap,
    /**
     The circle is translated relative to the viewport.
     */
    GCLCircleTranslationAnchorViewport,
};

/**
 An `GCLCircleStyleLayer` is a style layer that renders one or more filled
 circles on the map.
 
 Use a circle style layer to configure the visual appearance of point or point
 collection features in vector tiles loaded by an `GCLVectorSource` object or
 `GCLPointAnnotation`, `GCLPointFeature`, `GCLPointCollection`, or
 `GCLPointCollectionFeature` instances in an `GCLShapeSource` object.
 
 A circle style layer renders circles whose radii are measured in screen units.
 To display circles on the map whose radii correspond to real-world distances,
 use many-sided regular polygons and configure their appearance using an
 `GCLFillStyleLayer` object.

 You can access an existing circle style layer using the
 `-[GCLStyle layerWithIdentifier:]` method if you know its identifier;
 otherwise, find it using the `GCLStyle.layers` property. You can also create a
 new circle style layer and add it to the style using a method such as
 `-[GCLStyle addLayer:]`.

 ### Example

 ```swift
 let layer = GCLCircleStyleLayer(identifier: "circles", source: population)
 layer.sourceLayerIdentifier = "population"
 layer.circleColor = GCLStyleValue(rawValue: .green)
 layer.circleRadius = GCLStyleValue(interpolationMode: .exponential,
                                    cameraStops: [12: GCLStyleValue(rawValue: 2),
                                                  22: GCLStyleValue(rawValue: 180)],
                                    options: [.interpolationBase: 1.75])
 layer.circleOpacity = GCLStyleValue(rawValue: 0.7)
 layer.predicate = NSPredicate(format: "%K == %@", "marital-status", "married")
 mapView.style?.addLayer(layer)
 ```
 */
GCL_EXPORT
@interface GCLCircleStyleLayer : GCLVectorStyleLayer

/**
 Returns a circle style layer initialized with an identifier and source.

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
 Amount to blur the circle. 1 blurs the circle such that only the centerpoint is
 full opacity.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *circleBlur;

/**
 The transition affecting any changes to this layer’s `circleBlur` property.

 This property corresponds to the `circle-blur-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition circleBlurTransition;

#if TARGET_OS_IPHONE
/**
 The fill color of the circle.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *circleColor;
#else
/**
 The fill color of the circle.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *circleColor;
#endif

/**
 The transition affecting any changes to this layer’s `circleColor` property.

 This property corresponds to the `circle-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition circleColorTransition;

/**
 The opacity at which the circle will be drawn.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *circleOpacity;

/**
 The transition affecting any changes to this layer’s `circleOpacity` property.

 This property corresponds to the `circle-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition circleOpacityTransition;

/**
 Orientation of circle when map is pitched.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLCirclePitchAlignmentViewport`. Set this
 property to `nil` to reset it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *circlePitchAlignment;

/**
 Circle radius.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `5`. Set this property to `nil` to reset
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *circleRadius;

/**
 The transition affecting any changes to this layer’s `circleRadius` property.

 This property corresponds to the `circle-radius-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition circleRadiusTransition;

/**
 Controls the scaling behavior of the circle when the map is pitched.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLCircleScaleAlignmentMap`. Set this property to
 `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-circle-pitch-scale"><code>circle-pitch-scale</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *circleScaleAlignment;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *circlePitchScale __attribute__((unavailable("Use circleScaleAlignment instead.")));

#if TARGET_OS_IPHONE
/**
 The stroke color of the circle.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *circleStrokeColor;
#else
/**
 The stroke color of the circle.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *circleStrokeColor;
#endif

/**
 The transition affecting any changes to this layer’s `circleStrokeColor` property.

 This property corresponds to the `circle-stroke-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition circleStrokeColorTransition;

/**
 The opacity of the circle's stroke.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *circleStrokeOpacity;

/**
 The transition affecting any changes to this layer’s `circleStrokeOpacity` property.

 This property corresponds to the `circle-stroke-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition circleStrokeOpacityTransition;

/**
 The width of the circle's stroke. Strokes are placed outside of the
 `circleRadius`.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *circleStrokeWidth;

/**
 The transition affecting any changes to this layer’s `circleStrokeWidth` property.

 This property corresponds to the `circle-stroke-width-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition circleStrokeWidthTransition;

#if TARGET_OS_IPHONE
/**
 The geometry's offset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points downward. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-circle-translate"><code>circle-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *circleTranslation;
#else
/**
 The geometry's offset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points upward. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-circle-translate"><code>circle-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *circleTranslation;
#endif

/**
 The transition affecting any changes to this layer’s `circleTranslation` property.

 This property corresponds to the `circle-translate-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition circleTranslationTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *circleTranslate __attribute__((unavailable("Use circleTranslation instead.")));

/**
 Controls the translation reference point.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLCircleTranslationAnchorMap`. Set this property
 to `nil` to reset it to the default value.
 
 This property is only applied to the style if `circleTranslation` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-circle-translate-anchor"><code>circle-translate-anchor</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *circleTranslationAnchor;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *circleTranslateAnchor __attribute__((unavailable("Use circleTranslationAnchor instead.")));

@end

/**
 Methods for wrapping an enumeration value for a style layer attribute in an
 `GCLCircleStyleLayer` object and unwrapping its raw value.
 */
@interface NSValue (GCLCircleStyleLayerAdditions)

#pragma mark Working with Circle Style Layer Attribute Values

/**
 Creates a new value object containing the given `GCLCirclePitchAlignment` enumeration.

 @param circlePitchAlignment The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLCirclePitchAlignment:(GCLCirclePitchAlignment)circlePitchAlignment;

/**
 The `GCLCirclePitchAlignment` enumeration representation of the value.
 */
@property (readonly) GCLCirclePitchAlignment GCLCirclePitchAlignmentValue;

/**
 Creates a new value object containing the given `GCLCircleScaleAlignment` enumeration.

 @param circleScaleAlignment The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLCircleScaleAlignment:(GCLCircleScaleAlignment)circleScaleAlignment;

/**
 The `GCLCircleScaleAlignment` enumeration representation of the value.
 */
@property (readonly) GCLCircleScaleAlignment GCLCircleScaleAlignmentValue;

/**
 Creates a new value object containing the given `GCLCircleTranslationAnchor` enumeration.

 @param circleTranslationAnchor The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLCircleTranslationAnchor:(GCLCircleTranslationAnchor)circleTranslationAnchor;

/**
 The `GCLCircleTranslationAnchor` enumeration representation of the value.
 */
@property (readonly) GCLCircleTranslationAnchor GCLCircleTranslationAnchorValue;

@end

NS_ASSUME_NONNULL_END
