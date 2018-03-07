#import "NSArray+GCLAdditions.h"

#import "NSDictionary+GCLAdditions.h"
#import "NSExpression+MGLAdditions.mm"

@implementation NSArray (GCLAdditions)

- (std::vector<mbgl::Value>)gcl_vector {
    std::vector<mbgl::Value> vector;
    vector.reserve(self.count);
    for (id value in self) {
        if ([value isKindOfClass:[NSArray class]]) {
            std::vector<mbgl::Value> innerVector = [value gcl_vector];
            vector.push_back(innerVector);
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            mbgl::PropertyMap propertyMap = [value gcl_propertyMap];
            vector.push_back(propertyMap);
        } else {
            NSExpression *expression = [NSExpression expressionForConstantValue:value];
            vector.push_back(expression.gcl_constantMBGLValue);
        }
    }
    return vector;
}

- (NSAttributedString *)gcl_attributedComponentsJoinedByString:(NSString *)separator {
    NSAttributedString *attributedSeparator = [[NSAttributedString alloc] initWithString:separator];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    BOOL isSubsequentItem = NO;
    for (NSAttributedString *component in self) {
        NSAssert([component isKindOfClass:[NSAttributedString class]], @"Items in array must be attributed strings.");
        if (isSubsequentItem) {
            [attributedString appendAttributedString:attributedSeparator];
        }
        isSubsequentItem = YES;
        [attributedString appendAttributedString:component];
    }
    return attributedString;
}

+ (NSArray *)gcl_coordinatesFromCoordinates:(std::vector<CLLocationCoordinate2D>)coords {
    NSMutableArray *coordinates = [NSMutableArray array];
    for (auto coord : coords) {
        [coordinates addObject:@{@"latitude": @(coord.latitude),
                                 @"longitude": @(coord.longitude)}];
    }
    return coordinates;
}

- (std::vector<CLLocationCoordinate2D>)gcl_coordinates {
    NSUInteger numberOfCoordinates = [self count];
    CLLocationCoordinate2D *coords = (CLLocationCoordinate2D *)malloc(numberOfCoordinates * sizeof(CLLocationCoordinate2D));

    for (NSUInteger i = 0; i < numberOfCoordinates; i++) {
        coords[i] = CLLocationCoordinate2DMake([self[i][@"latitude"] doubleValue],
                                               [self[i][@"longitude"] doubleValue]);
    }

    std::vector<CLLocationCoordinate2D> coordinates = { coords, coords + numberOfCoordinates };
    free(coords);

    return coordinates;
}

@end
