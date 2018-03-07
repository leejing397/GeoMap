// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLSource.h"
#import "NSPredicate+GCLAdditions.h"
#import "NSDate+GCLAdditions.h"
#import "GCLStyleLayer_Private.h"
#import "GCLStyleValue_Private.h"
#import "GCLFillExtrusionStyleLayer.h"

#include <mbgl/style/transition_options.hpp>
#include <mbgl/style/layers/fill_extrusion_layer.hpp>

namespace mbgl {

    MBGL_DEFINE_ENUM(GCLFillExtrusionTranslationAnchor, {
        { GCLFillExtrusionTranslationAnchorMap, "map" },
        { GCLFillExtrusionTranslationAnchorViewport, "viewport" },
    });

}

@interface GCLFillExtrusionStyleLayer ()

@property (nonatomic, readonly) mbgl::style::FillExtrusionLayer *rawLayer;

@end

@implementation GCLFillExtrusionStyleLayer

- (instancetype)initWithIdentifier:(NSString *)identifier source:(GCLSource *)source
{
    auto layer = std::make_unique<mbgl::style::FillExtrusionLayer>(identifier.UTF8String, source.identifier.UTF8String);
    return self = [super initWithPendingLayer:std::move(layer)];
}

- (mbgl::style::FillExtrusionLayer *)rawLayer
{
    return (mbgl::style::FillExtrusionLayer *)super.rawLayer;
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

- (void)setFillExtrusionBase:(GCLStyleValue<NSNumber *> *)fillExtrusionBase {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(fillExtrusionBase);
    self.rawLayer->setFillExtrusionBase(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)fillExtrusionBase {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillExtrusionBase();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultFillExtrusionBase());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setFillExtrusionBaseTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillExtrusionBaseTransition(options);
}

- (GCLTransition)fillExtrusionBaseTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillExtrusionBaseTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillExtrusionColor:(GCLStyleValue<GCLColor *> *)fillExtrusionColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(fillExtrusionColor);
    self.rawLayer->setFillExtrusionColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)fillExtrusionColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillExtrusionColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultFillExtrusionColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setFillExtrusionColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillExtrusionColorTransition(options);
}

- (GCLTransition)fillExtrusionColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillExtrusionColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillExtrusionHeight:(GCLStyleValue<NSNumber *> *)fillExtrusionHeight {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(fillExtrusionHeight);
    self.rawLayer->setFillExtrusionHeight(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)fillExtrusionHeight {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillExtrusionHeight();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultFillExtrusionHeight());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setFillExtrusionHeightTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillExtrusionHeightTransition(options);
}

- (GCLTransition)fillExtrusionHeightTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillExtrusionHeightTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillExtrusionOpacity:(GCLStyleValue<NSNumber *> *)fillExtrusionOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(fillExtrusionOpacity);
    self.rawLayer->setFillExtrusionOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)fillExtrusionOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillExtrusionOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultFillExtrusionOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setFillExtrusionOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillExtrusionOpacityTransition(options);
}

- (GCLTransition)fillExtrusionOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillExtrusionOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillExtrusionPattern:(GCLStyleValue<NSString *> *)fillExtrusionPattern {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::string, NSString *>().toPropertyValue(fillExtrusionPattern);
    self.rawLayer->setFillExtrusionPattern(mbglValue);
}

- (GCLStyleValue<NSString *> *)fillExtrusionPattern {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillExtrusionPattern();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::string, NSString *>().toStyleValue(self.rawLayer->getDefaultFillExtrusionPattern());
    }
    return GCLStyleValueTransformer<std::string, NSString *>().toStyleValue(propertyValue);
}

- (void)setFillExtrusionPatternTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillExtrusionPatternTransition(options);
}

- (GCLTransition)fillExtrusionPatternTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillExtrusionPatternTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillExtrusionTranslation:(GCLStyleValue<NSValue *> *)fillExtrusionTranslation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toInterpolatablePropertyValue(fillExtrusionTranslation);
    self.rawLayer->setFillExtrusionTranslate(mbglValue);
}

- (GCLStyleValue<NSValue *> *)fillExtrusionTranslation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillExtrusionTranslate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(self.rawLayer->getDefaultFillExtrusionTranslate());
    }
    return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(propertyValue);
}

- (void)setFillExtrusionTranslationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillExtrusionTranslateTransition(options);
}

- (GCLTransition)fillExtrusionTranslationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillExtrusionTranslateTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillExtrusionTranslate:(GCLStyleValue<NSValue *> *)fillExtrusionTranslate {
}

- (GCLStyleValue<NSValue *> *)fillExtrusionTranslate {
    return self.fillExtrusionTranslation;
}

- (void)setFillExtrusionTranslationAnchor:(GCLStyleValue<NSValue *> *)fillExtrusionTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLFillExtrusionTranslationAnchor>().toEnumPropertyValue(fillExtrusionTranslationAnchor);
    self.rawLayer->setFillExtrusionTranslateAnchor(mbglValue);
}

- (GCLStyleValue<NSValue *> *)fillExtrusionTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillExtrusionTranslateAnchor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLFillExtrusionTranslationAnchor>().toEnumStyleValue(self.rawLayer->getDefaultFillExtrusionTranslateAnchor());
    }
    return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLFillExtrusionTranslationAnchor>().toEnumStyleValue(propertyValue);
}

- (void)setFillExtrusionTranslateAnchor:(GCLStyleValue<NSValue *> *)fillExtrusionTranslateAnchor {
}

- (GCLStyleValue<NSValue *> *)fillExtrusionTranslateAnchor {
    return self.fillExtrusionTranslationAnchor;
}

@end

@implementation NSValue (GCLFillExtrusionStyleLayerAdditions)

+ (NSValue *)valueWithGCLFillExtrusionTranslationAnchor:(GCLFillExtrusionTranslationAnchor)fillExtrusionTranslationAnchor {
    return [NSValue value:&fillExtrusionTranslationAnchor withObjCType:@encode(GCLFillExtrusionTranslationAnchor)];
}

- (GCLFillExtrusionTranslationAnchor)GCLFillExtrusionTranslationAnchorValue {
    GCLFillExtrusionTranslationAnchor fillExtrusionTranslationAnchor;
    [self getValue:&fillExtrusionTranslationAnchor];
    return fillExtrusionTranslationAnchor;
}

@end
