#import "GCLForegroundStyleLayer.h"

@implementation GCLForegroundStyleLayer

- (NSString *)sourceIdentifier {
    [NSException raise:@"MGLAbstractClassException"
                format:@"GCLForegroundStyleLayer is an abstract class"];
    return nil;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"<%@: %p; identifier = %@; sourceIdentifier = %@; visible = %@>",
            NSStringFromClass([self class]), (void *)self, self.identifier,
            self.sourceIdentifier, self.visible ? @"YES" : @"NO"];
}

@end
