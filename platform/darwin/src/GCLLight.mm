// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.
// test

#import "GCLLight.h"

#import "GCLTypes.h"
#import "NSDate+GCLAdditions.h"
#import "GCLStyleValue_Private.h"
#import "NSValue+GCLAdditions.h"

#import <mbgl/style/light.hpp>
#import <mbgl/style/types.hpp>

namespace mbgl {

    MBGL_DEFINE_ENUM(GCLLightAnchor, {
        { GCLLightAnchorMap, "map" },
        { GCLLightAnchorViewport, "viewport" },
    });
    
}

NS_INLINE GCLTransition GCLTransitionFromOptions(const mbgl::style::TransitionOptions& options) {
    GCLTransition transition;
    transition.duration = GCLTimeIntervalFromDuration(options.duration.value_or(mbgl::Duration::zero()));
    transition.delay = GCLTimeIntervalFromDuration(options.delay.value_or(mbgl::Duration::zero()));
    
    return transition;
}

NS_INLINE mbgl::style::TransitionOptions GCLOptionsFromTransition(GCLTransition transition) {
    mbgl::style::TransitionOptions options { { GCLDurationFromTimeInterval(transition.duration) }, { GCLDurationFromTimeInterval(transition.delay) } };
    return options;
}

@interface GCLLight()

@end

@implementation GCLLight

- (instancetype)initWithMBGLLight:(const mbgl::style::Light *)mbglLight
{
    if (self = [super init]) {
        auto anchor = mbglLight->getAnchor();
        GCLStyleValue<NSValue *> *anchorStyleValue;
        if (anchor.isUndefined()) {
            mbgl::style::PropertyValue<mbgl::style::LightAnchorType> defaultAnchor = mbglLight->getDefaultAnchor();
            anchorStyleValue = GCLStyleValueTransformer<mbgl::style::LightAnchorType, NSValue *, mbgl::style::LightAnchorType, GCLLightAnchor>().toEnumStyleValue(defaultAnchor);
        } else {
            anchorStyleValue = GCLStyleValueTransformer<mbgl::style::LightAnchorType, NSValue *, mbgl::style::LightAnchorType, GCLLightAnchor>().toEnumStyleValue(anchor);
        }

        _anchor = anchorStyleValue;

        auto positionValue = mbglLight->getPosition();
        if (positionValue.isUndefined()) {
            _position = GCLStyleValueTransformer<mbgl::style::Position, NSValue *>().toStyleValue(mbglLight->getDefaultPosition());
        } else {
            _position = GCLStyleValueTransformer<mbgl::style::Position, NSValue *>().toStyleValue(positionValue);
        }
        
        _positionTransition = GCLTransitionFromOptions(mbglLight->getPositionTransition());
 
        auto colorValue = mbglLight->getColor();
        if (colorValue.isUndefined()) {
            _color = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toStyleValue(mbglLight->getDefaultColor());
        } else {
            _color = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toStyleValue(colorValue);
        }
        
        _colorTransition = GCLTransitionFromOptions(mbglLight->getColorTransition());
 
        auto intensityValue = mbglLight->getIntensity();
        if (intensityValue.isUndefined()) {
            _intensity = GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(mbglLight->getDefaultIntensity());
        } else {
            _intensity = GCLStyleValueTransformer<float, NSNumber *>().toStyleValue(intensityValue);
        }
        
        _intensityTransition = GCLTransitionFromOptions(mbglLight->getIntensityTransition());
 
    }

    return self;
}

- (mbgl::style::Light)mbglLight
{
    mbgl::style::Light mbglLight;
    auto anchor = GCLStyleValueTransformer<mbgl::style::LightAnchorType, NSValue *, mbgl::style::LightAnchorType, GCLLightAnchor>().toEnumPropertyValue(self.anchor);
    mbglLight.setAnchor(anchor);

    auto position = GCLStyleValueTransformer<mbgl::style::Position, NSValue *>().toInterpolatablePropertyValue(self.position);
    mbglLight.setPosition(position);
 
    mbglLight.setPositionTransition(GCLOptionsFromTransition(self.positionTransition));

    auto color = GCLStyleValueTransformer<mbgl::Color, GCLColor *>().toInterpolatablePropertyValue(self.color);
    mbglLight.setColor(color);
 
    mbglLight.setColorTransition(GCLOptionsFromTransition(self.colorTransition));

    auto intensity = GCLStyleValueTransformer<float, NSNumber *>().toInterpolatablePropertyValue(self.intensity);
    mbglLight.setIntensity(intensity);
 
    mbglLight.setIntensityTransition(GCLOptionsFromTransition(self.intensityTransition));

    
    return mbglLight;
}

@end
