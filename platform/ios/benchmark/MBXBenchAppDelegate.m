#import "MBXBenchAppDelegate.h"
#import "MBXBenchViewController.h"
#import <GeoMap/Geocompass.h>

NSString * const MBXMapboxAccessTokenDefaultsKey = @"MBXMapboxAccessToken";

@implementation MBXBenchAppDelegate

- (BOOL)application:(UIApplication*)application
    didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    if (![GCLAccountManager accessToken]) {
        NSString *accessToken = [[NSProcessInfo processInfo] environment][@"MAPBOX_ACCESS_TOKEN"];
        if (accessToken) {
            // Store to preferences so that we can launch the app later on without having to specify
            // token.
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:MBXMapboxAccessTokenDefaultsKey];
        } else {
            // Try to retrieve from preferences, maybe we've stored them there previously and can reuse
            // the token.
            accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:MBXMapboxAccessTokenDefaultsKey];
        }
        [GCLAccountManager setAccessToken:accessToken];
    }

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [MBXBenchViewController new];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
