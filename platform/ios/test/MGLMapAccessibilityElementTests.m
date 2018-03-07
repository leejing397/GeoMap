#import <GeoMap/Geocompass.h>
#import <XCTest/XCTest.h>

#import "../../ios/src/GCLMapAccessibilityElement.h"

@interface MGLMapAccessibilityElementTests : XCTestCase
@end

@implementation MGLMapAccessibilityElementTests

- (void)testFeatureLabels {
    GCLPointFeature *feature = [[GCLPointFeature alloc] init];
    feature.attributes = @{
        @"name": @"Local",
        @"name_en": @"English",
        @"name_es": @"Spanish",
        @"name_fr": @"French",
        @"name_tlh": @"Klingon",
    };
    GCLFeatureAccessibilityElement *element = [[MGLFeatureAccessibilityElement alloc] initWithAccessibilityContainer:self feature:feature];
    XCTAssertEqualObjects(element.accessibilityLabel, @"English", @"Accessibility label should be localized.");
    
    feature.attributes = @{
        @"name": @"Цинциннати",
        @"name_en": @"Цинциннати",
    };
    element = [[MGLFeatureAccessibilityElement alloc] initWithAccessibilityContainer:self feature:feature];
    XCTAssertEqualObjects(element.accessibilityLabel, @"Cincinnati", @"Accessibility label should be romanized.");
}

- (void)testPlaceFeatureValues {
    GCLPointFeature *feature = [[GCLPointFeature alloc] init];
    feature.attributes = @{
        @"type": @"village_green",
    };
    GCLPlaceFeatureAccessibilityElement *element = [[MGLPlaceFeatureAccessibilityElement alloc] initWithAccessibilityContainer:self feature:feature];
    XCTAssertEqualObjects(element.accessibilityValue, @"village green");
    
    feature = [[GCLPointFeature alloc] init];
    feature.attributes = @{
        @"maki": @"cat",
    };
    element = [[MGLPlaceFeatureAccessibilityElement alloc] initWithAccessibilityContainer:self feature:feature];
    XCTAssertEqualObjects(element.accessibilityValue, @"cat");
    
    feature = [[GCLPointFeature alloc] init];
    feature.attributes = @{
        @"elevation_ft": @31337,
        @"elevation_m": @1337,
    };
    element = [[MGLPlaceFeatureAccessibilityElement alloc] initWithAccessibilityContainer:self feature:feature];
    XCTAssertEqualObjects(element.accessibilityValue, @"31,337 feet");
}

- (void)testRoadFeatureValues {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 0),
        CLLocationCoordinate2DMake(0, 1),
        CLLocationCoordinate2DMake(1, 2),
        CLLocationCoordinate2DMake(2, 2),
    };
    GCLPolylineFeature *roadFeature = [GCLPolylineFeature polylineWithCoordinates:coordinates count:sizeof(coordinates) / sizeof(coordinates[0])];
    roadFeature.attributes = @{
        @"ref": @"42",
        @"oneway": @"true",
    };
    GCLRoadFeatureAccessibilityElement *element = [[MGLRoadFeatureAccessibilityElement alloc] initWithAccessibilityContainer:self feature:roadFeature];
    XCTAssertEqualObjects(element.accessibilityValue, @"Route 42, One way, southwest to northeast");
    
    CLLocationCoordinate2D opposingCoordinates[] = {
        CLLocationCoordinate2DMake(2, 1),
        CLLocationCoordinate2DMake(1, 0),
    };
    GCLPolylineFeature *opposingRoadFeature = [GCLPolylineFeature polylineWithCoordinates:opposingCoordinates count:sizeof(opposingCoordinates) / sizeof(opposingCoordinates[0])];
    opposingRoadFeature.attributes = @{
        @"ref": @"42",
        @"oneway": @"true",
    };
    GCLMultiPolylineFeature *dividedRoadFeature = [GCLMultiPolylineFeature multiPolylineWithPolylines:@[roadFeature, opposingRoadFeature]];
    dividedRoadFeature.attributes = @{
        @"ref": @"42",
    };
    element = [[MGLRoadFeatureAccessibilityElement alloc] initWithAccessibilityContainer:self feature:dividedRoadFeature];
    XCTAssertEqualObjects(element.accessibilityValue, @"Route 42, Divided road, southwest to northeast");
}

@end
