#import "GCLMultiPoint.h"

#import "GCLGeometry.h"

#import <mbgl/annotation/annotation.hpp>
#import <mbgl/util/feature.hpp>
#import <vector>

#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class GCLPolygon;
@class GCLPolyline;

@protocol GCLMultiPointDelegate;

@interface GCLMultiPoint (Private)

- (instancetype)initWithCoordinates:(const CLLocationCoordinate2D *)coords count:(NSUInteger)count;
- (BOOL)intersectsOverlayBounds:(GCLCoordinateBounds)overlayBounds;

/** Constructs a shape annotation object, asking the delegate for style values. */
- (mbgl::Annotation)annotationObjectWithDelegate:(id <GCLMultiPointDelegate>)delegate;

@end

/** An object that tells the GCLMultiPoint instance how to style itself. */
@protocol GCLMultiPointDelegate <NSObject>

/** Returns the fill alpha value for the given annotation. */
- (double)alphaForShapeAnnotation:(GCLShape *)annotation;

/** Returns the stroke color object for the given annotation. */
- (mbgl::Color)strokeColorForShapeAnnotation:(GCLShape *)annotation;

/** Returns the fill color object for the given annotation. */
- (mbgl::Color)fillColorForPolygonAnnotation:(GCLPolygon *)annotation;

/** Returns the stroke width object for the given annotation. */
- (CGFloat)lineWidthForPolylineAnnotation:(GCLPolyline *)annotation;

@end

NS_ASSUME_NONNULL_END
