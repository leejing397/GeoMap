#import <Foundation/Foundation.h>

@interface NSProcessInfo (GCLAdditions)

/**
 Returns YES if the current process is Interface Builder’s helper process for
 rendering designables.
 */
- (BOOL)gcl_isInterfaceBuilderDesignablesAgent;

@end
