#import <UIKit/UIKit.h>
#import "GCLUserLocationAnnotationView.h"

extern const CGFloat GCLUserLocationAnnotationDotSize;
extern const CGFloat GCLUserLocationAnnotationHaloSize;

extern const CGFloat GCLUserLocationAnnotationPuckSize;
extern const CGFloat GCLUserLocationAnnotationArrowSize;

// Threshold in radians between heading indicator rotation updates.
extern const CGFloat GCLUserLocationHeadingUpdateThreshold;

@interface GCLFaux3DUserLocationAnnotationView : GCLUserLocationAnnotationView

@end
