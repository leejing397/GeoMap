// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLSource.h"
#import "NSPredicate+GCLAdditions.h"
#import "NSDate+GCLAdditions.h"
#import "GCLStyleLayer_Private.h"
#import "GCLStyleValue_Private.h"
#import "GCLCircleStyleLayer.h"

#include <mbgl/style/transition_options.hpp>
#include <mbgl/style/layers/circle_layer.hpp>

namespace mbgl {

    MBGL_DEFINE_ENUM(GCLCirclePitchAlignment, {
        { GCLCirclePitchAlignmentMap, "map" },
        { GCLCirclePitchAlignmentViewport, "viewport" },
    });

    MBGL_DEFINE_ENUM(GCLCircleScaleAlignment, {
        { GCLCircleScaleAlignmentMap, "map" },
        { GCLCircleScaleAlignmentViewport, "viewport" },
    });

    MBGL_DEFINE_ENUM(GCLCircleTranslationAnchor, {
        { GCLCircleTranslationAnchorMap, "map" },
        { GCLCircleTranslationAnchorViewport, "viewport" },
    });

}

@interface GCLCircleStyleLayer ()

@property (nonatomic, readonly) mbgl::style::CircleLayer *rawLayer;

@end

@implementation GCLCircleStyleLayer

- (instancetype)initWithIdentifier:(NSString *)identifier source:(GCLSource *)source
{
    auto layer = std::make_unique<mbgl::style::CircleLayer>(identifier.UTF8String, source.identifier.UTF8String);
    return self = [super initWithPendingLayer:std::move(layer)];
}

- (mbgl::style::CircleLayer *)rawLayer
{
    return (mbgl::style::CircleLayer *)super.rawLayer;
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

#pragma mark - Accessing the Paint Attributes

- (void)setCircleBlur:(GCLStyleValue<NSNumber *> *)circleBlur {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(circleBlur);
    self.rawLayer->setCircleBlur(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)circleBlur {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleBlur();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultCircleBlur());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setCircleBlurTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setCircleBlurTransition(options);
}

- (GCLTransition)circleBlurTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getCircleBlurTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setCircleColor:(GCLStyleValue<GCLColor *> *)circleColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(circleColor);
    self.rawLayer->setCircleColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)circleColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultCircleColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setCircleColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setCircleColorTransition(options);
}

- (GCLTransition)circleColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getCircleColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setCircleOpacity:(GCLStyleValue<NSNumber *> *)circleOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(circleOpacity);
    self.rawLayer->setCircleOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)circleOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultCircleOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setCircleOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setCircleOpacityTransition(options);
}

- (GCLTransition)circleOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getCircleOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setCirclePitchAlignment:(GCLStyleValue<NSValue *> *)circlePitchAlignment {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLCirclePitchAlignment>().toEnumPropertyValue(circlePitchAlignment);
    self.rawLayer->setCirclePitchAlignment(mbglValue);
}

- (GCLStyleValue<NSValue *> *)circlePitchAlignment {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCirclePitchAlignment();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLCirclePitchAlignment>().toEnumStyleValue(self.rawLayer->getDefaultCirclePitchAlignment());
    }
    return GCLStyleValueTransformer<mbgl::style::AlignmentType, NSValue *, mbgl::style::AlignmentType, GCLCirclePitchAlignment>().toEnumStyleValue(propertyValue);
}

- (void)setCircleRadius:(GCLStyleValue<NSNumber *> *)circleRadius {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(circleRadius);
    self.rawLayer->setCircleRadius(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)circleRadius {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleRadius();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultCircleRadius());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setCircleRadiusTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setCircleRadiusTransition(options);
}

- (GCLTransition)circleRadiusTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getCircleRadiusTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setCircleScaleAlignment:(GCLStyleValue<NSValue *> *)circleScaleAlignment {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::CirclePitchScaleType, NSValue *, mbgl::style::CirclePitchScaleType, GCLCircleScaleAlignment>().toEnumPropertyValue(circleScaleAlignment);
    self.rawLayer->setCirclePitchScale(mbglValue);
}

- (GCLStyleValue<NSValue *> *)circleScaleAlignment {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCirclePitchScale();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::CirclePitchScaleType, NSValue *, mbgl::style::CirclePitchScaleType, GCLCircleScaleAlignment>().toEnumStyleValue(self.rawLayer->getDefaultCirclePitchScale());
    }
    return GCLStyleValueTransformer<mbgl::style::CirclePitchScaleType, NSValue *, mbgl::style::CirclePitchScaleType, GCLCircleScaleAlignment>().toEnumStyleValue(propertyValue);
}

- (void)setCirclePitchScale:(GCLStyleValue<NSValue *> *)circlePitchScale {
}

- (GCLStyleValue<NSValue *> *)circlePitchScale {
    return self.circleScaleAlignment;
}

- (void)setCircleStrokeColor:(GCLStyleValue<GCLColor *> *)circleStrokeColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(circleStrokeColor);
    self.rawLayer->setCircleStrokeColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)circleStrokeColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleStrokeColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultCircleStrokeColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setCircleStrokeColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setCircleStrokeColorTransition(options);
}

- (GCLTransition)circleStrokeColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getCircleStrokeColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setCircleStrokeOpacity:(GCLStyleValue<NSNumber *> *)circleStrokeOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(circleStrokeOpacity);
    self.rawLayer->setCircleStrokeOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)circleStrokeOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleStrokeOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultCircleStrokeOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setCircleStrokeOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setCircleStrokeOpacityTransition(options);
}

- (GCLTransition)circleStrokeOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getCircleStrokeOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setCircleStrokeWidth:(GCLStyleValue<NSNumber *> *)circleStrokeWidth {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(circleStrokeWidth);
    self.rawLayer->setCircleStrokeWidth(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)circleStrokeWidth {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleStrokeWidth();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultCircleStrokeWidth());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setCircleStrokeWidthTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setCircleStrokeWidthTransition(options);
}

- (GCLTransition)circleStrokeWidthTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getCircleStrokeWidthTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setCircleTranslation:(GCLStyleValue<NSValue *> *)circleTranslation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toInterpolatablePropertyValue(circleTranslation);
    self.rawLayer->setCircleTranslate(mbglValue);
}

- (GCLStyleValue<NSValue *> *)circleTranslation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleTranslate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(self.rawLayer->getDefaultCircleTranslate());
    }
    return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(propertyValue);
}

- (void)setCircleTranslationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setCircleTranslateTransition(options);
}

- (GCLTransition)circleTranslationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getCircleTranslateTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setCircleTranslate:(GCLStyleValue<NSValue *> *)circleTranslate {
}

- (GCLStyleValue<NSValue *> *)circleTranslate {
    return self.circleTranslation;
}

- (void)setCircleTranslationAnchor:(GCLStyleValue<NSValue *> *)circleTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLCircleTranslationAnchor>().toEnumPropertyValue(circleTranslationAnchor);
    self.rawLayer->setCircleTranslateAnchor(mbglValue);
}

- (GCLStyleValue<NSValue *> *)circleTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getCircleTranslateAnchor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLCircleTranslationAnchor>().toEnumStyleValue(self.rawLayer->getDefaultCircleTranslateAnchor());
    }
    return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLCircleTranslationAnchor>().toEnumStyleValue(propertyValue);
}

- (void)setCircleTranslateAnchor:(GCLStyleValue<NSValue *> *)circleTranslateAnchor {
}

- (GCLStyleValue<NSValue *> *)circleTranslateAnchor {
    return self.circleTranslationAnchor;
}

@end

@implementation NSValue (GCLCircleStyleLayerAdditions)

+ (NSValue *)valueWithGCLCirclePitchAlignment:(GCLCirclePitchAlignment)circlePitchAlignment {
    return [NSValue value:&circlePitchAlignment withObjCType:@encode(GCLCirclePitchAlignment)];
}

- (GCLCirclePitchAlignment)GCLCirclePitchAlignmentValue {
    GCLCirclePitchAlignment circlePitchAlignment;
    [self getValue:&circlePitchAlignment];
    return circlePitchAlignment;
}

+ (NSValue *)valueWithGCLCircleScaleAlignment:(GCLCircleScaleAlignment)circleScaleAlignment {
    return [NSValue value:&circleScaleAlignment withObjCType:@encode(GCLCircleScaleAlignment)];
}

- (GCLCircleScaleAlignment)GCLCircleScaleAlignmentValue {
    GCLCircleScaleAlignment circleScaleAlignment;
    [self getValue:&circleScaleAlignment];
    return circleScaleAlignment;
}

+ (NSValue *)valueWithGCLCircleTranslationAnchor:(GCLCircleTranslationAnchor)circleTranslationAnchor {
    return [NSValue value:&circleTranslationAnchor withObjCType:@encode(GCLCircleTranslationAnchor)];
}

- (GCLCircleTranslationAnchor)GCLCircleTranslationAnchorValue {
    GCLCircleTranslationAnchor circleTranslationAnchor;
    [self getValue:&circleTranslationAnchor];
    return circleTranslationAnchor;
}

@end
