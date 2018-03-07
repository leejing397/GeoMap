#import "NSBundle+GCLAdditions.h"

#import "GCLAccountManager.h"

@implementation NSBundle (GCLAdditions)

+ (instancetype)gcl_frameworkBundle {
    NSBundle *bundle = [self bundleForClass:[GCLAccountManager class]];

    if (![bundle.infoDictionary[@"CFBundlePackageType"] isEqualToString:@"FMWK"]) {
        // For static frameworks, the bundle is the containing application
        // bundle but the resources are in Mapbox.bundle.
        NSString *bundlePath = [bundle pathForResource:@"Mapbox" ofType:@"bundle"];
        if (bundlePath) {
            bundle = [self bundleWithPath:bundlePath];
        } else {
            [NSException raise:@"MGLBundleNotFoundException" format:
             @"The Mapbox framework bundle could not be found. If using the Mapbox iOS SDK as a static framework, make sure that Mapbox.bundle is copied into the root of the app bundle."];
        }
    }

    return bundle;
}

+ (nullable NSString *)gcl_frameworkBundleIdentifier {
    return self.gcl_frameworkInfoDictionary[@"CFBundleIdentifier"];
}

+ (nullable NS_DICTIONARY_OF(NSString *, id) *)gcl_frameworkInfoDictionary {
    NSBundle *bundle = self.gcl_frameworkBundle;
    return bundle.infoDictionary;
}

+ (nullable NSString *)gcl_applicationBundleIdentifier {
    NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
    if (!bundleIdentifier) {
        // There’s no main bundle identifier when running in a unit test bundle.
        bundleIdentifier = [NSBundle bundleForClass:[GCLAccountManager class]].bundleIdentifier;
    }
    return bundleIdentifier;
}

@end
