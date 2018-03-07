// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLFoundation.h"
#import "GCLStyleValue.h"
#import "GCLVectorStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Controls the translation reference point.

 Values of this type are used in the `GCLFillStyleLayer.fillTranslationAnchor`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLFillTranslationAnchor) {
    /**
     The fill is translated relative to the map.
     */
    GCLFillTranslationAnchorMap,
    /**
     The fill is translated relative to the viewport.
     */
    GCLFillTranslationAnchorViewport,
};

/**
 An `GCLFillStyleLayer` is a style layer that renders one or more filled (and
 optionally stroked) polygons on the map.
 
 Use a fill style layer to configure the visual appearance of polygon or
 multipolygon features in vector tiles loaded by an `GCLVectorSource` object or
 `GCLPolygon`, `GCLPolygonFeature`, `GCLMultiPolygon`, or
 `GCLMultiPolygonFeature` instances in an `GCLShapeSource` object.

 You can access an existing fill style layer using the
 `-[GCLStyle layerWithIdentifier:]` method if you know its identifier;
 otherwise, find it using the `GCLStyle.layers` property. You can also create a
 new fill style layer and add it to the style using a method such as
 `-[GCLStyle addLayer:]`.

 ### Example

 ```swift
 let layer = GCLFillStyleLayer(identifier: "parks", source: parks)
 layer.sourceLayerIdentifier = "parks"
 layer.fillColor = GCLStyleValue(rawValue: .green)
 layer.predicate = NSPredicate(format: "type == %@", "national-park")
 mapView.style?.addLayer(layer)
 ```
 */
GCL_EXPORT
@interface GCLFillStyleLayer : GCLVectorStyleLayer

/**
 Returns a fill style layer initialized with an identifier and source.

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
 Whether or not the fill should be antialiased.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `YES`. Set this property to `nil` to reset it to
 the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-fill-antialias"><code>fill-antialias</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable, getter=isFillAntialiased) GCLStyleValue<NSNumber *> *fillAntialiased;

@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *fillAntialias __attribute__((unavailable("Use fillAntialiased instead.")));

#if TARGET_OS_IPHONE
/**
 The color of the filled part of this layer.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `fillPattern` is set to `nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *fillColor;
#else
/**
 The color of the filled part of this layer.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `fillPattern` is set to `nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *fillColor;
#endif

/**
 The transition affecting any changes to this layer’s `fillColor` property.

 This property corresponds to the `fill-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillColorTransition;

/**
 The opacity of the entire fill layer. In contrast to the `fillColor`, this
 value will also affect the 1pt stroke around the fill, if the stroke is used.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *fillOpacity;

/**
 The transition affecting any changes to this layer’s `fillOpacity` property.

 This property corresponds to the `fill-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillOpacityTransition;

#if TARGET_OS_IPHONE
/**
 The outline color of the fill. Matches the value of `fillColor` if unspecified.
 
 This property is only applied to the style if `fillPattern` is set to `nil`,
 and `fillAntialiased` is set to an `GCLStyleValue` object containing an
 `NSNumber` object containing `YES`. Otherwise, it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *fillOutlineColor;
#else
/**
 The outline color of the fill. Matches the value of `fillColor` if unspecified.
 
 This property is only applied to the style if `fillPattern` is set to `nil`,
 and `fillAntialiased` is set to an `GCLStyleValue` object containing an
 `NSNumber` object containing `YES`. Otherwise, it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *fillOutlineColor;
#endif

/**
 The transition affecting any changes to this layer’s `fillOutlineColor` property.

 This property corresponds to the `fill-outline-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillOutlineColorTransition;

/**
 Name of image in sprite to use for drawing image fills. For seamless patterns,
 image width and height must be a factor of two (2, 4, 8, ..., 512).
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSString *> *fillPattern;

/**
 The transition affecting any changes to this layer’s `fillPattern` property.

 This property corresponds to the `fill-pattern-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillPatternTransition;

#if TARGET_OS_IPHONE
/**
 The geometry's offset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points downward. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-fill-translate"><code>fill-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillTranslation;
#else
/**
 The geometry's offset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points upward. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-fill-translate"><code>fill-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillTranslation;
#endif

/**
 The transition affecting any changes to this layer’s `fillTranslation` property.

 This property corresponds to the `fill-translate-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillTranslationTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillTranslate __attribute__((unavailable("Use fillTranslation instead.")));

/**
 Controls the translation reference point.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLFillTranslationAnchorMap`. Set this property to
 `nil` to reset it to the default value.
 
 This property is only applied to the style if `fillTranslation` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-fill-translate-anchor"><code>fill-translate-anchor</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillTranslationAnchor;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillTranslateAnchor __attribute__((unavailable("Use fillTranslationAnchor instead.")));

@end

/**
 Methods for wrapping an enumeration value for a style layer attribute in an
 `GCLFillStyleLayer` object and unwrapping its raw value.
 */
@interface NSValue (GCLFillStyleLayerAdditions)

#pragma mark Working with Fill Style Layer Attribute Values

/**
 Creates a new value object containing the given `GCLFillTranslationAnchor` enumeration.

 @param fillTranslationAnchor The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLFillTranslationAnchor:(GCLFillTranslationAnchor)fillTranslationAnchor;

/**
 The `GCLFillTranslationAnchor` enumeration representation of the value.
 */
@property (readonly) GCLFillTranslationAnchor GCLFillTranslationAnchorValue;

@end

NS_ASSUME_NONNULL_END
