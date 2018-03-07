#import <QuartzCore/QuartzCore.h>
#import "GCLUserLocationAnnotationView.h"
#import "GCLUserLocationHeadingIndicator.h"

@interface GCLUserLocationHeadingArrowLayer : CAShapeLayer <GCLUserLocationHeadingIndicator>

- (instancetype)initWithUserLocationAnnotationView:(GCLUserLocationAnnotationView *)userLocationView;
- (void)updateHeadingAccuracy:(CLLocationDirection)accuracy;
- (void)updateTintColor:(CGColorRef)color;

@end
