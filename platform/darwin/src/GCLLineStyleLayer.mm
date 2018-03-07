// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLSource.h"
#import "NSPredicate+GCLAdditions.h"
#import "NSDate+GCLAdditions.h"
#import "GCLStyleLayer_Private.h"
#import "GCLStyleValue_Private.h"
#import "GCLLineStyleLayer.h"

#include <mbgl/style/transition_options.hpp>
#include <mbgl/style/layers/line_layer.hpp>

namespace mbgl {

    MBGL_DEFINE_ENUM(GCLLineCap, {
        { GCLLineCapButt, "butt" },
        { GCLLineCapRound, "round" },
        { GCLLineCapSquare, "square" },
    });

    MBGL_DEFINE_ENUM(GCLLineJoin, {
        { GCLLineJoinBevel, "bevel" },
        { GCLLineJoinRound, "round" },
        { GCLLineJoinMiter, "miter" },
    });

    MBGL_DEFINE_ENUM(GCLLineTranslationAnchor, {
        { GCLLineTranslationAnchorMap, "map" },
        { GCLLineTranslationAnchorViewport, "viewport" },
    });

}

@interface GCLLineStyleLayer ()

@property (nonatomic, readonly) mbgl::style::LineLayer *rawLayer;

@end

@implementation GCLLineStyleLayer

- (instancetype)initWithIdentifier:(NSString *)identifier source:(GCLSource *)source
{
    auto layer = std::make_unique<mbgl::style::LineLayer>(identifier.UTF8String, source.identifier.UTF8String);
    return self = [super initWithPendingLayer:std::move(layer)];
}

- (mbgl::style::LineLayer *)rawLayer
{
    return (mbgl::style::LineLayer *)super.rawLayer;
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

- (void)setLineCap:(GCLStyleValue<NSValue *> *)lineCap {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::LineCapType, NSValue *, mbgl::style::LineCapType, GCLLineCap>().toEnumPropertyValue(lineCap);
    self.rawLayer->setLineCap(mbglValue);
}

- (GCLStyleValue<NSValue *> *)lineCap {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineCap();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::LineCapType, NSValue *, mbgl::style::LineCapType, GCLLineCap>().toEnumStyleValue(self.rawLayer->getDefaultLineCap());
    }
    return GCLStyleValueTransformer<mbgl::style::LineCapType, NSValue *, mbgl::style::LineCapType, GCLLineCap>().toEnumStyleValue(propertyValue);
}

- (void)setLineJoin:(GCLStyleValue<NSValue *> *)lineJoin {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::LineJoinType, NSValue *, mbgl::style::LineJoinType, GCLLineJoin>().toDataDrivenPropertyValue(lineJoin);
    self.rawLayer->setLineJoin(mbglValue);
}

- (GCLStyleValue<NSValue *> *)lineJoin {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineJoin();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::LineJoinType, NSValue *, mbgl::style::LineJoinType, GCLLineJoin>().toDataDrivenStyleValue(self.rawLayer->getDefaultLineJoin());
    }
    return GCLStyleValueTransformer<mbgl::style::LineJoinType, NSValue *, mbgl::style::LineJoinType, GCLLineJoin>().toDataDrivenStyleValue(propertyValue);
}

- (void)setLineMiterLimit:(GCLStyleValue<NSNumber *> *)lineMiterLimit {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(lineMiterLimit);
    self.rawLayer->setLineMiterLimit(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)lineMiterLimit {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineMiterLimit();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultLineMiterLimit());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setLineRoundLimit:(GCLStyleValue<NSNumber *> *)lineRoundLimit {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(lineRoundLimit);
    self.rawLayer->setLineRoundLimit(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)lineRoundLimit {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineRoundLimit();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultLineRoundLimit());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

#pragma mark - Accessing the Paint Attributes

- (void)setLineBlur:(GCLStyleValue<NSNumber *> *)lineBlur {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(lineBlur);
    self.rawLayer->setLineBlur(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)lineBlur {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineBlur();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultLineBlur());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setLineBlurTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLineBlurTransition(options);
}

- (GCLTransition)lineBlurTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLineBlurTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setLineColor:(GCLStyleValue<GCLColor *> *)lineColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(lineColor);
    self.rawLayer->setLineColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)lineColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultLineColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setLineColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLineColorTransition(options);
}

- (GCLTransition)lineColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLineColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setLineDashPattern:(GCLStyleValue<NSArray<NSNumber *> *> *)lineDashPattern {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::vector<float>, NSArray<NSNumber *> *, float>().toPropertyValue(lineDashPattern);
    self.rawLayer->setLineDasharray(mbglValue);
}

- (GCLStyleValue<NSArray<NSNumber *> *> *)lineDashPattern {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineDasharray();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::vector<float>, NSArray<NSNumber *> *, float>().toStyleValue(self.rawLayer->getDefaultLineDasharray());
    }
    return GCLStyleValueTransformer<std::vector<float>, NSArray<NSNumber *> *, float>().toStyleValue(propertyValue);
}

- (void)setLineDashPatternTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLineDasharrayTransition(options);
}

- (GCLTransition)lineDashPatternTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLineDasharrayTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setLineDasharray:(GCLStyleValue<NSArray<NSNumber *> *> *)lineDasharray {
}

- (GCLStyleValue<NSArray<NSNumber *> *> *)lineDasharray {
    return self.lineDashPattern;
}

- (void)setLineGapWidth:(GCLStyleValue<NSNumber *> *)lineGapWidth {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(lineGapWidth);
    self.rawLayer->setLineGapWidth(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)lineGapWidth {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineGapWidth();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultLineGapWidth());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setLineGapWidthTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLineGapWidthTransition(options);
}

- (GCLTransition)lineGapWidthTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLineGapWidthTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setLineOffset:(GCLStyleValue<NSNumber *> *)lineOffset {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(lineOffset);
    self.rawLayer->setLineOffset(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)lineOffset {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineOffset();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultLineOffset());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setLineOffsetTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLineOffsetTransition(options);
}

- (GCLTransition)lineOffsetTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLineOffsetTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setLineOpacity:(GCLStyleValue<NSNumber *> *)lineOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(lineOpacity);
    self.rawLayer->setLineOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)lineOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultLineOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setLineOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLineOpacityTransition(options);
}

- (GCLTransition)lineOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLineOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setLinePattern:(GCLStyleValue<NSString *> *)linePattern {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::string, NSString *>().toPropertyValue(linePattern);
    self.rawLayer->setLinePattern(mbglValue);
}

- (GCLStyleValue<NSString *> *)linePattern {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLinePattern();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::string, NSString *>().toStyleValue(self.rawLayer->getDefaultLinePattern());
    }
    return GCLStyleValueTransformer<std::string, NSString *>().toStyleValue(propertyValue);
}

- (void)setLinePatternTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLinePatternTransition(options);
}

- (GCLTransition)linePatternTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLinePatternTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setLineTranslation:(GCLStyleValue<NSValue *> *)lineTranslation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toInterpolatablePropertyValue(lineTranslation);
    self.rawLayer->setLineTranslate(mbglValue);
}

- (GCLStyleValue<NSValue *> *)lineTranslation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineTranslate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(self.rawLayer->getDefaultLineTranslate());
    }
    return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(propertyValue);
}

- (void)setLineTranslationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLineTranslateTransition(options);
}

- (GCLTransition)lineTranslationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLineTranslateTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setLineTranslate:(GCLStyleValue<NSValue *> *)lineTranslate {
}

- (GCLStyleValue<NSValue *> *)lineTranslate {
    return self.lineTranslation;
}

- (void)setLineTranslationAnchor:(GCLStyleValue<NSValue *> *)lineTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLLineTranslationAnchor>().toEnumPropertyValue(lineTranslationAnchor);
    self.rawLayer->setLineTranslateAnchor(mbglValue);
}

- (GCLStyleValue<NSValue *> *)lineTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineTranslateAnchor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLLineTranslationAnchor>().toEnumStyleValue(self.rawLayer->getDefaultLineTranslateAnchor());
    }
    return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLLineTranslationAnchor>().toEnumStyleValue(propertyValue);
}

- (void)setLineTranslateAnchor:(GCLStyleValue<NSValue *> *)lineTranslateAnchor {
}

- (GCLStyleValue<NSValue *> *)lineTranslateAnchor {
    return self.lineTranslationAnchor;
}

- (void)setLineWidth:(GCLStyleValue<NSNumber *> *)lineWidth {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(lineWidth);
    self.rawLayer->setLineWidth(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)lineWidth {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getLineWidth();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultLineWidth());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setLineWidthTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setLineWidthTransition(options);
}

- (GCLTransition)lineWidthTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getLineWidthTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

@end

@implementation NSValue (GCLLineStyleLayerAdditions)

+ (NSValue *)valueWithGCLLineCap:(GCLLineCap)lineCap {
    return [NSValue value:&lineCap withObjCType:@encode(GCLLineCap)];
}

- (GCLLineCap)GCLLineCapValue {
    GCLLineCap lineCap;
    [self getValue:&lineCap];
    return lineCap;
}

+ (NSValue *)valueWithGCLLineJoin:(GCLLineJoin)lineJoin {
    return [NSValue value:&lineJoin withObjCType:@encode(GCLLineJoin)];
}

- (GCLLineJoin)GCLLineJoinValue {
    GCLLineJoin lineJoin;
    [self getValue:&lineJoin];
    return lineJoin;
}

+ (NSValue *)valueWithGCLLineTranslationAnchor:(GCLLineTranslationAnchor)lineTranslationAnchor {
    return [NSValue value:&lineTranslationAnchor withObjCType:@encode(GCLLineTranslationAnchor)];
}

- (GCLLineTranslationAnchor)GCLLineTranslationAnchorValue {
    GCLLineTranslationAnchor lineTranslationAnchor;
    [self getValue:&lineTranslationAnchor];
    return lineTranslationAnchor;
}

@end
