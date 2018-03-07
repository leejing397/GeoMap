#import <QuartzCore/QuartzCore.h>
#import "MGLUserLocationAnnotationView.h"
#import "MGLUserLocationHeadingIndicator.h"

@interface GCLUserLocationHeadingArrowLayer : CAShapeLayer <MGLUserLocationHeadingIndicator>

- (instancetype)initWithUserLocationAnnotationView:(GCLUserLocationAnnotationView *)userLocationView;
- (void)updateHeadingAccuracy:(CLLocationDirection)accuracy;
- (void)updateTintColor:(CGColorRef)color;

@end
