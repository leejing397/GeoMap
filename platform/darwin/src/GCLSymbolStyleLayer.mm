// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLSource.h"
#import "NSPredicate+GCLAdditions.h"
#import "NSDate+GCLAdditions.h"
#import "GCLStyleLayer_Private.h"
#import "GCLStyleValue_Private.h"
#import "GCLSymbolStyleLayer.h"

#include <mbgl/style/transition_options.hpp>
#include <mbgl/style/layers/symbol_layer.hpp>

namespace mbgl {

    MBGL_DEFINE_ENUM(GCLIconAnchor, {
        { GCLIconAnchorCenter, "center" },
        { GCLIconAnchorLeft, "left" },
        { GCLIconAnchorRight, "right" },
        { GCLIconAnchorTop, "top" },
        { GCLIconAnchorBottom, "bottom" },
        { GCLIconAnchorTopLeft, "top-left" },
        { GCLIconAnchorTopRight, "top-right" },
        { GCLIconAnchorBottomLeft, "bottom-left" },
        { GCLIconAnchorBottomRight, "bottom-right" },
    });

    MBGL_DEFINE_ENUM(GCLIconPitchAlignment, {
        { GCLIconPitchAlignmentMap, "map" },
        { GCLIconPitchAlignmentViewport, "viewport" },
        { GCLIconPitchAlignmentAuto, "auto" },
    });

    MBGL_DEFINE_ENUM(GCLIconRotationAlignment, {
        { GCLIconRotationAlignmentMap, "map" },
        { GCLIconRotationAlignmentViewport, "viewport" },
        { GCLIconRotationAlignmentAuto, "auto" },
    });

    MBGL_DEFINE_ENUM(GCLIconTextFit, {
        { GCLIconTextFitNone, "none" },
        { GCLIconTextFitWidth, "width" },
        { GCLIconTextFitHeight, "height" },
        { GCLIconTextFitBoth, "both" },
    });

    MBGL_DEFINE_ENUM(GCLSymbolPlacement, {
        { GCLSymbolPlacementPoint, "point" },
        { GCLSymbolPlacementLine, "line" },
    });

    MBGL_DEFINE_ENUM(GCLTextAnchor, {
        { GCLTextAnchorCenter, "center" },
        { GCLTextAnchorLeft, "left" },
        { GCLTextAnchorRight, "right" },
        { GCLTextAnchorTop, "top" },
        { GCLTextAnchorBottom, "bottom" },
        { GCLTextAnchorTopLeft, "top-left" },
        { GCLTextAnchorTopRight, "top-right" },
        { GCLTextAnchorBottomLeft, "bottom-left" },
        { GCLTextAnchorBottomRight, "bottom-right" },
    });

    MBGL_DEFINE_ENUM(GCLTextJustification, {
        { GCLTextJustificationLeft, "left" },
        { GCLTextJustificationCenter, "center" },
        { GCLTextJustificationRight, "right" },
    });

    MBGL_DEFINE_ENUM(GCLTextPitchAlignment, {
        { GCLTextPitchAlignmentMap, "map" },
        { GCLTextPitchAlignmentViewport, "viewport" },
        { GCLTextPitchAlignmentAuto, "auto" },
    });

    MBGL_DEFINE_ENUM(GCLTextRotationAlignment, {
        { GCLTextRotationAlignmentMap, "map" },
        { GCLTextRotationAlignmentViewport, "viewport" },
        { GCLTextRotationAlignmentAuto, "auto" },
    });

    MBGL_DEFINE_ENUM(GCLTextTransform, {
        { GCLTextTransformNone, "none" },
        { GCLTextTransformUppercase, "uppercase" },
        { GCLTextTransformLowercase, "lowercase" },
    });

    MBGL_DEFINE_ENUM(GCLIconTranslationAnchor, {
        { GCLIconTranslationAnchorMap, "map" },
        { GCLIconTranslationAnchorViewport, "viewport" },
    });

    MBGL_DEFINE_ENUM(GCLTextTranslationAnchor, {
        { GCLTextTranslationAnchorMap, "map" },
        { GCLTextTranslationAnchorViewport, "viewport" },
    });

}

@interface GCLSymbolStyleLayer ()

@property (nonatomic, readonly) mbgl::style::SymbolLayer *rawLayer;

@end

@implementation GCLSymbolStyleLayer

- (instancetype)initWithIdentifier:(NSString *)identifier source:(GCLSource *)source
{
    auto layer = std::make_unique<mbgl::style::SymbolLayer>(identifier.UTF8String, source.identifier.UTF8String);
    return self = [super initWithPendingLayer:std::move(layer)];
}

- (mbgl::style::SymbolLayer *)rawLayer
{
    return (mbgl::style::SymbolLayer *)super.rawLayer;
}

- (NSString *)sourceIdentifier
{
    GCLAssertStyleLayerIsValid();

    return @(self.rawLayer->getSourceID().c_str());
}

- (NSString *)sourceLayerIdentifier
{
    GCLAssertStyleLayerIsValid();

    auto layerID = self.rawLayer->getSourceLayer();
    return layerID.empty() ? nil : @(layerID.c_str());
}

- (void)setSourceLayerIdentifier:(NSString *)sourceLayerIdentifier
{
    GCLAssertStyleLayerIsValid();

    self.rawLayer->setSourceLayer(sourceLayerIdentifier.UTF8String ?: "");
}

- (void)setPredicate:(NSPredicate *)predicate
{
    GCLAssertStyleLayerIsValid();

    self.rawLayer->setFilter(predicate ? predicate.gcl_filter : mbgl::style::NullFilter());
}

- (NSPredicate *)predicate
{
    GCLAssertStyleLayerIsValid();

    return [NSPredicate mgl_predicateWithFilter:self.rawLayer->getFilter()];
}

#pragma mark - Accessing the Layout Attributes

- (void)setIconAllowsOverlap:(GCLStyleValue<NSNumber *> *)iconAllowsOverlap {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(iconAllowsOverlap);
    self.rawLayer->setIconAllowOverlap(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)iconAllowsOverlap {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconAllowOverlap();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultIconAllowOverlap());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setIconAllowOverlap:(GCLStyleValue<NSNumber *> *)iconAllowOverlap {
}

- (GCLStyleValue<NSNumber *> *)iconAllowOverlap {
    return self.iconAllowsOverlap;
}

- (void)setIconAnchor:(GCLStyleValue<NSValue *> *)iconAnchor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::SymbolAnchorType, NSValue *, mbgl::style::SymbolAnchorType, GCLIconAnchor>().toDataDrivenPropertyValue(iconAnchor);
    self.rawLayer->setIconAnchor(mbglValue);
}

- (GCLStyleValue<NSValue *> *)iconAnchor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconAnchor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::SymbolAnchorType, NSValue *, mbgl::style::SymbolAnchorType, GCLIconAnchor>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconAnchor());
    }
    return GCLStyleValueTransformer<mbgl::style::SymbolAnchorType, NSValue *, mbgl::style::SymbolAnchorType, GCLIconAnchor>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconIgnoresPlacement:(GCLStyleValue<NSNumber *> *)iconIgnoresPlacement {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(iconIgnoresPlacement);
    self.rawLayer->setIconIgnorePlacement(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)iconIgnoresPlacement {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconIgnorePlacement();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultIconIgnorePlacement());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setIconIgnorePlacement:(GCLStyleValue<NSNumber *> *)iconIgnorePlacement {
}

- (GCLStyleValue<NSNumber *> *)iconIgnorePlacement {
    return self.iconIgnoresPlacement;
}

- (void)setIconImageName:(GCLStyleValue<NSString *> *)iconImageName {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::string, NSString *>().toDataDrivenPropertyValue(iconImageName);
    self.rawLayer->setIconImage(mbglValue);
}

- (GCLStyleValue<NSString *> *)iconImageName {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconImage();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::string, NSString *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconImage());
    }
    return GCLStyleValueTransformer<std::string, NSString *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconImage:(GCLStyleValue<NSString *> *)iconImage {
}

- (GCLStyleValue<NSString *> *)iconImage {
    return self.iconImageName;
}

- (void)setIconOffset:(GCLStyleValue<NSValue *> *)iconOffset {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toDataDrivenPropertyValue(iconOffset);
    self.rawLayer->setIconOffset(mbglValue);
}

- (GCLStyleValue<NSValue *> *)iconOffset {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconOffset();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconOffset());
    }
    return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconOptional:(GCLStyleValue<NSNumber *> *)iconOptional {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(iconOptional);
    self.rawLayer->setIconOptional(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)isIconOptional {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconOptional();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultIconOptional());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setIconPadding:(GCLStyleValue<NSNumber *> *)iconPadding {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(iconPadding);
    self.rawLayer->setIconPadding(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)iconPadding {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconPadding();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultIconPadding());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setIconPitchAlignment:(GCLStyleValue<NSValue *> *)iconPitchAlignment {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLIconPitchAlignment>().toEnumPropertyValue(iconPitchAlignment);
    self.rawLayer->setIconPitchAlignment(mbglValue);
}

- (GCLStyleValue<NSValue *> *)iconPitchAlignment {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconPitchAlignment();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLIconPitchAlignment>().toEnumStyleValue(self.rawLayer->getDefaultIconPitchAlignment());
    }
    return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLIconPitchAlignment>().toEnumStyleValue(propertyValue);
}

- (void)setIconRotation:(GCLStyleValue<NSNumber *> *)iconRotation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(iconRotation);
    self.rawLayer->setIconRotate(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)iconRotation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconRotate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconRotate());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconRotate:(GCLStyleValue<NSNumber *> *)iconRotate {
}

- (GCLStyleValue<NSNumber *> *)iconRotate {
    return self.iconRotation;
}

- (void)setIconRotationAlignment:(GCLStyleValue<NSValue *> *)iconRotationAlignment {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLIconRotationAlignment>().toEnumPropertyValue(iconRotationAlignment);
    self.rawLayer->setIconRotationAlignment(mbglValue);
}

- (GCLStyleValue<NSValue *> *)iconRotationAlignment {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconRotationAlignment();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLIconRotationAlignment>().toEnumStyleValue(self.rawLayer->getDefaultIconRotationAlignment());
    }
    return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLIconRotationAlignment>().toEnumStyleValue(propertyValue);
}

- (void)setIconScale:(GCLStyleValue<NSNumber *> *)iconScale {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(iconScale);
    self.rawLayer->setIconSize(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)iconScale {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconSize();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconSize());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconSize:(GCLStyleValue<NSNumber *> *)iconSize {
}

- (GCLStyleValue<NSNumber *> *)iconSize {
    return self.iconScale;
}

- (void)setIconTextFit:(GCLStyleValue<NSValue *> *)iconTextFit {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::IconTextFitType, NSValue *, mbgl::style::IconTextFitType, GCLIconTextFit>().toEnumPropertyValue(iconTextFit);
    self.rawLayer->setIconTextFit(mbglValue);
}

- (GCLStyleValue<NSValue *> *)iconTextFit {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconTextFit();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::IconTextFitType, NSValue *, mbgl::style::IconTextFitType, GCLIconTextFit>().toEnumStyleValue(self.rawLayer->getDefaultIconTextFit());
    }
    return GCLStyleValueTransformer<mbgl::style::IconTextFitType, NSValue *, mbgl::style::IconTextFitType, GCLIconTextFit>().toEnumStyleValue(propertyValue);
}

- (void)setIconTextFitPadding:(GCLStyleValue<NSValue *> *)iconTextFitPadding {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 4>, NSValue *>().toInterpolatablePropertyValue(iconTextFitPadding);
    self.rawLayer->setIconTextFitPadding(mbglValue);
}

- (GCLStyleValue<NSValue *> *)iconTextFitPadding {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconTextFitPadding();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 4>, NSValue *>().toStyleValue(self.rawLayer->getDefaultIconTextFitPadding());
    }
    return GCLStyleValueTransformer<std::array<float, 4>, NSValue *>().toStyleValue(propertyValue);
}

- (void)setKeepsIconUpright:(GCLStyleValue<NSNumber *> *)keepsIconUpright {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(keepsIconUpright);
    self.rawLayer->setIconKeepUpright(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)keepsIconUpright {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconKeepUpright();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultIconKeepUpright());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setIconKeepUpright:(GCLStyleValue<NSNumber *> *)iconKeepUpright {
}

- (GCLStyleValue<NSNumber *> *)iconKeepUpright {
    return self.keepsIconUpright;
}

- (void)setKeepsTextUpright:(GCLStyleValue<NSNumber *> *)keepsTextUpright {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(keepsTextUpright);
    self.rawLayer->setTextKeepUpright(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)keepsTextUpright {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextKeepUpright();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultTextKeepUpright());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setTextKeepUpright:(GCLStyleValue<NSNumber *> *)textKeepUpright {
}

- (GCLStyleValue<NSNumber *> *)textKeepUpright {
    return self.keepsTextUpright;
}

- (void)setMaximumTextAngle:(GCLStyleValue<NSNumber *> *)maximumTextAngle {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(maximumTextAngle);
    self.rawLayer->setTextMaxAngle(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)maximumTextAngle {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextMaxAngle();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultTextMaxAngle());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setTextMaxAngle:(GCLStyleValue<NSNumber *> *)textMaxAngle {
}

- (GCLStyleValue<NSNumber *> *)textMaxAngle {
    return self.maximumTextAngle;
}

- (void)setMaximumTextWidth:(GCLStyleValue<NSNumber *> *)maximumTextWidth {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(maximumTextWidth);
    self.rawLayer->setTextMaxWidth(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)maximumTextWidth {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextMaxWidth();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextMaxWidth());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextMaxWidth:(GCLStyleValue<NSNumber *> *)textMaxWidth {
}

- (GCLStyleValue<NSNumber *> *)textMaxWidth {
    return self.maximumTextWidth;
}

- (void)setSymbolAvoidsEdges:(GCLStyleValue<NSNumber *> *)symbolAvoidsEdges {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(symbolAvoidsEdges);
    self.rawLayer->setSymbolAvoidEdges(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)symbolAvoidsEdges {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getSymbolAvoidEdges();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultSymbolAvoidEdges());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setSymbolAvoidEdges:(GCLStyleValue<NSNumber *> *)symbolAvoidEdges {
}

- (GCLStyleValue<NSNumber *> *)symbolAvoidEdges {
    return self.symbolAvoidsEdges;
}

- (void)setSymbolPlacement:(GCLStyleValue<NSValue *> *)symbolPlacement {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::SymbolPlacementType, NSValue *, mbgl::style::SymbolPlacementType, GCLSymbolPlacement>().toEnumPropertyValue(symbolPlacement);
    self.rawLayer->setSymbolPlacement(mbglValue);
}

- (GCLStyleValue<NSValue *> *)symbolPlacement {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getSymbolPlacement();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::SymbolPlacementType, NSValue *, mbgl::style::SymbolPlacementType, GCLSymbolPlacement>().toEnumStyleValue(self.rawLayer->getDefaultSymbolPlacement());
    }
    return GCLStyleValueTransformer<mbgl::style::SymbolPlacementType, NSValue *, mbgl::style::SymbolPlacementType, GCLSymbolPlacement>().toEnumStyleValue(propertyValue);
}

- (void)setSymbolSpacing:(GCLStyleValue<NSNumber *> *)symbolSpacing {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(symbolSpacing);
    self.rawLayer->setSymbolSpacing(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)symbolSpacing {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getSymbolSpacing();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultSymbolSpacing());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setText:(GCLStyleValue<NSString *> *)text {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::string, NSString *>().toDataDrivenPropertyValue(text);
    self.rawLayer->setTextField(mbglValue);
}

- (GCLStyleValue<NSString *> *)text {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextField();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::string, NSString *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextField());
    }
    return GCLStyleValueTransformer<std::string, NSString *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextField:(GCLStyleValue<NSString *> *)textField {
}

- (GCLStyleValue<NSString *> *)textField {
    return self.text;
}

- (void)setTextAllowsOverlap:(GCLStyleValue<NSNumber *> *)textAllowsOverlap {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(textAllowsOverlap);
    self.rawLayer->setTextAllowOverlap(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textAllowsOverlap {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextAllowOverlap();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultTextAllowOverlap());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setTextAllowOverlap:(GCLStyleValue<NSNumber *> *)textAllowOverlap {
}

- (GCLStyleValue<NSNumber *> *)textAllowOverlap {
    return self.textAllowsOverlap;
}

- (void)setTextAnchor:(GCLStyleValue<NSValue *> *)textAnchor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::SymbolAnchorType, NSValue *, mbgl::style::SymbolAnchorType, GCLTextAnchor>().toDataDrivenPropertyValue(textAnchor);
    self.rawLayer->setTextAnchor(mbglValue);
}

- (GCLStyleValue<NSValue *> *)textAnchor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextAnchor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::SymbolAnchorType, NSValue *, mbgl::style::SymbolAnchorType, GCLTextAnchor>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextAnchor());
    }
    return GCLStyleValueTransformer<mbgl::style::SymbolAnchorType, NSValue *, mbgl::style::SymbolAnchorType, GCLTextAnchor>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextFontNames:(GCLStyleValue<NSArray<NSString *> *> *)textFontNames {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::vector<std::string>, NSArray<NSString *> *, std::string>().toPropertyValue(textFontNames);
    self.rawLayer->setTextFont(mbglValue);
}

- (GCLStyleValue<NSArray<NSString *> *> *)textFontNames {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextFont();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::vector<std::string>, NSArray<NSString *> *, std::string>().toStyleValue(self.rawLayer->getDefaultTextFont());
    }
    return GCLStyleValueTransformer<std::vector<std::string>, NSArray<NSString *> *, std::string>().toStyleValue(propertyValue);
}

- (void)setTextFont:(GCLStyleValue<NSArray<NSString *> *> *)textFont {
}

- (GCLStyleValue<NSArray<NSString *> *> *)textFont {
    return self.textFontNames;
}

- (void)setTextFontSize:(GCLStyleValue<NSNumber *> *)textFontSize {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(textFontSize);
    self.rawLayer->setTextSize(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textFontSize {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextSize();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextSize());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextSize:(GCLStyleValue<NSNumber *> *)textSize {
}

- (GCLStyleValue<NSNumber *> *)textSize {
    return self.textFontSize;
}

- (void)setTextIgnoresPlacement:(GCLStyleValue<NSNumber *> *)textIgnoresPlacement {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(textIgnoresPlacement);
    self.rawLayer->setTextIgnorePlacement(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textIgnoresPlacement {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextIgnorePlacement();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultTextIgnorePlacement());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setTextIgnorePlacement:(GCLStyleValue<NSNumber *> *)textIgnorePlacement {
}

- (GCLStyleValue<NSNumber *> *)textIgnorePlacement {
    return self.textIgnoresPlacement;
}

- (void)setTextJustification:(GCLStyleValue<NSValue *> *)textJustification {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::TextJustifyType, NSValue *, mbgl::style::TextJustifyType, GCLTextJustification>().toDataDrivenPropertyValue(textJustification);
    self.rawLayer->setTextJustify(mbglValue);
}

- (GCLStyleValue<NSValue *> *)textJustification {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextJustify();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::TextJustifyType, NSValue *, mbgl::style::TextJustifyType, GCLTextJustification>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextJustify());
    }
    return GCLStyleValueTransformer<mbgl::style::TextJustifyType, NSValue *, mbgl::style::TextJustifyType, GCLTextJustification>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextJustify:(GCLStyleValue<NSValue *> *)textJustify {
}

- (GCLStyleValue<NSValue *> *)textJustify {
    return self.textJustification;
}

- (void)setTextLetterSpacing:(GCLStyleValue<NSNumber *> *)textLetterSpacing {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(textLetterSpacing);
    self.rawLayer->setTextLetterSpacing(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textLetterSpacing {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextLetterSpacing();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextLetterSpacing());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextLineHeight:(GCLStyleValue<NSNumber *> *)textLineHeight {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(textLineHeight);
    self.rawLayer->setTextLineHeight(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textLineHeight {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextLineHeight();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultTextLineHeight());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setTextOffset:(GCLStyleValue<NSValue *> *)textOffset {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toDataDrivenPropertyValue(textOffset);
    self.rawLayer->setTextOffset(mbglValue);
}

- (GCLStyleValue<NSValue *> *)textOffset {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextOffset();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextOffset());
    }
    return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextOptional:(GCLStyleValue<NSNumber *> *)textOptional {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(textOptional);
    self.rawLayer->setTextOptional(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)isTextOptional {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextOptional();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultTextOptional());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setTextPadding:(GCLStyleValue<NSNumber *> *)textPadding {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(textPadding);
    self.rawLayer->setTextPadding(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textPadding {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextPadding();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultTextPadding());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setTextPitchAlignment:(GCLStyleValue<NSValue *> *)textPitchAlignment {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLTextPitchAlignment>().toEnumPropertyValue(textPitchAlignment);
    self.rawLayer->setTextPitchAlignment(mbglValue);
}

- (GCLStyleValue<NSValue *> *)textPitchAlignment {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextPitchAlignment();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLTextPitchAlignment>().toEnumStyleValue(self.rawLayer->getDefaultTextPitchAlignment());
    }
    return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLTextPitchAlignment>().toEnumStyleValue(propertyValue);
}

- (void)setTextRotation:(GCLStyleValue<NSNumber *> *)textRotation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(textRotation);
    self.rawLayer->setTextRotate(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textRotation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextRotate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextRotate());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextRotate:(GCLStyleValue<NSNumber *> *)textRotate {
}

- (GCLStyleValue<NSNumber *> *)textRotate {
    return self.textRotation;
}

- (void)setTextRotationAlignment:(GCLStyleValue<NSValue *> *)textRotationAlignment {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLTextRotationAlignment>().toEnumPropertyValue(textRotationAlignment);
    self.rawLayer->setTextRotationAlignment(mbglValue);
}

- (GCLStyleValue<NSValue *> *)textRotationAlignment {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextRotationAlignment();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLTextRotationAlignment>().toEnumStyleValue(self.rawLayer->getDefaultTextRotationAlignment());
    }
    return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLTextRotationAlignment>().toEnumStyleValue(propertyValue);
}

- (void)setTextTransform:(GCLStyleValue<NSValue *> *)textTransform {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::TextTransformType, NSValue *, mbgl::style::TextTransformType, GCLTextTransform>().toDataDrivenPropertyValue(textTransform);
    self.rawLayer->setTextTransform(mbglValue);
}

- (GCLStyleValue<NSValue *> *)textTransform {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextTransform();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::TextTransformType, NSValue *, mbgl::style::TextTransformType, GCLTextTransform>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextTransform());
    }
    return GCLStyleValueTransformer<mbgl::style::TextTransformType, NSValue *, mbgl::style::TextTransformType, GCLTextTransform>().toDataDrivenStyleValue(propertyValue);
}

#pragma mark - Accessing the Paint Attributes

- (void)setIconColor:(GCLStyleValue<GCLColor *> *)iconColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(iconColor);
    self.rawLayer->setIconColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)iconColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setIconColorTransition(options);
}

- (GCLTransition)iconColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getIconColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setIconHaloBlur:(GCLStyleValue<NSNumber *> *)iconHaloBlur {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(iconHaloBlur);
    self.rawLayer->setIconHaloBlur(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)iconHaloBlur {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconHaloBlur();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconHaloBlur());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconHaloBlurTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setIconHaloBlurTransition(options);
}

- (GCLTransition)iconHaloBlurTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getIconHaloBlurTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setIconHaloColor:(GCLStyleValue<GCLColor *> *)iconHaloColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(iconHaloColor);
    self.rawLayer->setIconHaloColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)iconHaloColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconHaloColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconHaloColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconHaloColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setIconHaloColorTransition(options);
}

- (GCLTransition)iconHaloColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getIconHaloColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setIconHaloWidth:(GCLStyleValue<NSNumber *> *)iconHaloWidth {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(iconHaloWidth);
    self.rawLayer->setIconHaloWidth(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)iconHaloWidth {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconHaloWidth();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconHaloWidth());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconHaloWidthTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setIconHaloWidthTransition(options);
}

- (GCLTransition)iconHaloWidthTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getIconHaloWidthTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setIconOpacity:(GCLStyleValue<NSNumber *> *)iconOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(iconOpacity);
    self.rawLayer->setIconOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)iconOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultIconOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setIconOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setIconOpacityTransition(options);
}

- (GCLTransition)iconOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getIconOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setIconTranslation:(GCLStyleValue<NSValue *> *)iconTranslation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toInterpolatablePropertyValue(iconTranslation);
    self.rawLayer->setIconTranslate(mbglValue);
}

- (GCLStyleValue<NSValue *> *)iconTranslation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconTranslate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(self.rawLayer->getDefaultIconTranslate());
    }
    return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(propertyValue);
}

- (void)setIconTranslationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setIconTranslateTransition(options);
}

- (GCLTransition)iconTranslationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getIconTranslateTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setIconTranslate:(GCLStyleValue<NSValue *> *)iconTranslate {
}

- (GCLStyleValue<NSValue *> *)iconTranslate {
    return self.iconTranslation;
}

- (void)setIconTranslationAnchor:(GCLStyleValue<NSValue *> *)iconTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLIconTranslationAnchor>().toEnumPropertyValue(iconTranslationAnchor);
    self.rawLayer->setIconTranslateAnchor(mbglValue);
}

- (GCLStyleValue<NSValue *> *)iconTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getIconTranslateAnchor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLIconTranslationAnchor>().toEnumStyleValue(self.rawLayer->getDefaultIconTranslateAnchor());
    }
    return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLIconTranslationAnchor>().toEnumStyleValue(propertyValue);
}

- (void)setIconTranslateAnchor:(GCLStyleValue<NSValue *> *)iconTranslateAnchor {
}

- (GCLStyleValue<NSValue *> *)iconTranslateAnchor {
    return self.iconTranslationAnchor;
}

- (void)setTextColor:(GCLStyleValue<GCLColor *> *)textColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(textColor);
    self.rawLayer->setTextColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)textColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setTextColorTransition(options);
}

- (GCLTransition)textColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getTextColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setTextHaloBlur:(GCLStyleValue<NSNumber *> *)textHaloBlur {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(textHaloBlur);
    self.rawLayer->setTextHaloBlur(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textHaloBlur {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextHaloBlur();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextHaloBlur());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextHaloBlurTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setTextHaloBlurTransition(options);
}

- (GCLTransition)textHaloBlurTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getTextHaloBlurTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setTextHaloColor:(GCLStyleValue<GCLColor *> *)textHaloColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(textHaloColor);
    self.rawLayer->setTextHaloColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)textHaloColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextHaloColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextHaloColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextHaloColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setTextHaloColorTransition(options);
}

- (GCLTransition)textHaloColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getTextHaloColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setTextHaloWidth:(GCLStyleValue<NSNumber *> *)textHaloWidth {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(textHaloWidth);
    self.rawLayer->setTextHaloWidth(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textHaloWidth {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextHaloWidth();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextHaloWidth());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextHaloWidthTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setTextHaloWidthTransition(options);
}

- (GCLTransition)textHaloWidthTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getTextHaloWidthTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setTextOpacity:(GCLStyleValue<NSNumber *> *)textOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(textOpacity);
    self.rawLayer->setTextOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)textOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultTextOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setTextOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setTextOpacityTransition(options);
}

- (GCLTransition)textOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getTextOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setTextTranslation:(GCLStyleValue<NSValue *> *)textTranslation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toInterpolatablePropertyValue(textTranslation);
    self.rawLayer->setTextTranslate(mbglValue);
}

- (GCLStyleValue<NSValue *> *)textTranslation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextTranslate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(self.rawLayer->getDefaultTextTranslate());
    }
    return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(propertyValue);
}

- (void)setTextTranslationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setTextTranslateTransition(options);
}

- (GCLTransition)textTranslationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getTextTranslateTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setTextTranslate:(GCLStyleValue<NSValue *> *)textTranslate {
}

- (GCLStyleValue<NSValue *> *)textTranslate {
    return self.textTranslation;
}

- (void)setTextTranslationAnchor:(GCLStyleValue<NSValue *> *)textTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLTextTranslationAnchor>().toEnumPropertyValue(textTranslationAnchor);
    self.rawLayer->setTextTranslateAnchor(mbglValue);
}

- (GCLStyleValue<NSValue *> *)textTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getTextTranslateAnchor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLTextTranslationAnchor>().toEnumStyleValue(self.rawLayer->getDefaultTextTranslateAnchor());
    }
    return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLTextTranslationAnchor>().toEnumStyleValue(propertyValue);
}

- (void)setTextTranslateAnchor:(GCLStyleValue<NSValue *> *)textTranslateAnchor {
}

- (GCLStyleValue<NSValue *> *)textTranslateAnchor {
    return self.textTranslationAnchor;
}

@end

@implementation NSValue (GCLSymbolStyleLayerAdditions)

+ (NSValue *)valueWithGCLIconAnchor:(GCLIconAnchor)iconAnchor {
    return [NSValue value:&iconAnchor withObjCType:@encode(GCLIconAnchor)];
}

- (GCLIconAnchor)GCLIconAnchorValue {
    GCLIconAnchor iconAnchor;
    [self getValue:&iconAnchor];
    return iconAnchor;
}

+ (NSValue *)valueWithGCLIconPitchAlignment:(GCLIconPitchAlignment)iconPitchAlignment {
    return [NSValue value:&iconPitchAlignment withObjCType:@encode(GCLIconPitchAlignment)];
}

- (GCLIconPitchAlignment)GCLIconPitchAlignmentValue {
    GCLIconPitchAlignment iconPitchAlignment;
    [self getValue:&iconPitchAlignment];
    return iconPitchAlignment;
}

+ (NSValue *)valueWithGCLIconRotationAlignment:(GCLIconRotationAlignment)iconRotationAlignment {
    return [NSValue value:&iconRotationAlignment withObjCType:@encode(GCLIconRotationAlignment)];
}

- (GCLIconRotationAlignment)GCLIconRotationAlignmentValue {
    GCLIconRotationAlignment iconRotationAlignment;
    [self getValue:&iconRotationAlignment];
    return iconRotationAlignment;
}

+ (NSValue *)valueWithGCLIconTextFit:(GCLIconTextFit)iconTextFit {
    return [NSValue value:&iconTextFit withObjCType:@encode(GCLIconTextFit)];
}

- (GCLIconTextFit)GCLIconTextFitValue {
    GCLIconTextFit iconTextFit;
    [self getValue:&iconTextFit];
    return iconTextFit;
}

+ (NSValue *)valueWithGCLSymbolPlacement:(GCLSymbolPlacement)symbolPlacement {
    return [NSValue value:&symbolPlacement withObjCType:@encode(GCLSymbolPlacement)];
}

- (GCLSymbolPlacement)GCLSymbolPlacementValue {
    GCLSymbolPlacement symbolPlacement;
    [self getValue:&symbolPlacement];
    return symbolPlacement;
}

+ (NSValue *)valueWithGCLTextAnchor:(GCLTextAnchor)textAnchor {
    return [NSValue value:&textAnchor withObjCType:@encode(GCLTextAnchor)];
}

- (GCLTextAnchor)GCLTextAnchorValue {
    GCLTextAnchor textAnchor;
    [self getValue:&textAnchor];
    return textAnchor;
}

+ (NSValue *)valueWithGCLTextJustification:(GCLTextJustification)textJustification {
    return [NSValue value:&textJustification withObjCType:@encode(GCLTextJustification)];
}

- (GCLTextJustification)GCLTextJustificationValue {
    GCLTextJustification textJustification;
    [self getValue:&textJustification];
    return textJustification;
}

+ (NSValue *)valueWithGCLTextPitchAlignment:(GCLTextPitchAlignment)textPitchAlignment {
    return [NSValue value:&textPitchAlignment withObjCType:@encode(GCLTextPitchAlignment)];
}

- (GCLTextPitchAlignment)GCLTextPitchAlignmentValue {
    GCLTextPitchAlignment textPitchAlignment;
    [self getValue:&textPitchAlignment];
    return textPitchAlignment;
}

+ (NSValue *)valueWithGCLTextRotationAlignment:(GCLTextRotationAlignment)textRotationAlignment {
    return [NSValue value:&textRotationAlignment withObjCType:@encode(GCLTextRotationAlignment)];
}

- (GCLTextRotationAlignment)GCLTextRotationAlignmentValue {
    GCLTextRotationAlignment textRotationAlignment;
    [self getValue:&textRotationAlignment];
    return textRotationAlignment;
}

+ (NSValue *)valueWithGCLTextTransform:(GCLTextTransform)textTransform {
    return [NSValue value:&textTransform withObjCType:@encode(GCLTextTransform)];
}

- (GCLTextTransform)GCLTextTransformValue {
    GCLTextTransform textTransform;
    [self getValue:&textTransform];
    return textTransform;
}

+ (NSValue *)valueWithGCLIconTranslationAnchor:(GCLIconTranslationAnchor)iconTranslationAnchor {
    return [NSValue value:&iconTranslationAnchor withObjCType:@encode(GCLIconTranslationAnchor)];
}

- (GCLIconTranslationAnchor)GCLIconTranslationAnchorValue {
    GCLIconTranslationAnchor iconTranslationAnchor;
    [self getValue:&iconTranslationAnchor];
    return iconTranslationAnchor;
}

+ (NSValue *)valueWithGCLTextTranslationAnchor:(GCLTextTranslationAnchor)textTranslationAnchor {
    return [NSValue value:&textTranslationAnchor withObjCType:@encode(GCLTextTranslationAnchor)];
}

- (GCLTextTranslationAnchor)MGLTextTranslationAnchorValue {
    GCLTextTranslationAnchor textTranslationAnchor;
    [self getValue:&textTranslationAnchor];
    return textTranslationAnchor;
}

@end
