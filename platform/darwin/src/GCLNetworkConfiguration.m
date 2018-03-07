#import "GCLNetworkConfiguration.h"

@implementation GCLNetworkConfiguration

+ (void)load {
    // Read the initial configuration from Info.plist.
    NSString *apiBaseURL = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"MGLMapboxAPIBaseURL"];
    if (apiBaseURL.length) {
        [self setAPIBaseURL:[NSURL URLWithString:apiBaseURL]];
    }
}

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static GCLNetworkConfiguration *_sharedManager;
    void (^setupBlock)() = ^{
        dispatch_once(&onceToken, ^{
            _sharedManager = [[self alloc] init];
        });
    };
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            setupBlock();
        });
    } else {
        setupBlock();
    }
    return _sharedManager;
}

+ (void)setAPIBaseURL:(NSURL *)apiBaseURL {
    [GCLNetworkConfiguration sharedManager].apiBaseURL = apiBaseURL;
}

+ (NSURL *)apiBaseURL {
    return [GCLNetworkConfiguration sharedManager].apiBaseURL;
}

@end
