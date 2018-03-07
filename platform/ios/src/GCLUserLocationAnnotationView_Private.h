#import "GCLUserLocationAnnotationView.h"
#import "GCLUserLocation.h"

NS_ASSUME_NONNULL_BEGIN

@class GCLMapView;

@interface GCLUserLocationAnnotationView (Private)

@property (nonatomic, weak, nullable) GCLUserLocation *userLocation;
@property (nonatomic, weak, nullable) GCLMapView *mapView;

@end

NS_ASSUME_NONNULL_END
