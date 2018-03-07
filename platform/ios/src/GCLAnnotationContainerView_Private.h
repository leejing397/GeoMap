#import "GCLAnnotationContainerView.h"
#import "GCLAnnotationView.h"

@class MGLAnnotationView;

NS_ASSUME_NONNULL_BEGIN

@interface GCLAnnotationContainerView (Private)

@property (nonatomic) NS_MUTABLE_ARRAY_OF(GCLAnnotationView *) *annotationViews;

@end

NS_ASSUME_NONNULL_END
