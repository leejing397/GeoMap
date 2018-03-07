#import <GeoMap/Geocompass.h>
#import <XCTest/XCTest.h>

#if TARGET_OS_IPHONE
#import "MGLUserLocation_Private.h"
#endif

@interface MGLCodingTests : XCTestCase
@end

@implementation MGLCodingTests

- (NSString *)temporaryFilePathForClass:(Class)clazz {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:NSStringFromClass(clazz)];
}

- (void)testPointAnnotation {
    MGLPointAnnotation *annotation = [[MGLPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(0.5, 0.5);
    annotation.title = @"title";
    annotation.subtitle = @"subtitle";

    NSString *filePath = [self temporaryFilePathForClass:MGLPointAnnotation.class];
    [NSKeyedArchiver archiveRootObject:annotation toFile:filePath];
    MGLPointAnnotation *unarchivedAnnotation = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(annotation, unarchivedAnnotation);
}

- (void)testPointFeature {
    GCLPointFeature *pointFeature = [[GCLPointFeature alloc] init];
    pointFeature.title = @"title";
    pointFeature.subtitle = @"subtitle";
    pointFeature.identifier = @(123);
    pointFeature.attributes = @{@"bbox": @[@1, @2, @3, @4]};

    NSString *filePath = [self temporaryFilePathForClass:GCLPointFeature.class];
    [NSKeyedArchiver archiveRootObject:pointFeature toFile:filePath];
    GCLPointFeature *unarchivedPointFeature = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(pointFeature, unarchivedPointFeature);
}

- (void)testPolyline {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0.129631234123, 1.7812739312551),
        CLLocationCoordinate2DMake(2.532083092342, 3.5216418292392)
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    MGLPolyline *polyline = [MGLPolyline polylineWithCoordinates:coordinates count:numberOfCoordinates];
    polyline.title = @"title";
    polyline.subtitle = @"subtitle";

    NSString *filePath = [self temporaryFilePathForClass:[MGLPolyline class]];
    [NSKeyedArchiver archiveRootObject:polyline toFile:filePath];
    MGLPolyline *unarchivedPolyline = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(polyline, unarchivedPolyline);

    CLLocationCoordinate2D otherCoordinates[] = {
        CLLocationCoordinate2DMake(-1, -2)
    };

    [unarchivedPolyline replaceCoordinatesInRange:NSMakeRange(0, 1) withCoordinates:otherCoordinates];

    XCTAssertNotEqualObjects(polyline, unarchivedPolyline);
    
    CLLocationCoordinate2D multiLineCoordinates[] = {
        CLLocationCoordinate2DMake(51.000000, 0.000000),
        CLLocationCoordinate2DMake(51.000000, 1.000000),
        CLLocationCoordinate2DMake(51.000000, 2.000000),
    };
    
    NSUInteger multiLineCoordinatesCount = sizeof(multiLineCoordinates) / sizeof(CLLocationCoordinate2D);
    MGLPolyline *multiLine = [MGLPolyline polylineWithCoordinates:multiLineCoordinates count:multiLineCoordinatesCount];
    CLLocationCoordinate2D multiLineCenter = CLLocationCoordinate2DMake(51.000000, 1.000000);
    
    XCTAssertEqual([multiLine coordinate].latitude, multiLineCenter.latitude);
    XCTAssertEqual([multiLine coordinate].longitude, multiLineCenter.longitude);
    
    CLLocationCoordinate2D segmentCoordinates[] = {
        CLLocationCoordinate2DMake(35.040390, -85.311477),
        CLLocationCoordinate2DMake(35.040390, -85.209510),
    };
    
    NSUInteger segmentCoordinatesCount = sizeof(segmentCoordinates) / sizeof(CLLocationCoordinate2D);
    MGLPolyline *segmentLine = [MGLPolyline polylineWithCoordinates:segmentCoordinates count:segmentCoordinatesCount];
    CLLocationCoordinate2D segmentCenter = CLLocationCoordinate2DMake(35.0404006631, -85.2604935);
    
    XCTAssertEqualWithAccuracy([segmentLine coordinate].latitude, segmentCenter.latitude, 0.0001);
    XCTAssertEqualWithAccuracy([segmentLine coordinate].longitude, segmentCenter.longitude, 0.0001);
    
    CLLocationCoordinate2D sfToBerkeleyCoordinates[] = {
        CLLocationCoordinate2DMake(37.782440, -122.397111),
        CLLocationCoordinate2DMake(37.818384, -122.352994),
        CLLocationCoordinate2DMake(37.831401, -122.274545),
        CLLocationCoordinate2DMake(37.862172, -122.262700),
    };
    
    NSUInteger sfToBerkeleyCoordinatesCount = sizeof(sfToBerkeleyCoordinates) / sizeof(CLLocationCoordinate2D);
    MGLPolyline *sfToBerkeleyLine = [MGLPolyline polylineWithCoordinates:sfToBerkeleyCoordinates count:sfToBerkeleyCoordinatesCount];
    CLLocationCoordinate2D sfToBerkeleyCenter = CLLocationCoordinate2DMake(37.8230575118,-122.324867587);
    
    XCTAssertEqualWithAccuracy([sfToBerkeleyLine coordinate].latitude, sfToBerkeleyCenter.latitude, 0.0001);
    XCTAssertEqualWithAccuracy([sfToBerkeleyLine coordinate].longitude, sfToBerkeleyCenter.longitude, 0.0001);
    
}

- (void)testPolygon {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(35.090745, -85.300259),
        CLLocationCoordinate2DMake(35.092035, -85.298885),
        CLLocationCoordinate2DMake(35.090639, -85.297416),
        CLLocationCoordinate2DMake(35.089112, -85.298928)
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    MGLPolygon *polygon = [MGLPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates];
    polygon.title = nil;
    polygon.subtitle = @"subtitle";

    NSString *filePath = [self temporaryFilePathForClass:[MGLPolygon class]];
    [NSKeyedArchiver archiveRootObject:polygon toFile:filePath];

    MGLPolygon *unarchivedPolygon = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    [unarchivedPolygon coordinate];

    XCTAssertEqualObjects(polygon, unarchivedPolygon);
    
    CLLocationCoordinate2D squareCoordinates[] = {
        CLLocationCoordinate2DMake(100.0, 0.0),
        CLLocationCoordinate2DMake(101.0, 0.0),
        CLLocationCoordinate2DMake(101.0, 1.0),
        CLLocationCoordinate2DMake(100.0, 1.0),
    };
    
    NSUInteger squareCoordinatesCount = sizeof(squareCoordinates) / sizeof(CLLocationCoordinate2D);
    MGLPolygon *squarePolygon = [MGLPolygon polygonWithCoordinates:squareCoordinates count:squareCoordinatesCount];
    CLLocationCoordinate2D squareCenter = CLLocationCoordinate2DMake(100.5, 0.5);
    
    XCTAssertEqual([squarePolygon coordinate].latitude, squareCenter.latitude);
    XCTAssertEqual([squarePolygon coordinate].longitude, squareCenter.longitude);

}

- (void)testPolygonWithInteriorPolygons {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 1),
        CLLocationCoordinate2DMake(10, 20)
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    CLLocationCoordinate2D interiorCoordinates[] = {
        CLLocationCoordinate2DMake(4, 4),
        CLLocationCoordinate2DMake(6, 6)
    };

    NSUInteger numberOfInteriorCoordinates = sizeof(interiorCoordinates) / sizeof(CLLocationCoordinate2D);

    MGLPolygon *interiorPolygon = [MGLPolygon polygonWithCoordinates:interiorCoordinates count:numberOfInteriorCoordinates];
    MGLPolygon *polygon = [MGLPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates interiorPolygons:@[interiorPolygon]];

    NSString *filePath = [self temporaryFilePathForClass:[MGLPolygon class]];
    [NSKeyedArchiver archiveRootObject:polygon toFile:filePath];

    MGLPolygon *unarchivedPolygon = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(polygon, unarchivedPolygon);
}

- (void)testPolylineFeature {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 1),
        CLLocationCoordinate2DMake(10, 20)
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    GCLPolylineFeature *polylineFeature = [GCLPolylineFeature polylineWithCoordinates:coordinates count:numberOfCoordinates];
    polylineFeature.attributes = @{@"bbox": @[@0, @1, @2, @3]};
    polylineFeature.identifier = @"identifier";

    NSString *filePath = [self temporaryFilePathForClass:[GCLPolylineFeature class]];
    [NSKeyedArchiver archiveRootObject:polylineFeature toFile:filePath];

    GCLPolylineFeature *unarchivedPolylineFeature = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(polylineFeature, unarchivedPolylineFeature);

    unarchivedPolylineFeature.attributes = @{@"bbox": @[@4, @3, @2, @1]};

    XCTAssertNotEqualObjects(polylineFeature, unarchivedPolylineFeature);
}

- (void)testPolygonFeature {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 1),
        CLLocationCoordinate2DMake(10, 20)
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    GCLPolygonFeature *polygonFeature = [GCLPolygonFeature polygonWithCoordinates:coordinates count:numberOfCoordinates];

    NSString *filePath = [self temporaryFilePathForClass:[GCLPolygonFeature class]];
    [NSKeyedArchiver archiveRootObject:polygonFeature toFile:filePath];

    GCLPolygonFeature *unarchivedPolygonFeature = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(polygonFeature, unarchivedPolygonFeature);

    unarchivedPolygonFeature.identifier = @"test";

    XCTAssertNotEqualObjects(polygonFeature, unarchivedPolygonFeature);
}

- (void)testPointCollection {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 1),
        CLLocationCoordinate2DMake(10, 11),
        CLLocationCoordinate2DMake(20, 21),
        CLLocationCoordinate2DMake(30, 31),
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    MGLPointCollection *pointCollection = [MGLPointCollection pointCollectionWithCoordinates:coordinates count:numberOfCoordinates];
    CLLocationCoordinate2D pointsCenter = CLLocationCoordinate2DMake(0, 1);
    
    XCTAssertEqual([pointCollection coordinate].latitude, pointsCenter.latitude);
    XCTAssertEqual([pointCollection coordinate].longitude, pointsCenter.longitude);
    
    NSString *filePath = [self temporaryFilePathForClass:[MGLPointCollection class]];
    [NSKeyedArchiver archiveRootObject:pointCollection toFile:filePath];

    MGLPointCollection *unarchivedPointCollection = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(pointCollection, unarchivedPointCollection);
}

- (void)testPointCollectionFeature {
    NSMutableArray *features = [NSMutableArray array];
    for (NSUInteger i = 0; i < 100; i++) {
        GCLPointFeature *feature = [[GCLPointFeature alloc] init];
        feature.coordinate = CLLocationCoordinate2DMake(arc4random() % 90, arc4random() % 180);
        [features addObject:feature];
    }

    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 1),
        CLLocationCoordinate2DMake(10, 11),
        CLLocationCoordinate2DMake(20, 21),
        CLLocationCoordinate2DMake(30, 31),
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    GCLPointCollectionFeature *collection = [GCLPointCollectionFeature pointCollectionWithCoordinates:coordinates count:numberOfCoordinates];
    collection.identifier = @"identifier";
    collection.attributes = @{@"bbox": @[@1, @2, @3, @4]};

    NSString *filePath = [self temporaryFilePathForClass:[GCLPointCollectionFeature class]];
    [NSKeyedArchiver archiveRootObject:collection toFile:filePath];

    GCLPointCollectionFeature *unarchivedCollection = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(collection, unarchivedCollection);

    unarchivedCollection.identifier = @"newIdentifier";

    XCTAssertNotEqualObjects(collection, unarchivedCollection);
}

- (void)testMultiPolyline {

    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 1),
        CLLocationCoordinate2DMake(10, 11),
        CLLocationCoordinate2DMake(20, 21),
        CLLocationCoordinate2DMake(30, 31),
    };
    
    CLLocationCoordinate2D line1[] = {
        CLLocationCoordinate2DMake(100, 40),
        CLLocationCoordinate2DMake(105, 45),
        CLLocationCoordinate2DMake(110, 55)
    };
    
    CLLocationCoordinate2D line2[] = {
        CLLocationCoordinate2DMake(105, 40),
        CLLocationCoordinate2DMake(110, 45),
        CLLocationCoordinate2DMake(115, 55)
    };
    
    NSUInteger road1CoordinatesCount = sizeof(line1) / sizeof(CLLocationCoordinate2D);
    NSUInteger road2CoordinatesCount = sizeof(line2) / sizeof(CLLocationCoordinate2D);
    
    MGLPolyline *road1Polyline = [MGLPolyline polylineWithCoordinates:line1 count:road1CoordinatesCount];
    MGLPolyline *road2Polyline = [MGLPolyline polylineWithCoordinates:line1 count:road2CoordinatesCount];
    
    GCLMultiPolyline *roads = [MGLMultiPolyline multiPolylineWithPolylines:@[road1Polyline, road2Polyline]];
    CLLocationCoordinate2D roadCenter = CLLocationCoordinate2DMake(100, 40);
    
    XCTAssertEqual([roads coordinate].latitude, roadCenter.latitude);
    XCTAssertEqual([roads coordinate].longitude, roadCenter.longitude);

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    NSMutableArray *polylines = [NSMutableArray array];

    for (NSUInteger i = 0; i < 100; i++) {
        MGLPolyline *polyline = [MGLPolyline polylineWithCoordinates:coordinates count:numberOfCoordinates];
        [polylines addObject:polyline];
    }

    GCLMultiPolyline *multiPolyline = [GCLMultiPolyline multiPolylineWithPolylines:polylines];

    NSString *filePath = [self temporaryFilePathForClass:[GCLMultiPolyline class]];
    [NSKeyedArchiver archiveRootObject:multiPolyline toFile:filePath];

    GCLMultiPolyline *unarchivedMultiPolyline = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    GCLMultiPolyline *anotherMultipolyline = [GCLMultiPolyline multiPolylineWithPolylines:[polylines subarrayWithRange:NSMakeRange(0, polylines.count/2)]];

    XCTAssertEqualObjects(multiPolyline, unarchivedMultiPolyline);
    XCTAssertNotEqualObjects(unarchivedMultiPolyline, anotherMultipolyline);
}

- (void)testMultiPolygon {

    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(0, 1),
        CLLocationCoordinate2DMake(10, 11),
        CLLocationCoordinate2DMake(20, 21),
        CLLocationCoordinate2DMake(30, 31),
    };
    
    CLLocationCoordinate2D outerSquare[] = {
        CLLocationCoordinate2DMake(100.0, 0.0),
        CLLocationCoordinate2DMake(101.0, 0.0),
        CLLocationCoordinate2DMake(101.0, 1.0),
        CLLocationCoordinate2DMake(100.0, 1.0),
    };
                                    
    CLLocationCoordinate2D innerSquare[] = {
        CLLocationCoordinate2DMake(100.35, 0.35),
        CLLocationCoordinate2DMake(100.65, 0.35),
        CLLocationCoordinate2DMake(100.65, 0.65),
        CLLocationCoordinate2DMake(100.35, 0.65),
    };
    
    NSUInteger outerCoordinatesCount = sizeof(outerSquare) / sizeof(CLLocationCoordinate2D);
    NSUInteger innerCoordinatesCount = sizeof(innerSquare) / sizeof(CLLocationCoordinate2D);
    
    MGLPolygon *innerPolygonSquare = [MGLPolygon polygonWithCoordinates:innerSquare count:innerCoordinatesCount];
    MGLPolygon *outerPolygonSquare = [MGLPolygon polygonWithCoordinates:outerSquare count:outerCoordinatesCount interiorPolygons:@[innerPolygonSquare]];
    GCLMultiPolygon *squares = [MGLMultiPolygon multiPolygonWithPolygons:@[outerPolygonSquare, innerPolygonSquare]];
    CLLocationCoordinate2D squareCenter = CLLocationCoordinate2DMake(100.5, 0.5);
    
    XCTAssertEqual([squares coordinate].latitude, squareCenter.latitude);
    XCTAssertEqual([squares coordinate].longitude, squareCenter.longitude);

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    NSMutableArray *polygons = [NSMutableArray array];

    for (NSUInteger i = 0; i < 100; i++) {
        MGLPolygon *polygon = [MGLPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates];
        [polygons addObject:polygon];
    }

    GCLMultiPolygon *multiPolygon = [GCLMultiPolygon multiPolygonWithPolygons:polygons];

    NSString *filePath = [self temporaryFilePathForClass:[GCLMultiPolygon class]];
    [NSKeyedArchiver archiveRootObject:multiPolygon toFile:filePath];

    GCLMultiPolygon *unarchivedMultiPolygon = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    GCLMultiPolygon *anotherMultiPolygon = [GCLMultiPolygon multiPolygonWithPolygons:[polygons subarrayWithRange:NSMakeRange(0, polygons.count/2)]];
    
    XCTAssertEqualObjects(multiPolygon, unarchivedMultiPolygon);
    XCTAssertNotEqualObjects(anotherMultiPolygon, unarchivedMultiPolygon);
    
}

- (void)testShapeCollection {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(10.12315786, 11.23451186),
        CLLocationCoordinate2DMake(20.91836515, 21.93689215),
        CLLocationCoordinate2DMake(30.55697246, 31.33988123),
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    MGLPolyline *polyline = [MGLPolyline polylineWithCoordinates:coordinates count:numberOfCoordinates];
    MGLPolygon *polygon = [MGLPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates];

    MGLShapeCollection *shapeCollection = [MGLShapeCollection shapeCollectionWithShapes:@[polyline, polygon]];

    NSString *filePath = [self temporaryFilePathForClass:[MGLShapeCollection class]];
    [NSKeyedArchiver archiveRootObject:shapeCollection toFile:filePath];

    MGLShapeCollection *unarchivedShapeCollection = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    MGLShapeCollection *anotherShapeCollection = [MGLShapeCollection shapeCollectionWithShapes:@[polygon]];

    XCTAssertEqualObjects(shapeCollection, unarchivedShapeCollection);
    XCTAssertNotEqualObjects(shapeCollection, anotherShapeCollection);
}

- (void)testMultiPolylineFeature {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(10.12315786, 11.23451186),
        CLLocationCoordinate2DMake(20.91836515, 21.93689215),
        CLLocationCoordinate2DMake(30.55697246, 31.33988123),
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    NSMutableArray *polylines = [NSMutableArray array];
    for (NSUInteger i = 0; i < 100; i++) {
        GCLPolylineFeature *polylineFeature = [GCLPolylineFeature polylineWithCoordinates:coordinates count:numberOfCoordinates];
        polylineFeature.identifier = @(arc4random() % 100).stringValue;
        [polylines addObject:polylineFeature];
    }

    GCLMultiPolylineFeature *multiPolylineFeature = [GCLMultiPolylineFeature multiPolylineWithPolylines:polylines];
    multiPolylineFeature.attributes = @{@"bbox": @[@4, @3, @2, @1]};

    NSString *filePath = [self temporaryFilePathForClass:[GCLMultiPolylineFeature class]];
    [NSKeyedArchiver archiveRootObject:multiPolylineFeature toFile:filePath];

    GCLMultiPolylineFeature *unarchivedMultiPolylineFeature = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    GCLMultiPolylineFeature *anotherMultiPolylineFeature = [GCLMultiPolylineFeature multiPolylineWithPolylines:[polylines subarrayWithRange:NSMakeRange(0, polylines.count/2)]];

    XCTAssertEqualObjects(multiPolylineFeature, unarchivedMultiPolylineFeature);
    XCTAssertNotEqualObjects(unarchivedMultiPolylineFeature, anotherMultiPolylineFeature);
}

- (void)testMultiPolygonFeature {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(10.12315786, 11.23451185),
        CLLocationCoordinate2DMake(20.88471238, 21.93684215),
        CLLocationCoordinate2DMake(30.15697236, 31.32988123),
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    NSMutableArray *polygons = [NSMutableArray array];
    for (NSUInteger i = 0; i < 100; i++ ) {
        GCLPolygonFeature *polygonFeature = [GCLPolygonFeature polygonWithCoordinates:coordinates count:numberOfCoordinates];
        polygonFeature.identifier = @(arc4random_uniform(100)).stringValue;
        [polygons addObject:polygonFeature];
    }

    GCLMultiPolygonFeature *multiPolygonFeature = [GCLMultiPolygonFeature multiPolygonWithPolygons:polygons];
    multiPolygonFeature.attributes = @{@"bbox": @[@(arc4random_uniform(100)),
                                                  @(arc4random_uniform(100)),
                                                  @(arc4random_uniform(100)),
                                                  @(arc4random_uniform(100))]};

    NSString *filePath = [self temporaryFilePathForClass:[GCLMultiPolylineFeature class]];
    [NSKeyedArchiver archiveRootObject:multiPolygonFeature toFile:filePath];

    GCLMultiPolygonFeature *unarchivedMultiPolygonFeature = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    GCLMultiPolygonFeature *anotherMultiPolygonFeature = [GCLMultiPolygonFeature multiPolygonWithPolygons:[polygons subarrayWithRange:NSMakeRange(0, polygons.count/2)]];

    XCTAssertEqualObjects(multiPolygonFeature, unarchivedMultiPolygonFeature);
    XCTAssertNotEqualObjects(anotherMultiPolygonFeature, unarchivedMultiPolygonFeature);
}

- (void)testShapeCollectionFeature {
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(10.12315786, 11.23451186),
        CLLocationCoordinate2DMake(20.91836515, 21.93689215),
        CLLocationCoordinate2DMake(30.55697246, 31.33988123),
    };

    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    GCLPolylineFeature *polyline = [GCLPolylineFeature polylineWithCoordinates:coordinates count:numberOfCoordinates];
    GCLPolygonFeature *polygon = [GCLPolygonFeature polygonWithCoordinates:coordinates count:numberOfCoordinates];

    GCLShapeCollectionFeature *shapeCollectionFeature = [GCLShapeCollectionFeature shapeCollectionWithShapes:@[polyline, polygon]];
    shapeCollectionFeature.identifier = @(arc4random_uniform(100)).stringValue;
    shapeCollectionFeature.attributes = @{@"bbox":@[@(arc4random_uniform(100)),
                                                    @(arc4random_uniform(100)),
                                                    @(arc4random_uniform(100)),
                                                    @(arc4random_uniform(100))]};

    NSString *filePath = [self temporaryFilePathForClass:[GCLShapeCollectionFeature class]];
    [NSKeyedArchiver archiveRootObject:shapeCollectionFeature toFile:filePath];

    GCLShapeCollectionFeature *unarchivedShapeCollectionFeature = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(shapeCollectionFeature, unarchivedShapeCollectionFeature);
}

- (void)testAnnotationImage {
#if TARGET_OS_IPHONE
    UIGraphicsBeginImageContext(CGSizeMake(10, 10));
    [[UIColor redColor] setFill];
    UIRectFill(CGRectMake(0, 0, 10, 10));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
#else
    NSImage *image = [[NSImage alloc] initWithSize:CGSizeMake(10, 10)];
    [image lockFocus];
    [[NSColor redColor] drawSwatchInRect:CGRectMake(0, 0, 10, 10)];
    [image unlockFocus];
#endif

    MGLAnnotationImage *annotationImage = [MGLAnnotationImage annotationImageWithImage:image reuseIdentifier:@(arc4random_uniform(100)).stringValue];

    NSString *filePath = [self temporaryFilePathForClass:[MGLAnnotationImage class]];
    [NSKeyedArchiver archiveRootObject:annotationImage toFile:filePath];

    MGLAnnotationImage *unarchivedAnnotationImage = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(annotationImage, unarchivedAnnotationImage);
}

#if TARGET_OS_IPHONE
- (void)testAnnotationView {
    MGLAnnotationView *annotationView = [[MGLAnnotationView alloc] initWithReuseIdentifier:@"id"];
    annotationView.enabled = NO;
    annotationView.selected = YES;
    annotationView.draggable = YES;
    annotationView.centerOffset = CGVectorMake(10, 10);
    annotationView.scalesWithViewingDistance = NO;

    NSString *filePath = [self temporaryFilePathForClass:[MGLAnnotationView class]];
    [NSKeyedArchiver archiveRootObject:annotationView toFile:filePath];

    MGLAnnotationView *unarchivedAnnotationView = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqual(annotationView.enabled, unarchivedAnnotationView.enabled);
    XCTAssertEqual(annotationView.selected, unarchivedAnnotationView.selected);
    XCTAssertEqual(annotationView.draggable, unarchivedAnnotationView.draggable);
    XCTAssertEqualObjects(NSStringFromCGVector(annotationView.centerOffset), NSStringFromCGVector(unarchivedAnnotationView.centerOffset));
    XCTAssertEqual(annotationView.scalesWithViewingDistance, unarchivedAnnotationView.scalesWithViewingDistance);
}
#endif

#if TARGET_OS_IPHONE
- (void)testUserLocation {
    GCLUserLocation *userLocation = [[GCLUserLocation alloc] init];
    userLocation.location = [[CLLocation alloc] initWithLatitude:1 longitude:1];

    NSString *filePath = [self temporaryFilePathForClass:[GCLUserLocation class]];
    [NSKeyedArchiver archiveRootObject:userLocation toFile:filePath];

    GCLUserLocation *unarchivedUserLocation = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqualObjects(userLocation, unarchivedUserLocation);
    unarchivedUserLocation.location = [[CLLocation alloc] initWithLatitude:10 longitude:10];
    XCTAssertNotEqualObjects(userLocation, unarchivedUserLocation);
}
#endif

#if TARGET_OS_IPHONE
- (void)testUserLocationAnnotationView {
    MGLUserLocationAnnotationView *annotationView = [[MGLUserLocationAnnotationView alloc] init];
    annotationView.enabled = NO;
    annotationView.selected = YES;
    annotationView.draggable = YES;
    annotationView.centerOffset = CGVectorMake(10, 10);
    annotationView.scalesWithViewingDistance = NO;

    NSString *filePath = [self temporaryFilePathForClass:[MGLUserLocationAnnotationView class]];
    [NSKeyedArchiver archiveRootObject:annotationView toFile:filePath];

    MGLUserLocationAnnotationView *unarchivedAnnotationView = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    XCTAssertEqual(annotationView.enabled, unarchivedAnnotationView.enabled);
    XCTAssertEqual(annotationView.selected, unarchivedAnnotationView.selected);
    XCTAssertEqual(annotationView.draggable, unarchivedAnnotationView.draggable);
    XCTAssertEqualObjects(NSStringFromCGVector(annotationView.centerOffset), NSStringFromCGVector(unarchivedAnnotationView.centerOffset));
    XCTAssertEqual(annotationView.scalesWithViewingDistance, unarchivedAnnotationView.scalesWithViewingDistance);
}
#endif

@end
