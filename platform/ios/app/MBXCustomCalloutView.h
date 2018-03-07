#import <UIKit/UIKit.h>
#import <GeoMap/Geocompass.h>

/**
 * Basic custom callout view to demonstrate how to
 * add your own on your app. Will only show the
 * callout title for demonstration purpose.
 */
@interface MBXCustomCalloutView : UIView <GCLCalloutView>

@property (nonatomic, assign, getter=isAnchoredToAnnotation) BOOL anchoredToAnnotation;
@property (nonatomic, assign) BOOL dismissesAutomatically;

@end
