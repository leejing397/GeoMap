#import "GCLOfflinePack.h"

#include <mbgl/storage/default_file_source.hpp>

NS_ASSUME_NONNULL_BEGIN

@interface GCLOfflinePack (Private)

@property (nonatomic, nullable) mbgl::OfflineRegion *mbglOfflineRegion;

@property (nonatomic, readwrite) GCLOfflinePackState state;

- (instancetype)initWithMBGLRegion:(mbgl::OfflineRegion *)region;

/**
 Invalidates the pack and ensures that no future progress update can ever
 revalidate it. This method must be called before the pack is deallocated.
 */
- (void)invalidate;

@end

NS_ASSUME_NONNULL_END
