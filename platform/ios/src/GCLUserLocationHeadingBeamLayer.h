#import <QuartzCore/QuartzCore.h>
#import "GCLUserLocationAnnotationView.h"
#import "GCLUserLocationHeadingIndicator.h"

@interface GCLUserLocationHeadingBeamLayer : CALayer <GCLUserLocationHeadingIndicator>

- (GCLUserLocationHeadingBeamLayer *)initWithUserLocationAnnotationView:(GCLUserLocationAnnotationView *)userLocationView;
- (void)updateHeadingAccuracy:(CLLocationDirection)accuracy;
- (void)updateTintColor:(CGColorRef)color;

@end
