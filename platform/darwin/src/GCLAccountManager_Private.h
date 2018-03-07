#import "GCLAccountManager.h"

@interface GCLAccountManager (Private)

/// Returns the shared instance of the `GCLAccountManager` class.
+ (instancetype)sharedManager;

/// The current global access token.
@property (atomic) NSString *accessToken;

@end
