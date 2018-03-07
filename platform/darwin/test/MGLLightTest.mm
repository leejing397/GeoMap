// This file is generated.
// Edit platform/darwin/scripts/generate-style-code.js, then run `make darwin-style-code`.
#import <XCTest/XCTest.h>
#import <GeoMap/Geocompass.h>

#import "GCLLight_Private.h"

#import "../../darwin/src/NSDate+GCLAdditions.h"

#import <mbgl/style/light.hpp>
#import <mbgl/style/types.hpp>
#include <mbgl/style/transition_options.hpp>

@interface MGLLightTest : XCTestCase

@end

@implementation MGLLightTest

- (void)testProperties {

    GCLTransition defaultTransition = GCLTransitionMake(0, 0);
    GCLTransition transition = GCLTransitionMake(6, 3);
    mbgl::style::TransitionOptions transitionOptions { { MGLDurationFromTimeInterval(6) }, { MGLDurationFromTimeInterval(3) } };

    // anchor
    {
        mbgl::style::Light light;
        GCLLight *mglLight = [[GCLLight alloc] initWithMBGLLight:&light];
        auto lightFromMGLlight = [mglLight mbglLight];

        XCTAssertEqual(light.getDefaultAnchor(), lightFromMGLlight.getAnchor());
        XCTAssert([mglLight.anchor isKindOfClass:[GCLConstantStyleValue class]], @"mglLight.anchor isn’t a MGLConstantStyleValue.");
        NSValue *anchorValue = ((GCLConstantStyleValue *)mglLight.anchor).rawValue;
        XCTAssertEqual(anchorValue.GCLLightAnchorValue, GCLLightAnchorViewport);

        mbgl::style::PropertyValue<mbgl::style::LightAnchorType> propertyValue = { mbgl::style::LightAnchorType::Viewport };
        light.setAnchor(propertyValue);
        mglLight = [[GCLLight alloc] initWithMBGLLight:&light];
        lightFromMGLlight = [mglLight mbglLight];

        XCTAssertEqual(light.getAnchor(), lightFromMGLlight.getAnchor());
    }

    // position
    {
        mbgl::style::Light light;
        GCLLight *mglLight = [[GCLLight alloc] initWithMBGLLight:&light];
        auto lightFromMGLlight = [mglLight mbglLight];

        XCTAssertEqual(light.getDefaultPosition(), lightFromMGLlight.getPosition());
        auto positionTransition = lightFromMGLlight.getPositionTransition();
        XCTAssert(positionTransition.delay && MGLTimeIntervalFromDuration(*positionTransition.delay) == defaultTransition.delay);
        XCTAssert(positionTransition.duration && MGLTimeIntervalFromDuration(*positionTransition.duration) == defaultTransition.duration);

        std::array<float, 3> positionArray = { { 6, 180, 90 } };
        mbgl::style::Position position = { positionArray };
        mbgl::style::PropertyValue<mbgl::style::Position> propertyValue = { position };
        light.setPosition(propertyValue);
        light.setPositionTransition(transitionOptions);

        mglLight = [[GCLLight alloc] initWithMBGLLight:&light];
        lightFromMGLlight = [mglLight mbglLight];

        XCTAssertEqual(light.getPosition(), lightFromMGLlight.getPosition());
        positionTransition = lightFromMGLlight.getPositionTransition();
        XCTAssert(positionTransition.delay && MGLTimeIntervalFromDuration(*positionTransition.delay) == transition.delay);
        XCTAssert(positionTransition.duration && MGLTimeIntervalFromDuration(*positionTransition.duration) == transition.duration);

    }

    // color
    {
        mbgl::style::Light light;
        GCLLight *mglLight = [[GCLLight alloc] initWithMBGLLight:&light];
        auto lightFromMGLlight = [mglLight mbglLight];

        XCTAssertEqual(light.getDefaultColor(), lightFromMGLlight.getColor());
        auto colorTransition = lightFromMGLlight.getColorTransition();
        XCTAssert(colorTransition.delay && MGLTimeIntervalFromDuration(*colorTransition.delay) == defaultTransition.delay);
        XCTAssert(colorTransition.duration && MGLTimeIntervalFromDuration(*colorTransition.duration) == defaultTransition.duration);

        mbgl::style::PropertyValue<mbgl::Color> propertyValue = { { 1, 0, 0, 1 } };
        light.setColor(propertyValue);
        light.setColorTransition(transitionOptions);

        mglLight = [[GCLLight alloc] initWithMBGLLight:&light];
        lightFromMGLlight = [mglLight mbglLight];

        XCTAssertEqual(light.getColor(), lightFromMGLlight.getColor());
        colorTransition = lightFromMGLlight.getColorTransition();
        XCTAssert(colorTransition.delay && MGLTimeIntervalFromDuration(*colorTransition.delay) == transition.delay);
        XCTAssert(colorTransition.duration && MGLTimeIntervalFromDuration(*colorTransition.duration) == transition.duration);

    }

    // intensity
    {
        mbgl::style::Light light;
        GCLLight *mglLight = [[GCLLight alloc] initWithMBGLLight:&light];
        auto lightFromMGLlight = [mglLight mbglLight];

        XCTAssertEqual(light.getDefaultIntensity(), lightFromMGLlight.getIntensity());
        auto intensityTransition = lightFromMGLlight.getIntensityTransition();
        XCTAssert(intensityTransition.delay && MGLTimeIntervalFromDuration(*intensityTransition.delay) == defaultTransition.delay);
        XCTAssert(intensityTransition.duration && MGLTimeIntervalFromDuration(*intensityTransition.duration) == defaultTransition.duration);

        mbgl::style::PropertyValue<float> propertyValue = { 0xff };
        light.setIntensity(propertyValue);
        light.setIntensityTransition(transitionOptions);

        mglLight = [[GCLLight alloc] initWithMBGLLight:&light];
        lightFromMGLlight = [mglLight mbglLight];

        XCTAssertEqual(light.getIntensity(), lightFromMGLlight.getIntensity());
        intensityTransition = lightFromMGLlight.getIntensityTransition();
        XCTAssert(intensityTransition.delay && MGLTimeIntervalFromDuration(*intensityTransition.delay) == transition.delay);
        XCTAssert(intensityTransition.duration && MGLTimeIntervalFromDuration(*intensityTransition.duration) == transition.duration);

    }

}

- (void)testValueAdditions {
    GCLSphericalPosition position = MGLSphericalPositionMake(1.15, 210, 30);

    XCTAssertEqual([NSValue valueWithGCLSphericalPosition:position].GCLSphericalPositionValue.radial, position.radial);
    XCTAssertEqual([NSValue valueWithGCLSphericalPosition:position].GCLSphericalPositionValue.azimuthal, position.azimuthal);
    XCTAssertEqual([NSValue valueWithGCLSphericalPosition:position].GCLSphericalPositionValue.polar, position.polar);
    XCTAssertEqual([NSValue valueWithMGLLightAnchor:MGLLightAnchorMap].MGLLightAnchorValue, MGLLightAnchorMap);
    XCTAssertEqual([NSValue valueWithGCLLightAnchor:GCLLightAnchorViewport].GCLLightAnchorValue, GCLLightAnchorViewport);
}

@end
