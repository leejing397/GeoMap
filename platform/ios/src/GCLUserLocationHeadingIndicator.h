#import <QuartzCore/QuartzCore.h>
#import "GCLUserLocationAnnotationView.h"

@protocol GCLUserLocationHeadingIndicator <NSObject>

- (instancetype)initWithUserLocationAnnotationView:(GCLUserLocationAnnotationView *)userLocationView;
- (void)updateHeadingAccuracy:(CLLocationDirection)accuracy;
- (void)updateTintColor:(CGColorRef)color;

@end
