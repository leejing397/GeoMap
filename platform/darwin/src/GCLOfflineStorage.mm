#import "GCLOfflineStorage_Private.h"

#import "GCLFoundation_Private.h"
#import "GCLAccountManager_Private.h"
#import "GCLGeometry_Private.h"
#import "GCLNetworkConfiguration.h"
#import "GCLOfflinePack_Private.h"
#import "GCLOfflineRegion_Private.h"
#import "GCLTilePyramidOfflineRegion.h"
#import "NSBundle+GCLAdditions.h"
#import "NSValue+GCLAdditions.h"

#include <mbgl/actor/actor.hpp>
#include <mbgl/actor/scheduler.hpp>
#include <mbgl/storage/resource_transform.hpp>
#include <mbgl/util/run_loop.hpp>
#include <mbgl/util/string.hpp>

#include <memory>

static NSString * const GCLOfflineStorageFileName = @"cache.db";
static NSString * const GCLOfflineStorageFileName3_2_0_beta_1 = @"offline.db";

const NSNotificationName GCLOfflinePackProgressChangedNotification = @"GCLOfflinePackProgressChanged";
const NSNotificationName GCLOfflinePackErrorNotification = @"GCLOfflinePackError";
const NSNotificationName GCLOfflinePackMaximumMapboxTilesReachedNotification = @"GCLOfflinePackMaximumMapboxTilesReached";

const GCLOfflinePackUserInfoKey GCLOfflinePackUserInfoKeyState = @"State";
NSString * const GCLOfflinePackStateUserInfoKey = GCLOfflinePackUserInfoKeyState;
const GCLOfflinePackUserInfoKey GCLOfflinePackUserInfoKeyProgress = @"Progress";
NSString * const GCLOfflinePackProgressUserInfoKey = GCLOfflinePackUserInfoKeyProgress;
const GCLOfflinePackUserInfoKey GCLOfflinePackUserInfoKeyError = @"Error";
NSString * const GCLOfflinePackErrorUserInfoKey = GCLOfflinePackUserInfoKeyError;
const GCLOfflinePackUserInfoKey GCLOfflinePackUserInfoKeyMaximumCount = @"MaximumCount";
NSString * const GCLOfflinePackMaximumCountUserInfoKey = GCLOfflinePackUserInfoKeyMaximumCount;

@interface GCLOfflineStorage ()

@property (nonatomic, strong, readwrite) NS_MUTABLE_ARRAY_OF(GCLOfflinePack *) *packs;
@property (nonatomic) mbgl::DefaultFileSource *mbglFileSource;
@property (nonatomic, getter=isPaused) BOOL paused;

@end

@implementation GCLOfflineStorage {
    std::unique_ptr<mbgl::Actor<mbgl::ResourceTransform>> _mbglResourceTransform;
}

+ (instancetype)sharedOfflineStorage {
    static dispatch_once_t onceToken;
    static GCLOfflineStorage *sharedOfflineStorage;
    dispatch_once(&onceToken, ^{
        sharedOfflineStorage = [[self alloc] init];
#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
        [[NSNotificationCenter defaultCenter] addObserver:sharedOfflineStorage selector:@selector(unpauseFileSource:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:sharedOfflineStorage selector:@selector(pauseFileSource:) name:UIApplicationDidEnterBackgroundNotification object:nil];
#endif
        [sharedOfflineStorage reloadPacks];
    });

    return sharedOfflineStorage;
}

#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
- (void)pauseFileSource:(__unused NSNotification *)notification {
    if (self.isPaused) {
        return;
    }
    _mbglFileSource->pause();
    self.paused = YES;
}

- (void)unpauseFileSource:(__unused NSNotification *)notification {
    if (!self.isPaused) {
        return;
    }
    _mbglFileSource->resume();
    self.paused = NO;
}
#endif

- (void)setDelegate:(id<GCLOfflineStorageDelegate>)newValue {
    _delegate = newValue;
    if ([self.delegate respondsToSelector:@selector(offlineStorage:URLForResourceOfKind:withURL:)]) {
        _mbglResourceTransform = std::make_unique<mbgl::Actor<mbgl::ResourceTransform>>(*mbgl::Scheduler::GetCurrent(), [offlineStorage = self](auto kind_, const std::string&& url_) -> std::string {
            NSURL* url =
            [NSURL URLWithString:[[NSString alloc] initWithBytes:url_.data()
                                                          length:url_.length()
                                                        encoding:NSUTF8StringEncoding]];
            GCLResourceKind kind = GCLResourceKindUnknown;
            switch (kind_) {
                case mbgl::Resource::Kind::Tile:
                    kind = GCLResourceKindTile;
                    break;
                case mbgl::Resource::Kind::Glyphs:
                    kind = GCLResourceKindGlyphs;
                    break;
                case mbgl::Resource::Kind::Style:
                    kind = GCLResourceKindStyle;
                    break;
                case mbgl::Resource::Kind::Source:
                    kind = GCLResourceKindSource;
                    break;
                case mbgl::Resource::Kind::SpriteImage:
                    kind = GCLResourceKindSpriteImage;
                    break;
                case mbgl::Resource::Kind::SpriteJSON:
                    kind = GCLResourceKindSpriteJSON;
                    break;
                case mbgl::Resource::Kind::Image:
                    kind = GCLResourceKindImage;
                    break;
                case mbgl::Resource::Kind::Unknown:
                    kind = GCLResourceKindUnknown;
                    break;

            }
            url = [offlineStorage.delegate offlineStorage:offlineStorage
                                     URLForResourceOfKind:kind
                                                  withURL:url];
            return url.absoluteString.UTF8String;
        });

        _mbglFileSource->setResourceTransform(_mbglResourceTransform->self());
    } else {
        _mbglResourceTransform.reset();
        _mbglFileSource->setResourceTransform({});
    }
}

/**
 Returns the file URL to the offline cache, with the option to omit the private
 subdirectory for legacy (v3.2.0 - v3.2.3) migration purposes.

 The cache is located in a directory specific to the application, so that packs
 downloaded by other applications don’t count toward this application’s limits.

 The cache is located at:
 ~/Library/Application Support/tld.app.bundle.id/.mapbox/cache.db

 The subdirectory-less cache was located at:
 ~/Library/Application Support/tld.app.bundle.id/cache.db
 */
+ (NSURL *)cacheURLIncludingSubdirectory:(BOOL)useSubdirectory {
    NSURL *cacheDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory
                                                                      inDomain:NSUserDomainMask
                                                             appropriateForURL:nil
                                                                        create:YES
                                                                         error:nil];
    NSString *bundleIdentifier = [NSBundle gcl_applicationBundleIdentifier];
    if (!bundleIdentifier) {
        // There’s no main bundle identifier when running in a unit test bundle.
        bundleIdentifier = [NSBundle bundleForClass:self].bundleIdentifier;
    }
    cacheDirectoryURL = [cacheDirectoryURL URLByAppendingPathComponent:bundleIdentifier];
    if (useSubdirectory) {
        cacheDirectoryURL = [cacheDirectoryURL URLByAppendingPathComponent:@".mapbox"];
    }
    [[NSFileManager defaultManager] createDirectoryAtURL:cacheDirectoryURL
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:nil];
    if (useSubdirectory) {
        // Avoid backing up the offline cache onto iCloud, because it can be
        // redownloaded. Ideally, we’d even put the ambient cache in Caches, so
        // it can be reclaimed by the system when disk space runs low. But
        // unfortunately it has to live in the same file as offline resources.
        [cacheDirectoryURL setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:NULL];
    }
    return [cacheDirectoryURL URLByAppendingPathComponent:GCLOfflineStorageFileName];
}

/**
 Returns the absolute path to the location where v3.2.0-beta.1 placed the
 offline cache.
 */
+ (NSString *)legacyCachePath {
#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
    // ~/Documents/offline.db
    NSArray *legacyPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *legacyCachePath = [legacyPaths.firstObject stringByAppendingPathComponent:GCLOfflineStorageFileName3_2_0_beta_1];
#elif TARGET_OS_MAC
    // ~/Library/Caches/tld.app.bundle.id/offline.db
    NSString *bundleIdentifier = [NSBundle mgl_applicationBundleIdentifier];
    NSURL *legacyCacheDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory
                                                                            inDomain:NSUserDomainMask
                                                                   appropriateForURL:nil
                                                                              create:NO
                                                                               error:nil];
    legacyCacheDirectoryURL = [legacyCacheDirectoryURL URLByAppendingPathComponent:bundleIdentifier];
    NSURL *legacyCacheURL = [legacyCacheDirectoryURL URLByAppendingPathComponent:MGLOfflineStorageFileName3_2_0_beta_1];
    NSString *legacyCachePath = legacyCacheURL ? legacyCacheURL.path : @"";
#endif
    return legacyCachePath;
}

- (instancetype)init {
    GCLInitializeRunLoop();

    if (self = [super init]) {
        NSURL *cacheURL = [[self class] cacheURLIncludingSubdirectory:YES];
        NSString *cachePath = cacheURL.path ?: @"";

        // Move the offline cache from v3.2.0-beta.1 to a location that can also
        // be used for ambient caching.
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            NSString *legacyCachePath = [[self class] legacyCachePath];
            [[NSFileManager defaultManager] moveItemAtPath:legacyCachePath toPath:cachePath error:NULL];
        }

        // Move the offline file cache from v3.2.x path to a subdirectory that
        // can be reliably excluded from backups.
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            NSURL *subdirectorylessCacheURL = [[self class] cacheURLIncludingSubdirectory:NO];
            [[NSFileManager defaultManager] moveItemAtPath:subdirectorylessCacheURL.path toPath:cachePath error:NULL];
        }

        _mbglFileSource = new mbgl::DefaultFileSource(cachePath.UTF8String, [NSBundle mainBundle].resourceURL.path.UTF8String);

        // Observe for changes to the API base URL (and find out the current one).
        [[GCLNetworkConfiguration sharedManager] addObserver:self
                                                  forKeyPath:@"apiBaseURL"
                                                     options:(NSKeyValueObservingOptionInitial |
                                                              NSKeyValueObservingOptionNew)
                                                     context:NULL];

        // Observe for changes to the global access token (and find out the current one).
        [[GCLAccountManager sharedManager] addObserver:self
                                            forKeyPath:@"accessToken"
                                               options:(NSKeyValueObservingOptionInitial |
                                                        NSKeyValueObservingOptionNew)
                                               context:NULL];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[GCLNetworkConfiguration sharedManager] removeObserver:self forKeyPath:@"apiBaseURL"];
    [[GCLAccountManager sharedManager] removeObserver:self forKeyPath:@"accessToken"];

    for (GCLOfflinePack *pack in self.packs) {
        [pack invalidate];
    }

    delete _mbglFileSource;
    _mbglFileSource = nullptr;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NS_DICTIONARY_OF(NSString *, id) *)change context:(void *)context {
    // Synchronize the file source’s access token with the global one in GCLAccountManager.
    if ([keyPath isEqualToString:@"accessToken"] && object == [GCLAccountManager sharedManager]) {
        NSString *accessToken = change[NSKeyValueChangeNewKey];
        if (![accessToken isKindOfClass:[NSNull class]]) {
            self.mbglFileSource->setAccessToken(accessToken.UTF8String);
        }
    } else if ([keyPath isEqualToString:@"apiBaseURL"] && object == [GCLNetworkConfiguration sharedManager]) {
        NSURL *apiBaseURL = change[NSKeyValueChangeNewKey];
        if ([apiBaseURL isKindOfClass:[NSNull class]]) {
            self.mbglFileSource->setAPIBaseURL(mbgl::util::API_BASE_URL);
        } else {
            self.mbglFileSource->setAPIBaseURL(apiBaseURL.absoluteString.UTF8String);
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark Pack management methods

- (void)addPackForRegion:(id <GCLOfflineRegion>)region withContext:(NSData *)context completionHandler:(GCLOfflinePackAdditionCompletionHandler)completion {
    __weak GCLOfflineStorage *weakSelf = self;
    [self _addPackForRegion:region withContext:context completionHandler:^(GCLOfflinePack * _Nullable pack, NSError * _Nullable error) {
        pack.state = GCLOfflinePackStateInactive;
        GCLOfflineStorage *strongSelf = weakSelf;
        [[strongSelf mutableArrayValueForKey:@"packs"] addObject:pack];
        if (completion) {
            completion(pack, error);
        }
    }];
}

- (void)_addPackForRegion:(id <GCLOfflineRegion>)region withContext:(NSData *)context completionHandler:(GCLOfflinePackAdditionCompletionHandler)completion {
    if (![region conformsToProtocol:@protocol(GCLOfflineRegion_Private)]) {
        [NSException raise:@"Unsupported region type" format:
         @"Regions of type %@ are unsupported.", NSStringFromClass([region class])];
        return;
    }

    const mbgl::OfflineTilePyramidRegionDefinition regionDefinition = [(id <GCLOfflineRegion_Private>)region offlineRegionDefinition];
    mbgl::OfflineRegionMetadata metadata(context.length);
    [context getBytes:&metadata[0] length:metadata.size()];
    self.mbglFileSource->createOfflineRegion(regionDefinition, metadata, [&, completion](std::exception_ptr exception, mbgl::optional<mbgl::OfflineRegion> mbglOfflineRegion) {
        NSError *error;
        if (exception) {
            NSString *errorDescription = @(mbgl::util::toString(exception).c_str());
            error = [NSError errorWithDomain:GCLErrorDomain code:-1 userInfo:errorDescription ? @{
                NSLocalizedDescriptionKey: errorDescription,
            } : nil];
        }
        if (completion) {
            GCLOfflinePack *pack = mbglOfflineRegion ? [[GCLOfflinePack alloc] initWithMBGLRegion:new mbgl::OfflineRegion(std::move(*mbglOfflineRegion))] : nil;
            dispatch_async(dispatch_get_main_queue(), [&, completion, error, pack](void) {
                completion(pack, error);
            });
        }
    });
}

- (void)removePack:(GCLOfflinePack *)pack withCompletionHandler:(GCLOfflinePackRemovalCompletionHandler)completion {
    [[self mutableArrayValueForKey:@"packs"] removeObject:pack];
    [self _removePack:pack withCompletionHandler:^(NSError * _Nullable error) {
        if (completion) {
            completion(error);
        }
    }];
}

- (void)_removePack:(GCLOfflinePack *)pack withCompletionHandler:(GCLOfflinePackRemovalCompletionHandler)completion {
    mbgl::OfflineRegion *mbglOfflineRegion = pack.mbglOfflineRegion;
    [pack invalidate];
    if (!mbglOfflineRegion) {
        completion(nil);
        return;
    }

    self.mbglFileSource->deleteOfflineRegion(std::move(*mbglOfflineRegion), [&, completion](std::exception_ptr exception) {
        NSError *error;
        if (exception) {
            error = [NSError errorWithDomain:GCLErrorDomain code:-1 userInfo:@{
                NSLocalizedDescriptionKey: @(mbgl::util::toString(exception).c_str()),
            }];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), [&, completion, error](void) {
                completion(error);
            });
        }
    });
}

- (void)reloadPacks {
    [self getPacksWithCompletionHandler:^(NS_ARRAY_OF(GCLOfflinePack *) *packs, __unused NSError * _Nullable error) {
        for (GCLOfflinePack *pack in self.packs) {
            [pack invalidate];
        }
        self.packs = [packs mutableCopy];
    }];
}

- (void)getPacksWithCompletionHandler:(void (^)(NS_ARRAY_OF(GCLOfflinePack *) *packs, NSError * _Nullable error))completion {
    self.mbglFileSource->listOfflineRegions([&, completion](std::exception_ptr exception, mbgl::optional<std::vector<mbgl::OfflineRegion>> regions) {
        NSError *error;
        if (exception) {
            error = [NSError errorWithDomain:GCLErrorDomain code:-1 userInfo:@{
                NSLocalizedDescriptionKey: @(mbgl::util::toString(exception).c_str()),
            }];
        }
        NSMutableArray *packs;
        if (regions) {
            packs = [NSMutableArray arrayWithCapacity:regions->size()];
            for (mbgl::OfflineRegion &region : *regions) {
                GCLOfflinePack *pack = [[GCLOfflinePack alloc] initWithMBGLRegion:new mbgl::OfflineRegion(std::move(region))];
                [packs addObject:pack];
            }
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), [&, completion, error, packs](void) {
                completion(packs, error);
            });
        }
    });
}

- (void)setMaximumAllowedMapboxTiles:(uint64_t)maximumCount {
    _mbglFileSource->setOfflineMapboxTileCountLimit(maximumCount);
}

#pragma mark -

- (unsigned long long)countOfBytesCompleted {
    NSURL *cacheURL = [[self class] cacheURLIncludingSubdirectory:YES];
    NSString *cachePath = cacheURL.path;
    if (!cachePath) {
        return 0;
    }

    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:cachePath error:NULL];
    return attributes.fileSize;
}

@end
