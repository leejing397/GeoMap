// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLSource.h"
#import "NSPredicate+GCLAdditions.h"
#import "NSDate+GCLAdditions.h"
#import "GCLStyleLayer_Private.h"
#import "GCLStyleValue_Private.h"
#import "GCLFillStyleLayer.h"

#include <mbgl/style/transition_options.hpp>
#include <mbgl/style/layers/fill_layer.hpp>

namespace mbgl {

    MBGL_DEFINE_ENUM(GCLFillTranslationAnchor, {
        { GCLFillTranslationAnchorMap, "map" },
        { GCLFillTranslationAnchorViewport, "viewport" },
    });

}

@interface GCLFillStyleLayer ()

@property (nonatomic, readonly) mbgl::style::FillLayer *rawLayer;

@end

@implementation GCLFillStyleLayer

- (instancetype)initWithIdentifier:(NSString *)identifier source:(GCLSource *)source
{
    auto layer = std::make_unique<mbgl::style::FillLayer>(identifier.UTF8String, source.identifier.UTF8String);
    return self = [super initWithPendingLayer:std::move(layer)];
}

- (mbgl::style::FillLayer *)rawLayer
{
    return (mbgl::style::FillLayer *)super.rawLayer;
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

- (void)setFillAntialiased:(GCLStyleValue<NSNumber *> *)fillAntialiased {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<bool, NSNumber *>().toPropertyValue(fillAntialiased);
    self.rawLayer->setFillAntialias(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)isFillAntialiased {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillAntialias();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(self.rawLayer->getDefaultFillAntialias());
    }
    return GCLStyleValueTransformer<bool, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setFillAntialias:(GCLStyleValue<NSNumber *> *)fillAntialias {
}

- (GCLStyleValue<NSNumber *> *)fillAntialias {
    return self.isFillAntialiased;
}

- (void)setFillColor:(GCLStyleValue<GCLColor *> *)fillColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(fillColor);
    self.rawLayer->setFillColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)fillColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultFillColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setFillColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillColorTransition(options);
}

- (GCLTransition)fillColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillOpacity:(GCLStyleValue<NSNumber *> *)fillOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenPropertyValue(fillOpacity);
    self.rawLayer->setFillOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)fillOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(self.rawLayer->getDefaultFillOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setFillOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillOpacityTransition(options);
}

- (GCLTransition)fillOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillOutlineColor:(GCLStyleValue<GCLColor *> *)fillOutlineColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenPropertyValue(fillOutlineColor);
    self.rawLayer->setFillOutlineColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)fillOutlineColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillOutlineColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(self.rawLayer->getDefaultFillOutlineColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toDataDrivenStyleValue(propertyValue);
}

- (void)setFillOutlineColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillOutlineColorTransition(options);
}

- (GCLTransition)fillOutlineColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillOutlineColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillPattern:(GCLStyleValue<NSString *> *)fillPattern {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::string, NSString *>().toPropertyValue(fillPattern);
    self.rawLayer->setFillPattern(mbglValue);
}

- (GCLStyleValue<NSString *> *)fillPattern {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillPattern();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::string, NSString *>().toStyleValue(self.rawLayer->getDefaultFillPattern());
    }
    return GCLStyleValueTransformer<std::string, NSString *>().toStyleValue(propertyValue);
}

- (void)setFillPatternTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillPatternTransition(options);
}

- (GCLTransition)fillPatternTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillPatternTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillTranslation:(GCLStyleValue<NSValue *> *)fillTranslation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toInterpolatablePropertyValue(fillTranslation);
    self.rawLayer->setFillTranslate(mbglValue);
}

- (GCLStyleValue<NSValue *> *)fillTranslation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillTranslate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(self.rawLayer->getDefaultFillTranslate());
    }
    return GCLStyleValueTransformer<std::array<float, 2>, NSValue *>().toStyleValue(propertyValue);
}

- (void)setFillTranslationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setFillTranslateTransition(options);
}

- (GCLTransition)fillTranslationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getFillTranslateTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setFillTranslate:(GCLStyleValue<NSValue *> *)fillTranslate {
}

- (GCLStyleValue<NSValue *> *)fillTranslate {
    return self.fillTranslation;
}

- (void)setFillTranslationAnchor:(GCLStyleValue<NSValue *> *)fillTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLFillTranslationAnchor>().toEnumPropertyValue(fillTranslationAnchor);
    self.rawLayer->setFillTranslateAnchor(mbglValue);
}

- (GCLStyleValue<NSValue *> *)fillTranslationAnchor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getFillTranslateAnchor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLFillTranslationAnchor>().toEnumStyleValue(self.rawLayer->getDefaultFillTranslateAnchor());
    }
    return GCLStyleValueTransformer<mbgl::style::TranslateAnchorType, NSValue *, mbgl::style::TranslateAnchorType, GCLFillTranslationAnchor>().toEnumStyleValue(propertyValue);
}

- (void)setFillTranslateAnchor:(GCLStyleValue<NSValue *> *)fillTranslateAnchor {
}

- (GCLStyleValue<NSValue *> *)fillTranslateAnchor {
    return self.fillTranslationAnchor;
}

@end

@implementation NSValue (GCLFillStyleLayerAdditions)

+ (NSValue *)valueWithGCLFillTranslationAnchor:(GCLFillTranslationAnchor)fillTranslationAnchor {
    return [NSValue value:&fillTranslationAnchor withObjCType:@encode(GCLFillTranslationAnchor)];
}

- (GCLFillTranslationAnchor)GCLFillTranslationAnchorValue {
    GCLFillTranslationAnchor fillTranslationAnchor;
    [self getValue:&fillTranslationAnchor];
    return fillTranslationAnchor;
}

@end
