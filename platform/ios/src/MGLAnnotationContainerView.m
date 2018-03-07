#import "GCLAnnotationContainerView.h"
#import "MGLAnnotationView.h"

@interface GCLAnnotationContainerView ()

@property (nonatomic) NS_MUTABLE_ARRAY_OF(MGLAnnotationView *) *annotationViews;

@end

@implementation GCLAnnotationContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _annotationViews = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)annotationContainerViewWithAnnotationContainerView:(nonnull GCLAnnotationContainerView *)annotationContainerView
{
    GCLAnnotationContainerView *newAnnotationContainerView = [[GCLAnnotationContainerView alloc] initWithFrame:annotationContainerView.frame];
    [newAnnotationContainerView addSubviews:annotationContainerView.subviews];
    return newAnnotationContainerView;
}

- (void)addSubviews:(NS_ARRAY_OF(MGLAnnotationView *) *)subviews
{
    for (MGLAnnotationView *view in subviews)
    {
        [self addSubview:view];
        [self.annotationViews addObject:view];
    }
}

#pragma mark UIAccessibility methods

- (UIAccessibilityTraits)accessibilityTraits {
    return UIAccessibilityTraitAdjustable;
}

- (void)accessibilityIncrement {
    [self.superview.superview accessibilityIncrement];
}

- (void)accessibilityDecrement {
    [self.superview.superview accessibilityDecrement];
}

@end
