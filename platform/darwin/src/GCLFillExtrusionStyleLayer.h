// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLFoundation.h"
#import "GCLStyleValue.h"
#import "GCLVectorStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Controls the translation reference point.

 Values of this type are used in the `GCLFillExtrusionStyleLayer.fillExtrusionTranslationAnchor`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLFillExtrusionTranslationAnchor) {
    /**
     The fill extrusion is translated relative to the map.
     */
    GCLFillExtrusionTranslationAnchorMap,
    /**
     The fill extrusion is translated relative to the viewport.
     */
    GCLFillExtrusionTranslationAnchorViewport,
};

/**
 An `GCLFillExtrusionStyleLayer` is a style layer that renders one or more 3D
 extruded polygons on the map.
 
 Use a fill-extrusion style layer to configure the visual appearance of polygon
 or multipolygon features in vector tiles loaded by an `GCLVectorSource` object
 or `GCLPolygon`, `GCLPolygonFeature`, `GCLMultiPolygon`, or
 `GCLMultiPolygonFeature` instances in an `GCLShapeSource` object.

 You can access an existing fill-extrusion style layer using the
 `-[GCLStyle layerWithIdentifier:]` method if you know its identifier;
 otherwise, find it using the `GCLStyle.layers` property. You can also create a
 new fill-extrusion style layer and add it to the style using a method such as
 `-[GCLStyle addLayer:]`.

 ### Example

 ```swift
 let layer = GCLFillExtrusionStyleLayer(identifier: "buildings", source: buildings)
 layer.sourceLayerIdentifier = "building"
 layer.fillExtrusionHeight = GCLStyleValue(interpolationMode: .identity, sourceStops: nil, attributeName: "height", options: nil)
 layer.fillExtrusionBase = GCLStyleValue(interpolationMode: .identity, sourceStops: nil, attributeName: "min_height", options: nil)
 layer.predicate = NSPredicate(format: "extrude == 'true'")
 mapView.style?.addLayer(layer)
 ```
 */
GCL_EXPORT
@interface GCLFillExtrusionStyleLayer : GCLVectorStyleLayer

/**
 Returns a fill-extrusion style layer initialized with an identifier and source.

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
 The height with which to extrude the base of this layer. Must be less than or
 equal to `fillExtrusionHeight`.
 
 This property is measured in meters.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `fillExtrusionHeight` is
 non-`nil`. Otherwise, it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *fillExtrusionBase;

/**
 The transition affecting any changes to this layer’s `fillExtrusionBase` property.

 This property corresponds to the `fill-extrusion-base-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillExtrusionBaseTransition;

#if TARGET_OS_IPHONE
/**
 The base color of this layer. The extrusion's surfaces will be shaded
 differently based on this color in combination with the `light` settings. If
 this color is specified with an alpha component, the alpha component will be
 ignored; use `fillExtrusionOpacity` to set layer opacityco.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `fillExtrusionPattern` is set to
 `nil`. Otherwise, it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *fillExtrusionColor;
#else
/**
 The base color of this layer. The extrusion's surfaces will be shaded
 differently based on this color in combination with the `light` settings. If
 this color is specified with an alpha component, the alpha component will be
 ignored; use `fillExtrusionOpacity` to set layer opacityco.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `fillExtrusionPattern` is set to
 `nil`. Otherwise, it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *fillExtrusionColor;
#endif

/**
 The transition affecting any changes to this layer’s `fillExtrusionColor` property.

 This property corresponds to the `fill-extrusion-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillExtrusionColorTransition;

/**
 The height with which to extrude this layer.
 
 This property is measured in meters.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *fillExtrusionHeight;

/**
 The transition affecting any changes to this layer’s `fillExtrusionHeight` property.

 This property corresponds to the `fill-extrusion-height-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillExtrusionHeightTransition;

/**
 The opacity of the entire fill extrusion layer. This is rendered on a
 per-layer, not per-feature, basis, and data-driven styling is not available.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *fillExtrusionOpacity;

/**
 The transition affecting any changes to this layer’s `fillExtrusionOpacity` property.

 This property corresponds to the `fill-extrusion-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillExtrusionOpacityTransition;

/**
 Name of image in style images to use for drawing image fill-extrusions. For
 seamless patterns, image width and height must be a factor of two (2, 4, 8,
 ..., 512).
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSString *> *fillExtrusionPattern;

/**
 The transition affecting any changes to this layer’s `fillExtrusionPattern` property.

 This property corresponds to the `fill-extrusion-pattern-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillExtrusionPatternTransition;

#if TARGET_OS_IPHONE
/**
 The geometry's offset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points downward. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-fill-extrusion-translate"><code>fill-extrusion-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillExtrusionTranslation;
#else
/**
 The geometry's offset.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points upward. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-fill-extrusion-translate"><code>fill-extrusion-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillExtrusionTranslation;
#endif

/**
 The transition affecting any changes to this layer’s `fillExtrusionTranslation` property.

 This property corresponds to the `fill-extrusion-translate-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition fillExtrusionTranslationTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillExtrusionTranslate __attribute__((unavailable("Use fillExtrusionTranslation instead.")));

/**
 Controls the translation reference point.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLFillExtrusionTranslationAnchorMap`. Set this
 property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `fillExtrusionTranslation` is
 non-`nil`. Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-fill-extrusion-translate-anchor"><code>fill-extrusion-translate-anchor</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillExtrusionTranslationAnchor;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *fillExtrusionTranslateAnchor __attribute__((unavailable("Use fillExtrusionTranslationAnchor instead.")));

@end

/**
 Methods for wrapping an enumeration value for a style layer attribute in an
 `GCLFillExtrusionStyleLayer` object and unwrapping its raw value.
 */
@interface NSValue (GCLFillExtrusionStyleLayerAdditions)

#pragma mark Working with Fill extrusion Style Layer Attribute Values

/**
 Creates a new value object containing the given `GCLFillExtrusionTranslationAnchor` enumeration.

 @param fillExtrusionTranslationAnchor The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLFillExtrusionTranslationAnchor:(GCLFillExtrusionTranslationAnchor)fillExtrusionTranslationAnchor;

/**
 The `GCLFillExtrusionTranslationAnchor` enumeration representation of the value.
 */
@property (readonly) GCLFillExtrusionTranslationAnchor GCLFillExtrusionTranslationAnchorValue;

@end

NS_ASSUME_NONNULL_END
