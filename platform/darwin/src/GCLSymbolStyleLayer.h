// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLFoundation.h"
#import "GCLStyleValue.h"
#import "GCLVectorStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Part of the icon placed closest to the anchor.

 Values of this type are used in the `GCLSymbolStyleLayer.iconAnchor`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLIconAnchor) {
    /**
     The center of the icon is placed closest to the anchor.
     */
    GCLIconAnchorCenter,
    /**
     The left side of the icon is placed closest to the anchor.
     */
    GCLIconAnchorLeft,
    /**
     The right side of the icon is placed closest to the anchor.
     */
    GCLIconAnchorRight,
    /**
     The top of the icon is placed closest to the anchor.
     */
    GCLIconAnchorTop,
    /**
     The bottom of the icon is placed closest to the anchor.
     */
    GCLIconAnchorBottom,
    /**
     The top left corner of the icon is placed closest to the anchor.
     */
    GCLIconAnchorTopLeft,
    /**
     The top right corner of the icon is placed closest to the anchor.
     */
    GCLIconAnchorTopRight,
    /**
     The bottom left corner of the icon is placed closest to the anchor.
     */
    GCLIconAnchorBottomLeft,
    /**
     The bottom right corner of the icon is placed closest to the anchor.
     */
    GCLIconAnchorBottomRight,
};

/**
 Orientation of icon when map is pitched.

 Values of this type are used in the `GCLSymbolStyleLayer.iconPitchAlignment`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLIconPitchAlignment) {
    /**
     The icon is aligned to the plane of the map.
     */
    GCLIconPitchAlignmentMap,
    /**
     The icon is aligned to the plane of the viewport.
     */
    GCLIconPitchAlignmentViewport,
    /**
     Automatically matches the value of `iconRotationAlignment`.
     */
    GCLIconPitchAlignmentAuto,
};

/**
 In combination with `symbolPlacement`, determines the rotation behavior of
 icons.

 Values of this type are used in the `GCLSymbolStyleLayer.iconRotationAlignment`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLIconRotationAlignment) {
    /**
     When `symbolPlacement` is set to `GCLSymbolPlacementPoint`, aligns icons
     east-west. When `symbolPlacement` is set to `GCLSymbolPlacementLine`,
     aligns icon x-axes with the line.
     */
    GCLIconRotationAlignmentMap,
    /**
     Produces icons whose x-axes are aligned with the x-axis of the viewport,
     regardless of the value of `symbolPlacement`.
     */
    GCLIconRotationAlignmentViewport,
    /**
     When `symbolPlacement` is set to `GCLSymbolPlacementPoint`, this is
     equivalent to `GCLIconRotationAlignmentViewport`. When `symbolPlacement` is
     set to `GCLSymbolPlacementLine`, this is equivalent to
     `GCLIconRotationAlignmentMap`.
     */
    GCLIconRotationAlignmentAuto,
};

/**
 Scales the icon to fit around the associated text.

 Values of this type are used in the `GCLSymbolStyleLayer.iconTextFit`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLIconTextFit) {
    /**
     The icon is displayed at its intrinsic aspect ratio.
     */
    GCLIconTextFitNone,
    /**
     The icon is scaled in the x-dimension to fit the width of the text.
     */
    GCLIconTextFitWidth,
    /**
     The icon is scaled in the y-dimension to fit the height of the text.
     */
    GCLIconTextFitHeight,
    /**
     The icon is scaled in both x- and y-dimensions.
     */
    GCLIconTextFitBoth,
};

/**
 Label placement relative to its geometry.

 Values of this type are used in the `GCLSymbolStyleLayer.symbolPlacement`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLSymbolPlacement) {
    /**
     The label is placed at the point where the geometry is located.
     */
    GCLSymbolPlacementPoint,
    /**
     The label is placed along the line of the geometry. Can only be used on
     `LineString` and `Polygon` geometries.
     */
    GCLSymbolPlacementLine,
};

/**
 Part of the text placed closest to the anchor.

 Values of this type are used in the `GCLSymbolStyleLayer.textAnchor`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLTextAnchor) {
    /**
     The center of the text is placed closest to the anchor.
     */
    GCLTextAnchorCenter,
    /**
     The left side of the text is placed closest to the anchor.
     */
    GCLTextAnchorLeft,
    /**
     The right side of the text is placed closest to the anchor.
     */
    GCLTextAnchorRight,
    /**
     The top of the text is placed closest to the anchor.
     */
    GCLTextAnchorTop,
    /**
     The bottom of the text is placed closest to the anchor.
     */
    GCLTextAnchorBottom,
    /**
     The top left corner of the text is placed closest to the anchor.
     */
    GCLTextAnchorTopLeft,
    /**
     The top right corner of the text is placed closest to the anchor.
     */
    GCLTextAnchorTopRight,
    /**
     The bottom left corner of the text is placed closest to the anchor.
     */
    GCLTextAnchorBottomLeft,
    /**
     The bottom right corner of the text is placed closest to the anchor.
     */
    GCLTextAnchorBottomRight,
};

/**
 Text justification options.

 Values of this type are used in the `GCLSymbolStyleLayer.textJustification`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLTextJustification) {
    /**
     The text is aligned to the left.
     */
    GCLTextJustificationLeft,
    /**
     The text is centered.
     */
    GCLTextJustificationCenter,
    /**
     The text is aligned to the right.
     */
    GCLTextJustificationRight,
};

/**
 Orientation of text when map is pitched.

 Values of this type are used in the `GCLSymbolStyleLayer.textPitchAlignment`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLTextPitchAlignment) {
    /**
     The text is aligned to the plane of the map.
     */
    GCLTextPitchAlignmentMap,
    /**
     The text is aligned to the plane of the viewport.
     */
    GCLTextPitchAlignmentViewport,
    /**
     Automatically matches the value of `textRotationAlignment`.
     */
    GCLTextPitchAlignmentAuto,
};

/**
 In combination with `symbolPlacement`, determines the rotation behavior of the
 individual glyphs forming the text.

 Values of this type are used in the `GCLSymbolStyleLayer.textRotationAlignment`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLTextRotationAlignment) {
    /**
     When `symbolPlacement` is set to `GCLSymbolPlacementPoint`, aligns text
     east-west. When `symbolPlacement` is set to `GCLSymbolPlacementLine`,
     aligns text x-axes with the line.
     */
    GCLTextRotationAlignmentMap,
    /**
     Produces glyphs whose x-axes are aligned with the x-axis of the viewport,
     regardless of the value of `symbolPlacement`.
     */
    GCLTextRotationAlignmentViewport,
    /**
     When `symbolPlacement` is set to `GCLSymbolPlacementPoint`, this is
     equivalent to `GCLTextRotationAlignmentViewport`. When `symbolPlacement` is
     set to `GCLSymbolPlacementLine`, this is equivalent to
     `GCLTextRotationAlignmentMap`.
     */
    GCLTextRotationAlignmentAuto,
};

/**
 Specifies how to capitalize text.

 Values of this type are used in the `GCLSymbolStyleLayer.textTransform`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLTextTransform) {
    /**
     The text is not altered.
     */
    GCLTextTransformNone,
    /**
     Forces all letters to be displayed in uppercase.
     */
    GCLTextTransformUppercase,
    /**
     Forces all letters to be displayed in lowercase.
     */
    GCLTextTransformLowercase,
};

/**
 Controls the translation reference point.

 Values of this type are used in the `GCLSymbolStyleLayer.iconTranslationAnchor`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLIconTranslationAnchor) {
    /**
     Icons are translated relative to the map.
     */
    GCLIconTranslationAnchorMap,
    /**
     Icons are translated relative to the viewport.
     */
    GCLIconTranslationAnchorViewport,
};

/**
 Controls the translation reference point.

 Values of this type are used in the `GCLSymbolStyleLayer.textTranslationAnchor`
 property.
 */
typedef NS_ENUM(NSUInteger, GCLTextTranslationAnchor) {
    /**
     The text is translated relative to the map.
     */
    GCLTextTranslationAnchorMap,
    /**
     The text is translated relative to the viewport.
     */
    GCLTextTranslationAnchorViewport,
};

/**
 An `GCLSymbolStyleLayer` is a style layer that renders icon and text labels at
 points or along lines on the map.
 
 Use a symbol style layer to configure the visual appearance of labels for
 features in vector tiles loaded by an `GCLVectorSource` object or `GCLShape` or
 `GCLFeature` instances in an `GCLShapeSource` object.

 You can access an existing symbol style layer using the
 `-[GCLStyle layerWithIdentifier:]` method if you know its identifier;
 otherwise, find it using the `GCLStyle.layers` property. You can also create a
 new symbol style layer and add it to the style using a method such as
 `-[GCLStyle addLayer:]`.

 ### Example

 ```swift
 let layer = GCLSymbolStyleLayer(identifier: "coffeeshops", source: pois)
 layer.sourceLayerIdentifier = "pois"
 layer.iconImageName = GCLStyleValue(rawValue: "coffee")
 layer.iconScale = GCLStyleValue(rawValue: 0.5)
 layer.text = GCLStyleValue(rawValue: "{name}")
 layer.textTranslation = GCLStyleValue(rawValue: NSValue(cgVector: CGVector(dx: 10, dy: 0)))
 layer.textJustification = GCLStyleValue(rawValue: NSValue(GCLTextJustification: .left))
 layer.textAnchor = GCLStyleValue(rawValue: NSValue(GCLTextAnchor: .left))
 layer.predicate = NSPredicate(format: "%K == %@", "venue-type", "coffee")
 mapView.style?.addLayer(layer)
 ```
 */
GCL_EXPORT
@interface GCLSymbolStyleLayer : GCLVectorStyleLayer

/**
 Returns a symbol style layer initialized with an identifier and source.

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
 If true, the icon will be visible even if it collides with other previously
 drawn symbols.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `NO`. Set this property to `nil` to reset it to
 the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-icon-allow-overlap"><code>icon-allow-overlap</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconAllowsOverlap;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconAllowOverlap __attribute__((unavailable("Use iconAllowsOverlap instead.")));

/**
 Part of the icon placed closest to the anchor.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLIconAnchorCenter`. Set this property to `nil`
 to reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconAnchor;

/**
 If true, other symbols can be visible even if they collide with the icon.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `NO`. Set this property to `nil` to reset it to
 the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-icon-ignore-placement"><code>icon-ignore-placement</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconIgnoresPlacement;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconIgnorePlacement __attribute__((unavailable("Use iconIgnoresPlacement instead.")));

/**
 Name of image in sprite to use for drawing an image background. A string with
 {tokens} replaced, referencing the data property to pull from.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-icon-image"><code>icon-image</code></a>
 layout property in the Mapbox Style Specification.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSString *> *iconImageName;


@property (nonatomic, null_resettable) GCLStyleValue<NSString *> *iconImage __attribute__((unavailable("Use iconImageName instead.")));

#if TARGET_OS_IPHONE
/**
 Offset distance of icon from its anchor.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 rightward and 0
 downward. Set this property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconOffset;
#else
/**
 Offset distance of icon from its anchor.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 rightward and 0
 upward. Set this property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconOffset;
#endif

/**
 If true, text will display without their corresponding icons when the icon
 collides with other symbols and the text does not.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `NO`. Set this property to `nil` to reset it to
 the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`, and
 `text` is non-`nil`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable, getter=isIconOptional) GCLStyleValue<NSNumber *> *iconOptional;

/**
 Size of the additional area around the icon bounding box used for detecting
 symbol collisions.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `2`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconPadding;

/**
 Orientation of icon when map is pitched.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLIconPitchAlignmentAuto`. Set this property to
 `nil` to reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconPitchAlignment;

/**
 Rotates the icon clockwise.
 
 This property is measured in degrees.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-icon-rotate"><code>icon-rotate</code></a>
 layout property in the Mapbox Style Specification.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconRotation;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconRotate __attribute__((unavailable("Use iconRotation instead.")));

/**
 In combination with `symbolPlacement`, determines the rotation behavior of
 icons.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLIconRotationAlignmentAuto`. Set this property
 to `nil` to reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconRotationAlignment;

/**
 Scales the original size of the icon by the provided factor. The new point size
 of the image will be the original point size multiplied by `iconSize`. 1 is the
 original size; 3 triples the size of the image.
 
 This property is measured in factor of the original icon sizes.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-icon-size"><code>icon-size</code></a>
 layout property in the Mapbox Style Specification.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconScale;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconSize __attribute__((unavailable("Use iconScale instead.")));

/**
 Scales the icon to fit around the associated text.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLIconTextFitNone`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`, and
 `text` is non-`nil`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconTextFit;

#if TARGET_OS_IPHONE
/**
 Size of the additional area added to dimensions determined by `iconTextFit`.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `UIEdgeInsetsZero`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`, and
 `text` is non-`nil`, and `iconTextFit` is set to an `GCLStyleValue` object
 containing an `NSValue` object containing `GCLIconTextFitBoth`,
 `GCLIconTextFitWidth`, or `GCLIconTextFitHeight`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconTextFitPadding;
#else
/**
 Size of the additional area added to dimensions determined by `iconTextFit`.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `NSEdgeInsetsZero`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`, and
 `text` is non-`nil`, and `iconTextFit` is set to an `GCLStyleValue` object
 containing an `NSValue` object containing `GCLIconTextFitBoth`,
 `GCLIconTextFitWidth`, or `GCLIconTextFitHeight`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconTextFitPadding;
#endif

/**
 If true, the icon may be flipped to prevent it from being rendered upside-down.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `NO`. Set this property to `nil` to reset it to
 the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`, and
 `iconRotationAlignment` is set to an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLIconRotationAlignmentMap`, and
 `symbolPlacement` is set to an `GCLStyleValue` object containing an `NSValue`
 object containing `GCLSymbolPlacementLine`. Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-icon-keep-upright"><code>icon-keep-upright</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *keepsIconUpright;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconKeepUpright __attribute__((unavailable("Use keepsIconUpright instead.")));

/**
 If true, the text may be flipped vertically to prevent it from being rendered
 upside-down.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `YES`. Set this property to `nil` to reset it to
 the default value.
 
 This property is only applied to the style if `text` is non-`nil`, and
 `textRotationAlignment` is set to an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLTextRotationAlignmentMap`, and
 `symbolPlacement` is set to an `GCLStyleValue` object containing an `NSValue`
 object containing `GCLSymbolPlacementLine`. Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-keep-upright"><code>text-keep-upright</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *keepsTextUpright;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textKeepUpright __attribute__((unavailable("Use keepsTextUpright instead.")));

/**
 Maximum angle change between adjacent characters.
 
 This property is measured in degrees.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `45`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`, and
 `symbolPlacement` is set to an `GCLStyleValue` object containing an `NSValue`
 object containing `GCLSymbolPlacementLine`. Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-max-angle"><code>text-max-angle</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *maximumTextAngle;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textMaxAngle __attribute__((unavailable("Use maximumTextAngle instead.")));

/**
 The maximum line width for text wrapping.
 
 This property is measured in ems.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `10`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-max-width"><code>text-max-width</code></a>
 layout property in the Mapbox Style Specification.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *maximumTextWidth;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textMaxWidth __attribute__((unavailable("Use maximumTextWidth instead.")));

/**
 If true, the symbols will not cross tile edges to avoid mutual collisions.
 Recommended in layers that don't have enough padding in the vector tile to
 prevent collisions, or if it is a point symbol layer placed after a line symbol
 layer.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `NO`. Set this property to `nil` to reset it to
 the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-symbol-avoid-edges"><code>symbol-avoid-edges</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *symbolAvoidsEdges;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *symbolAvoidEdges __attribute__((unavailable("Use symbolAvoidsEdges instead.")));

/**
 Label placement relative to its geometry.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLSymbolPlacementPoint`. Set this property to
 `nil` to reset it to the default value.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *symbolPlacement;

/**
 Distance between two symbol anchors.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `250`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `symbolPlacement` is set to an
 `GCLStyleValue` object containing an `NSValue` object containing
 `GCLSymbolPlacementLine`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *symbolSpacing;

/**
 Value to use for a text label. Feature properties are specified using tokens
 like {field_name}.  (Token replacement is only supported for literal
 `textField` values--not for property functions.)
 
 The default value of this property is an `GCLStyleValue` object containing the
 empty string. Set this property to `nil` to reset it to the default value.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-field"><code>text-field</code></a>
 layout property in the Mapbox Style Specification.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSString *> *text;


@property (nonatomic, null_resettable) GCLStyleValue<NSString *> *textField __attribute__((unavailable("Use text instead.")));

/**
 If true, the text will be visible even if it collides with other previously
 drawn symbols.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `NO`. Set this property to `nil` to reset it to
 the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-allow-overlap"><code>text-allow-overlap</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textAllowsOverlap;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textAllowOverlap __attribute__((unavailable("Use textAllowsOverlap instead.")));

/**
 Part of the text placed closest to the anchor.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLTextAnchorCenter`. Set this property to `nil`
 to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textAnchor;

/**
 An array of font face names used to display the text.
 
 Each font name must be included in the `{fontstack}` portion of the JSON
 stylesheet’s <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#glyphs"><code>glyphs</code></a>
 property. You can register a custom font when designing the style in Mapbox
 Studio. Fonts installed on the system are not used.
 
 The first font named in the array is applied to the text. For each character in
 the text, if the first font lacks a glyph for the character, the next font is
 applied as a fallback, and so on.
 
 The default value of this property is an `GCLStyleValue` object containing the
 array `Open Sans Regular`, `Arial Unicode MS Regular`. Set this property to
 `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-font"><code>text-font</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSArray<NSString *> *> *textFontNames;


@property (nonatomic, null_resettable) GCLStyleValue<NSArray<NSString *> *> *textFont __attribute__((unavailable("Use textFontNames instead.")));

/**
 Font size.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `16`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-size"><code>text-size</code></a>
 layout property in the Mapbox Style Specification.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textFontSize;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textSize __attribute__((unavailable("Use textFontSize instead.")));

/**
 If true, other symbols can be visible even if they collide with the text.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `NO`. Set this property to `nil` to reset it to
 the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-ignore-placement"><code>text-ignore-placement</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textIgnoresPlacement;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textIgnorePlacement __attribute__((unavailable("Use textIgnoresPlacement instead.")));

/**
 Text justification options.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLTextJustificationCenter`. Set this property to
 `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-justify"><code>text-justify</code></a>
 layout property in the Mapbox Style Specification.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textJustification;


@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textJustify __attribute__((unavailable("Use textJustification instead.")));

/**
 Text tracking amount.
 
 This property is measured in ems.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textLetterSpacing;

/**
 Text leading value for multi-line text.
 
 This property is measured in ems.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1.2`. Set this property to `nil` to
 reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textLineHeight;

#if TARGET_OS_IPHONE
/**
 Offset distance of text from its anchor.
 
 This property is measured in ems.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 ems rightward and 0
 ems downward. Set this property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textOffset;
#else
/**
 Offset distance of text from its anchor.
 
 This property is measured in ems.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 ems rightward and 0
 ems upward. Set this property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textOffset;
#endif

/**
 If true, icons will display without their corresponding text when the text
 collides with other symbols and the icon does not.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing `NO`. Set this property to `nil` to reset it to
 the default value.
 
 This property is only applied to the style if `text` is non-`nil`, and
 `iconImageName` is non-`nil`. Otherwise, it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable, getter=isTextOptional) GCLStyleValue<NSNumber *> *textOptional;

/**
 Size of the additional area around the text bounding box used for detecting
 symbol collisions.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `2`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textPadding;

/**
 Orientation of text when map is pitched.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLTextPitchAlignmentAuto`. Set this property to
 `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textPitchAlignment;

/**
 Rotates the text clockwise.
 
 This property is measured in degrees.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#layout-symbol-text-rotate"><code>text-rotate</code></a>
 layout property in the Mapbox Style Specification.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textRotation;


@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textRotate __attribute__((unavailable("Use textRotation instead.")));

/**
 In combination with `symbolPlacement`, determines the rotation behavior of the
 individual glyphs forming the text.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLTextRotationAlignmentAuto`. Set this property
 to `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textRotationAlignment;

/**
 Specifies how to capitalize text.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLTextTransformNone`. Set this property to `nil`
 to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textTransform;

#pragma mark - Accessing the Paint Attributes

#if TARGET_OS_IPHONE
/**
 The tint color to apply to the icon. The `iconImageName` property must be set
 to a template image.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *iconColor;
#else
/**
 The tint color to apply to the icon. The `iconImageName` property must be set
 to a template image.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *iconColor;
#endif

/**
 The transition affecting any changes to this layer’s `iconColor` property.

 This property corresponds to the `icon-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition iconColorTransition;

/**
 Fade out the halo towards the outside.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconHaloBlur;

/**
 The transition affecting any changes to this layer’s `iconHaloBlur` property.

 This property corresponds to the `icon-halo-blur-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition iconHaloBlurTransition;

#if TARGET_OS_IPHONE
/**
 The color of the icon’s halo. The `iconImageName` property must be set to a
 template image.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.clearColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *iconHaloColor;
#else
/**
 The color of the icon’s halo. The `iconImageName` property must be set to a
 template image.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.clearColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *iconHaloColor;
#endif

/**
 The transition affecting any changes to this layer’s `iconHaloColor` property.

 This property corresponds to the `icon-halo-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition iconHaloColorTransition;

/**
 Distance of halo to the icon outline.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconHaloWidth;

/**
 The transition affecting any changes to this layer’s `iconHaloWidth` property.

 This property corresponds to the `icon-halo-width-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition iconHaloWidthTransition;

/**
 The opacity at which the icon will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *iconOpacity;

/**
 The transition affecting any changes to this layer’s `iconOpacity` property.

 This property corresponds to the `icon-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition iconOpacityTransition;

#if TARGET_OS_IPHONE
/**
 Distance that the icon's anchor is moved from its original placement.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points downward. Set this property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-icon-translate"><code>icon-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconTranslation;
#else
/**
 Distance that the icon's anchor is moved from its original placement.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points upward. Set this property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`.
 Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-icon-translate"><code>icon-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconTranslation;
#endif

/**
 The transition affecting any changes to this layer’s `iconTranslation` property.

 This property corresponds to the `icon-translate-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition iconTranslationTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconTranslate __attribute__((unavailable("Use iconTranslation instead.")));

/**
 Controls the translation reference point.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLIconTranslationAnchorMap`. Set this property to
 `nil` to reset it to the default value.
 
 This property is only applied to the style if `iconImageName` is non-`nil`, and
 `iconTranslation` is non-`nil`. Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-icon-translate-anchor"><code>icon-translate-anchor</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconTranslationAnchor;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *iconTranslateAnchor __attribute__((unavailable("Use iconTranslationAnchor instead.")));

#if TARGET_OS_IPHONE
/**
 The color with which the text will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *textColor;
#else
/**
 The color with which the text will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.blackColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *textColor;
#endif

/**
 The transition affecting any changes to this layer’s `textColor` property.

 This property corresponds to the `text-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition textColorTransition;

/**
 The halo's fadeout distance towards the outside.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textHaloBlur;

/**
 The transition affecting any changes to this layer’s `textHaloBlur` property.

 This property corresponds to the `text-halo-blur-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition textHaloBlurTransition;

#if TARGET_OS_IPHONE
/**
 The color of the text's halo, which helps it stand out from backgrounds.
 
 The default value of this property is an `GCLStyleValue` object containing
 `UIColor.clearColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<UIColor *> *textHaloColor;
#else
/**
 The color of the text's halo, which helps it stand out from backgrounds.
 
 The default value of this property is an `GCLStyleValue` object containing
 `NSColor.clearColor`. Set this property to `nil` to reset it to the default
 value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSColor *> *textHaloColor;
#endif

/**
 The transition affecting any changes to this layer’s `textHaloColor` property.

 This property corresponds to the `text-halo-color-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition textHaloColorTransition;

/**
 Distance of halo to the font outline. Max text halo width is 1/4 of the
 font-size.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `0`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textHaloWidth;

/**
 The transition affecting any changes to this layer’s `textHaloWidth` property.

 This property corresponds to the `text-halo-width-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition textHaloWidthTransition;

/**
 The opacity at which the text will be drawn.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSNumber` object containing the float `1`. Set this property to `nil` to reset
 it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
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
@property (nonatomic, null_resettable) GCLStyleValue<NSNumber *> *textOpacity;

/**
 The transition affecting any changes to this layer’s `textOpacity` property.

 This property corresponds to the `text-opacity-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition textOpacityTransition;

#if TARGET_OS_IPHONE
/**
 Distance that the text's anchor is moved from its original placement.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points downward. Set this property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-text-translate"><code>text-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textTranslation;
#else
/**
 Distance that the text's anchor is moved from its original placement.
 
 This property is measured in points.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing a `CGVector` struct set to 0 points rightward and 0
 points upward. Set this property to `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`. Otherwise,
 it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-text-translate"><code>text-translate</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of:
   * `GCLInterpolationModeExponential`
   * `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textTranslation;
#endif

/**
 The transition affecting any changes to this layer’s `textTranslation` property.

 This property corresponds to the `text-translate-transition` property in the style JSON file format.
*/
@property (nonatomic) GCLTransition textTranslationTransition;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textTranslate __attribute__((unavailable("Use textTranslation instead.")));

/**
 Controls the translation reference point.
 
 The default value of this property is an `GCLStyleValue` object containing an
 `NSValue` object containing `GCLTextTranslationAnchorMap`. Set this property to
 `nil` to reset it to the default value.
 
 This property is only applied to the style if `text` is non-`nil`, and
 `textTranslation` is non-`nil`. Otherwise, it is ignored.
 
 This attribute corresponds to the <a
 href="https://www.mapbox.com/mapbox-gl-style-spec/#paint-text-translate-anchor"><code>text-translate-anchor</code></a>
 layout property in the Mapbox Style Specification.
 
 You can set this property to an instance of:
 
 * `GCLConstantStyleValue`
 * `GCLCameraStyleFunction` with an interpolation mode of
 `GCLInterpolationModeInterval`
 */
@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textTranslationAnchor;

@property (nonatomic, null_resettable) GCLStyleValue<NSValue *> *textTranslateAnchor __attribute__((unavailable("Use textTranslationAnchor instead.")));

@end

/**
 Methods for wrapping an enumeration value for a style layer attribute in an
 `GCLSymbolStyleLayer` object and unwrapping its raw value.
 */
@interface NSValue (GCLSymbolStyleLayerAdditions)

#pragma mark Working with Symbol Style Layer Attribute Values

/**
 Creates a new value object containing the given `GCLIconAnchor` enumeration.

 @param iconAnchor The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLIconAnchor:(GCLIconAnchor)iconAnchor;

/**
 The `GCLIconAnchor` enumeration representation of the value.
 */
@property (readonly) GCLIconAnchor GCLIconAnchorValue;

/**
 Creates a new value object containing the given `GCLIconPitchAlignment` enumeration.

 @param iconPitchAlignment The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLIconPitchAlignment:(GCLIconPitchAlignment)iconPitchAlignment;

/**
 The `GCLIconPitchAlignment` enumeration representation of the value.
 */
@property (readonly) GCLIconPitchAlignment GCLIconPitchAlignmentValue;

/**
 Creates a new value object containing the given `GCLIconRotationAlignment` enumeration.

 @param iconRotationAlignment The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLIconRotationAlignment:(GCLIconRotationAlignment)iconRotationAlignment;

/**
 The `GCLIconRotationAlignment` enumeration representation of the value.
 */
@property (readonly) GCLIconRotationAlignment GCLIconRotationAlignmentValue;

/**
 Creates a new value object containing the given `GCLIconTextFit` enumeration.

 @param iconTextFit The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLIconTextFit:(GCLIconTextFit)iconTextFit;

/**
 The `GCLIconTextFit` enumeration representation of the value.
 */
@property (readonly) GCLIconTextFit GCLIconTextFitValue;

/**
 Creates a new value object containing the given `GCLSymbolPlacement` enumeration.

 @param symbolPlacement The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLSymbolPlacement:(GCLSymbolPlacement)symbolPlacement;

/**
 The `GCLSymbolPlacement` enumeration representation of the value.
 */
@property (readonly) GCLSymbolPlacement GCLSymbolPlacementValue;

/**
 Creates a new value object containing the given `GCLTextAnchor` enumeration.

 @param textAnchor The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLTextAnchor:(GCLTextAnchor)textAnchor;

/**
 The `GCLTextAnchor` enumeration representation of the value.
 */
@property (readonly) GCLTextAnchor GCLTextAnchorValue;

/**
 Creates a new value object containing the given `GCLTextJustification` enumeration.

 @param textJustification The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLTextJustification:(GCLTextJustification)textJustification;

/**
 The `GCLTextJustification` enumeration representation of the value.
 */
@property (readonly) GCLTextJustification GCLTextJustificationValue;

/**
 Creates a new value object containing the given `GCLTextPitchAlignment` enumeration.

 @param textPitchAlignment The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLTextPitchAlignment:(GCLTextPitchAlignment)textPitchAlignment;

/**
 The `GCLTextPitchAlignment` enumeration representation of the value.
 */
@property (readonly) GCLTextPitchAlignment GCLTextPitchAlignmentValue;

/**
 Creates a new value object containing the given `GCLTextRotationAlignment` enumeration.

 @param textRotationAlignment The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLTextRotationAlignment:(GCLTextRotationAlignment)textRotationAlignment;

/**
 The `GCLTextRotationAlignment` enumeration representation of the value.
 */
@property (readonly) GCLTextRotationAlignment GCLTextRotationAlignmentValue;

/**
 Creates a new value object containing the given `GCLTextTransform` enumeration.

 @param textTransform The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLTextTransform:(GCLTextTransform)textTransform;

/**
 The `GCLTextTransform` enumeration representation of the value.
 */
@property (readonly) GCLTextTransform GCLTextTransformValue;

/**
 Creates a new value object containing the given `GCLIconTranslationAnchor` enumeration.

 @param iconTranslationAnchor The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLIconTranslationAnchor:(GCLIconTranslationAnchor)iconTranslationAnchor;

/**
 The `GCLIconTranslationAnchor` enumeration representation of the value.
 */
@property (readonly) GCLIconTranslationAnchor GCLIconTranslationAnchorValue;

/**
 Creates a new value object containing the given `MGLTextTranslationAnchor` enumeration.

 @param textTranslationAnchor The value for the new object.
 @return A new value object that contains the enumeration value.
 */
+ (instancetype)valueWithGCLTextTranslationAnchor:(GCLTextTranslationAnchor)textTranslationAnchor;

/**
 The `GCLTextTranslationAnchor` enumeration representation of the value.
 */
@property (readonly) GCLTextTranslationAnchor GCLTextTranslationAnchorValue;

@end

NS_ASSUME_NONNULL_END
