#import <Foundation/Foundation.h>

#import "GCLOfflineRegion.h"

#include <mbgl/storage/offline.hpp>

NS_ASSUME_NONNULL_BEGIN

@protocol GCLOfflineRegion_Private <GCLOfflineRegion>

/**
 Initializes and returns an offline region backed by the given C++ region
 definition object.

 @param definition A reference to an offline region definition backing the
    offline region.
 */
- (instancetype)initWithOfflineRegionDefinition:(const mbgl::OfflineRegionDefinition &)definition;

/**
 Creates and returns a C++ offline region definition corresponding to the
 receiver.
 */
- (const mbgl::OfflineRegionDefinition)offlineRegionDefinition;

@end

NS_ASSUME_NONNULL_END
