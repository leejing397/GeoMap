#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol GCLLocationManagerDelegate;

@interface GCLLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id<GCLLocationManagerDelegate> delegate;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end

@protocol GCLLocationManagerDelegate <NSObject>

@optional

- (void)locationManager:(GCLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations;
- (void)locationManagerDidStartLocationUpdates:(GCLLocationManager *)locationManager;
- (void)locationManagerBackgroundLocationUpdatesDidTimeout:(GCLLocationManager *)locationManager;
- (void)locationManagerBackgroundLocationUpdatesDidAutomaticallyPause:(GCLLocationManager *)locationManager;
- (void)locationManagerDidStopLocationUpdates:(GCLLocationManager *)locationManager;

@end
