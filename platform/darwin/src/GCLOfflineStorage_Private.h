#import "GCLOfflineStorage.h"

#import "GCLOfflinePack.h"

#include <mbgl/storage/default_file_source.hpp>

NS_ASSUME_NONNULL_BEGIN

@interface GCLOfflineStorage (Private)

/**
 The shared file source object owned by the shared offline storage object.
 */
@property (nonatomic) mbgl::DefaultFileSource *mbglFileSource;

@end

NS_ASSUME_NONNULL_END
