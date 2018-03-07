#import "GCLAnnotationView.h"
#import "GCLAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@class GCLMapView;

@interface GCLAnnotationView (Private)

@property (nonatomic, readwrite, nullable) NSString *reuseIdentifier;
@property (nonatomic, weak) GCLMapView *mapView;

@end

NS_ASSUME_NONNULL_END
