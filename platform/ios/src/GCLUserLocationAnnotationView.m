#import "GCLUserLocationAnnotationView.h"

#import "GCLUserLocation.h"
#import "GCLUserLocation_Private.h"
#import "GCLAnnotationView_Private.h"
#import "GCLAnnotation.h"
#import "GCLMapView.h"
#import "GCLCoordinateFormatter.h"
#import "NSBundle+GCLAdditions.h"

@interface GCLUserLocationAnnotationView()
@property (nonatomic, weak, nullable) GCLMapView *mapView;
@property (nonatomic, weak, nullable) GCLUserLocation *userLocation;
@property (nonatomic, weak) CALayer *hitTestLayer;
@end

@implementation GCLUserLocationAnnotationView {
    GCLCoordinateFormatter *_accessibilityCoordinateFormatter;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) return nil;

    self.accessibilityTraits = UIAccessibilityTraitButton | UIAccessibilityTraitAdjustable | UIAccessibilityTraitUpdatesFrequently;

    _accessibilityCoordinateFormatter = [[GCLCoordinateFormatter alloc] init];
    _accessibilityCoordinateFormatter.unitStyle = NSFormattingUnitStyleLong;

    return self;
}

- (CALayer *)hitTestLayer
{
    return self.layer.presentationLayer;
}

- (void)update
{
    // Left blank intentionally. Subclasses should usually override this in order to update the annotation’s appearance.
}

- (BOOL)isAccessibilityElement
{
    return !self.hidden;
}

- (NSString *)accessibilityLabel
{
    return self.userLocation.title;
}

- (NSString *)accessibilityValue
{
    if (self.userLocation.subtitle)
    {
        return self.userLocation.subtitle;
    }

    // Each arcminute of longitude is at most about 1 nmi, too small for low zoom levels.
    // Each arcsecond of longitude is at most about 30 m, too small for all but the very highest of zoom levels.
    double zoomLevel = self.mapView.zoomLevel;
    _accessibilityCoordinateFormatter.allowsMinutes = zoomLevel > 8;
    _accessibilityCoordinateFormatter.allowsSeconds = zoomLevel > 20;

    return [_accessibilityCoordinateFormatter stringFromCoordinate:self.mapView.centerCoordinate];
}

- (CGRect)accessibilityFrame
{
    return CGRectInset(self.frame, -15, -15);
}

- (UIBezierPath *)accessibilityPath
{
    return [UIBezierPath bezierPathWithOvalInRect:self.frame];
}

- (void)accessibilityIncrement
{
    [self.mapView accessibilityIncrement];
}

- (void)accessibilityDecrement
{
    [self.mapView accessibilityDecrement];
}

- (void)setHidden:(BOOL)hidden
{
    BOOL oldValue = super.hidden;
    [super setHidden:hidden];
    if (oldValue != hidden)
    {
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
    }
}

@end
