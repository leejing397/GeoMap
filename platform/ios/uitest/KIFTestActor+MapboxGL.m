#import "KIFTestActor+MapboxGL.h"

#import <GeoMap/Geocompass.h>

#import <KIF/UIApplication-KIFAdditions.h>

@implementation KIFTestActor (MapboxGL)

- (UIWindow *)window {
    return [[UIApplication sharedApplication] statusBarWindow];
}

- (MGLTViewController *)viewController {
    return (MGLTViewController *)[[tester.mapView nextResponder] nextResponder];
}

- (GCLMapView *)mapView {
    return (GCLMapView *)[tester waitForViewWithAccessibilityLabel:@"Map"];
}

- (UIView *)compass {
    return [tester waitForViewWithAccessibilityLabel:@"Compass"];
}

@end
