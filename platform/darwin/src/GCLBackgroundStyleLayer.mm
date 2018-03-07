// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.

#import "GCLSource.h"
#import "NSPredicate+GCLAdditions.h"
#import "NSDate+GCLAdditions.h"
#import "GCLStyleLayer_Private.h"
#import "GCLStyleValue_Private.h"
#import "GCLBackgroundStyleLayer.h"

#include <mbgl/style/transition_options.hpp>
#include <mbgl/style/layers/background_layer.hpp>

@interface GCLBackgroundStyleLayer ()

@property (nonatomic, readonly) mbgl::style::BackgroundLayer *rawLayer;

@end

@implementation GCLBackgroundStyleLayer

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    auto layer = std::make_unique<mbgl::style::BackgroundLayer>(identifier.UTF8String);
    return self = [super initWithPendingLayer:std::move(layer)];
}

- (mbgl::style::BackgroundLayer *)rawLayer
{
    return (mbgl::style::BackgroundLayer *)super.rawLayer;
}

#pragma mark - Accessing the Paint Attributes

- (void)setBackgroundColor:(GCLStyleValue<GCLColor *> *)backgroundColor {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toInterpolatablePropertyValue(backgroundColor);
    self.rawLayer->setBackgroundColor(mbglValue);
}

- (GCLStyleValue<GCLColor *> *)backgroundColor {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getBackgroundColor();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toStyleValue(self.rawLayer->getDefaultBackgroundColor());
    }
    return GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toStyleValue(propertyValue);
}

- (void)setBackgroundColorTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setBackgroundColorTransition(options);
}

- (GCLTransition)backgroundColorTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getBackgroundColorTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setBackgroundOpacity:(GCLStyleValue<NSNumber *> *)backgroundOpacity {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(backgroundOpacity);
    self.rawLayer->setBackgroundOpacity(mbglValue);
}

- (GCLStyleValue<NSNumber *> *)backgroundOpacity {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getBackgroundOpacity();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(self.rawLayer->getDefaultBackgroundOpacity());
    }
    return GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(propertyValue);
}

- (void)setBackgroundOpacityTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setBackgroundOpacityTransition(options);
}

- (GCLTransition)backgroundOpacityTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getBackgroundOpacityTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

- (void)setBackgroundPattern:(GCLStyleValue<NSString *> *)backgroundPattern {
    GCLAssertStyleLayerIsValid();

    auto mbglValue = GCLStyleValueTransformer<std::string, NSString *>().toPropertyValue(backgroundPattern);
    self.rawLayer->setBackgroundPattern(mbglValue);
}

- (GCLStyleValue<NSString *> *)backgroundPattern {
    GCLAssertStyleLayerIsValid();

    auto propertyValue = self.rawLayer->getBackgroundPattern();
    if (propertyValue.isUndefined()) {
        return GCLStyleValueTransformer<std::string, NSString *>().toStyleValue(self.rawLayer->getDefaultBackgroundPattern());
    }
    return GCLStyleValueTransformer<std::string, NSString *>().toStyleValue(propertyValue);
}

- (void)setBackgroundPatternTransition:(GCLTransition )transition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    self.rawLayer->setBackgroundPatternTransition(options);
}

- (GCLTransition)backgroundPatternTransition {
    GCLAssertStyleLayerIsValid();

    mbgl::style::TransitionOptions transitionOptions = self.rawLayer->getBackgroundPatternTransition();
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(transitionOptions.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(transitionOptions.delay.value_or(mbgl::Duration::zero()));

    return transition;
}

@end
