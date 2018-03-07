#import "NSProcessInfo+GCLAdditions.h"

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
    static NSString * const MGLIBDesignablesAgentProcessName = @"IBDesignablesAgentCocoaTouch";
#elif TARGET_OS_MAC
    static NSString * const MGLIBDesignablesAgentProcessName = @"IBDesignablesAgent";
#endif

@implementation NSProcessInfo (GCLAdditions)

- (BOOL)gcl_isInterfaceBuilderDesignablesAgent {
    return [self.processName isEqualToString:MGLIBDesignablesAgentProcessName];
}

@end
