#import "GCLCompactCalloutView.h"

#import "GCLAnnotation.h"

@implementation GCLCompactCalloutView
{
    id <GCLAnnotation> _representedObject;
}

@synthesize representedObject = _representedObject;

+ (instancetype)platformCalloutView
{
    return [[self alloc] init];
}

- (BOOL)isAnchoredToAnnotation {
    return YES;
}

- (BOOL)dismissesAutomatically {
    return NO;
}

- (void)setRepresentedObject:(id <GCLAnnotation>)representedObject
{
    _representedObject = representedObject;

    if ([representedObject respondsToSelector:@selector(title)])
    {
        self.title = representedObject.title;
    }
    if ([representedObject respondsToSelector:@selector(subtitle)])
    {
        self.subtitle = representedObject.subtitle;
    }
}

@end
