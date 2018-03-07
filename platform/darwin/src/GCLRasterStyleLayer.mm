// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLSource.h"
#import "NSPredicate+GCLAdditions.h"
#import "NSDate+GCLAdditions.h"
#import "GCLStyleLayer_Private.h"
#import "GCLStyleValue_Private.h"
#import "GCLRasterStyleLayer.h"

#include <mbgl/style/transition_options.hpp>
#include <mbgl/style/layers/raster_layer.hpp>

@interface GCLRasterStyleLayer ()

@property (nonatomic, readonly) mbgl::style::RasterLayer *rawLayer;

@end

@implementation GCLRasterStyleLayer

- (instancetype)initWithIdentifier:(NSString *)identifier source:(GCLSource *)source
{
    auto layer = std::make_unique<mbgl::style::RasterLayer>(identifier.UTF8String, source.identifier.UTF8String);
    return self = [super initWithPendingLayer:std::move(layer)];
}

- (mbgl::style::RasterLayer *)rawLayer
{
    return (mbgl::style::RasterLayer *)super.rawLayer;
}

- (NSString *)sourceIdentifier
{
    GCLAssertStyleLayerIsValid();

    return @(self.rawLayer->getSourceID().c_str());
}

#pragma mark - Accessing the Paint Attributes

- (void)setMaximumRasterBrightness:(GCLStyleValue<NSNumber *> *)maximumRasterBrightness {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(maximumRasterBrightness);
    self.rawLayer->setRasterBrightnessMax(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)maximumRasterBrightness {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getRasterBrightnessMax();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultRasterBrightnessMax());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setMaximumRasterBrightnessTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setRasterBrightnessMaxTransition(options);
}

- (GCLTransition)maximumRasterBrightnessTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getRasterBrightnessMaxTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setRasterBrightnessMax:(GCLStyleValue<NSNumber *> *)rasterBrightnessMax {
}

- (GCLStyleValue<NSNumber *> *)rasterBrightnessMax {
    return self.maximumRasterBrightness;
}

- (void)setMinimumRasterBrightness:(GCLStyleValue<NSNumber *> *)minimumRasterBrightness {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(minimumRasterBrightness);
    self.rawLayer->setRasterBrightnessMin(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)minimumRasterBrightness {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getRasterBrightnessMin();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultRasterBrightnessMin());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setMinimumRasterBrightnessTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setRasterBrightnessMinTransition(options);
}

- (GCLTransition)minimumRasterBrightnessTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getRasterBrightnessMinTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setRasterBrightnessMin:(GCLStyleValue<NSNumber *> *)rasterBrightnessMin {
}

- (GCLStyleValue<NSNumber *> *)rasterBrightnessMin {
    return self.minimumRasterBrightness;
}

- (void)setRasterContrast:(GCLStyleValue<NSNumber *> *)rasterContrast {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(rasterContrast);
    self.rawLayer->setRasterContrast(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)rasterContrast {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getRasterContrast();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultRasterContrast());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setRasterContrastTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setRasterContrastTransition(options);
}

- (GCLTransition)rasterContrastTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getRasterContrastTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setRasterFadeDuration:(GCLStyleValue<NSNumber *> *)rasterFadeDuration {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(rasterFadeDuration);
    self.rawLayer->setRasterFadeDuration(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)rasterFadeDuration {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getRasterFadeDuration();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultRasterFadeDuration());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setRasterFadeDurationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setRasterFadeDurationTransition(options);
}

- (GCLTransition)rasterFadeDurationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getRasterFadeDurationTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setRasterHueRotation:(GCLStyleValue<NSNumber *> *)rasterHueRotation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(rasterHueRotation);
    self.rawLayer->setRasterHueRotate(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)rasterHueRotation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getRasterHueRotate();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultRasterHueRotate());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setRasterHueRotationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setRasterHueRotateTransition(options);
}

- (GCLTransition)rasterHueRotationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getRasterHueRotateTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setRasterHueRotate:(GCLStyleValue<NSNumber *> *)rasterHueRotate {
}

- (GCLStyleValue<NSNumber *> *)rasterHueRotate {
    return self.rasterHueRotation;
}

- (void)setRasterOpacity:(GCLStyleValue<NSNumber *> *)rasterOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(rasterOpacity);
    self.rawLayer->setRasterOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)rasterOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getRasterOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultRasterOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setRasterOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setRasterOpacityTransition(options);
}

- (GCLTransition)rasterOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getRasterOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setRasterSaturation:(GCLStyleValue<NSNumber *> *)rasterSaturation {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(rasterSaturation);
    self.rawLayer->setRasterSaturation(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)rasterSaturation {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getRasterSaturation();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultRasterSaturation());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setRasterSaturationTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setRasterSaturationTransition(options);
}

- (GCLTransition)rasterSaturationTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getRasterSaturationTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

@end
