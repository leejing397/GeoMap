#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "GCLFoundation.h"
#import "GCLStyleValue.h"
#import "GCLStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

@class GCLMapView;
@class GCLStyle;

typedef struct GCLStyleLayerDrawingContext {
    CGSize size;
    CLLocationCoordinate2D centerCoordinate;
    double zoomLevel;
    CLLocationDirection direction;
    CGFloat pitch;
    CGFloat fieldOfView;
} GCLStyleLayerDrawingContext;

GCL_EXPORT
@interface GCLOpenGLStyleLayer : GCLStyleLayer

@property (nonatomic, weak, readonly) GCLStyle *style;

- (instancetype)initWithIdentifier:(NSString *)identifier;

- (void)didMoveToMapView:(GCLMapView *)mapView;

- (void)willMoveFromMapView:(GCLMapView *)mapView;

- (void)drawInMapView:(GCLMapView *)mapView withContext:(GCLStyleLayerDrawingContext)context;

- (void)setNeedsDisplay;

@end

NS_ASSUME_NONNULL_END
