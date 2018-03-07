#import "GCLPolygon+GCLAdditions.h"

@implementation GCLPolygon (GCLAdditions)

- (NS_ARRAY_OF(id) *)gcl_coordinates {
    NSMutableArray *coordinates = [NSMutableArray array];

    NSMutableArray *exteriorRing = [NSMutableArray array];
    for (NSUInteger index = 0; index < self.pointCount; index++) {
        CLLocationCoordinate2D coordinate = self.coordinates[index];
        [exteriorRing addObject:@[@(coordinate.longitude), @(coordinate.latitude)]];
    }
    [coordinates addObject:exteriorRing];

    for (GCLPolygon *interiorPolygon in self.interiorPolygons) {
        NSMutableArray *interiorRing = [NSMutableArray array];
        for (int index = 0; index < interiorPolygon.pointCount; index++) {
            CLLocationCoordinate2D coordinate = interiorPolygon.coordinates[index];
            [interiorRing addObject:@[@(coordinate.longitude), @(coordinate.latitude)]];
        }
        [coordinates addObject:interiorRing];
    }

    return [coordinates copy];
}

@end
