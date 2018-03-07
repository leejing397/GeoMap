#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An object conforming to the `GCLOfflineRegion` protocol determines which
 resources are required by an `GCLOfflinePack` object. At present, only
 instances of `GCLTilePyramidOfflineRegion` may be used as `GCLOfflinePack`
 regions, but additional conforming implementations may be added in the future.
 */
@protocol GCLOfflineRegion <NSObject>

@end

NS_ASSUME_NONNULL_END
