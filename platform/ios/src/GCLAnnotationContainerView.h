#import <UIKit/UIKit.h>

#import "GCLTypes.h"

@class GCLAnnotationView;

NS_ASSUME_NONNULL_BEGIN

@interface GCLAnnotationContainerView : UIView

+ (instancetype)annotationContainerViewWithAnnotationContainerView:(GCLAnnotationContainerView *)annotationContainerView;

- (void)addSubviews:(NS_ARRAY_OF(GCLAnnotationView *) *)subviews;

@end

NS_ASSUME_NONNULL_END
