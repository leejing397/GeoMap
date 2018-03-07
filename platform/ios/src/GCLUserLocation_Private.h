#import "GCLUserLocation.h"

#import <CoreLocation/CoreLocation.h>

@class GCLMapView;

NS_ASSUME_NONNULL_BEGIN

@interface GCLUserLocation (Private)

@property (nonatomic, weak) GCLMapView *mapView;
@property (nonatomic, readwrite, nullable) CLLocation *location;
@property (nonatomic, readwrite, nullable) CLHeading *heading;

- (instancetype)initWithMapView:(GCLMapView *)mapView;

@end

NS_ASSUME_NONNULL_END
