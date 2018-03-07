#import "GCLAccountManager_Private.h"
#import "NSBundle+GCLAdditions.h"
#import "NSProcessInfo+GCLAdditions.h"

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
#import "GCLMapboxEvents.h"

#import "FABKitProtocol.h"
#import "Fabric+FABKits.h"

@interface GCLAccountManager () <FABKit>

@property (atomic) NSString *accessToken;

@end
#else
@interface GCLAccountManager ()

@property (atomic) NSString *accessToken;

@end
#endif

@implementation GCLAccountManager

#pragma mark - Internal

+ (void)load {
    // Read the initial configuration from Info.plist.
  //  NSString *accessToken = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"GCLMapboxAccessToken"];
//    if (accessToken.length) {
//        self.accessToken = accessToken;
//    }
    self.accessToken = @"pk.eyJ1IjoiZGFybHVuIiwiYSI6ImNqOGw4bWhsYjBremMyd211amlzcWZ6YjIifQ.LtIYFlm7FPMUKQuHSfdNSw";
    
}

+ (instancetype)sharedManager {
    if (NSProcessInfo.processInfo.gcl_isInterfaceBuilderDesignablesAgent) {
        return nil;
    }
    static dispatch_once_t onceToken;
    static GCLAccountManager *_sharedManager;
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

+ (BOOL)mapboxMetricsEnabledSettingShownInApp {
    NSLog(@"mapboxMetricsEnabledSettingShownInApp is no longer necessary; the Mapbox iOS SDK has changed to always provide a telemetry setting in-app.");
    return YES;
}

+ (void)init{
    [GCLAccountManager setAccessToken:@"pk.eyJ1IjoiZGFybHVuIiwiYSI6ImNqOGw4bWhsYjBremMyd211amlzcWZ6YjIifQ.LtIYFlm7FPMUKQuHSfdNSw"];
}

+ (void)setAccessToken:(NSString *)accessToken {
    accessToken = [accessToken stringByTrimmingCharactersInSet:
                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!accessToken.length) {
        return;
    }

    [GCLAccountManager sharedManager].accessToken = accessToken;

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
    // Update GCLMapboxEvents
    // NOTE: This is (likely) the initial setup of GCLMapboxEvents
    [GCLMapboxEvents sharedManager];
#endif
}

+ (NSString *)accessToken {
    return [GCLAccountManager sharedManager].accessToken;
}

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR

#pragma mark - Fabric

+ (NSString *)bundleIdentifier {
    return [NSBundle gcl_frameworkBundleIdentifier];
}

+ (NSString *)kitDisplayVersion {
    return [NSBundle gcl_frameworkInfoDictionary][@"CFBundleShortVersionString"];
}

+ (void)initializeIfNeeded {
    Class fabric = NSClassFromString(@"Fabric");

    if (fabric) {
        NSDictionary *configuration = [fabric configurationDictionaryForKitClass:[GCLAccountManager class]];
        if (!configuration || !configuration[@"accessToken"]) {
            NSLog(@"Configuration dictionary returned by Fabric was nil or doesn’t have accessToken. Can’t initialize GCLAccountManager.");
            return;
        }
        [self setAccessToken:configuration[@"accessToken"]];
        GCLAccountManager *sharedAccountManager = [self sharedManager];
        NSLog(@"GCLAccountManager was initialized with access token: %@", sharedAccountManager.accessToken);
    } else {
        NSLog(@"GCLAccountManager is used in a project that doesn’t have Fabric.");
    }
}

#endif

@end
