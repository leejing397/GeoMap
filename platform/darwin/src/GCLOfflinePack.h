#import <Foundation/Foundation.h>

#import "GCLFoundation.h"
#import "GCLOfflineRegion.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The state an offline pack is currently in.
 */
typedef NS_ENUM (NSInteger, GCLOfflinePackState) {
    /**
     It is unknown whether the pack is inactive, active, or complete.

     This is the initial state of a pack. The state of a pack becomes known by
     the time the shared `GCLOfflineStorage` object sends the first
     `GCLOfflinePackProgressChangedNotification` about the pack. For inactive
     packs, you must explicitly request a progress update using the
     `-[GCLOfflinePack requestProgress]` method.

     An invalid pack always has a state of `GCLOfflinePackStateInvalid`, never
     `GCLOfflinePackStateUnknown`.
     */
    GCLOfflinePackStateUnknown = 0,
    /**
     The pack is incomplete and is not currently downloading.

     This is the initial state of a pack that is created using the
     `-[GCLOfflineStorage addPackForRegion:withContext:completionHandler:]`
     method, as well as after the `-[GCLOfflinePack suspend]` method is
     called.
     */
    GCLOfflinePackStateInactive = 1,
    /**
     The pack is incomplete and is currently downloading.

     This is the state of a pack after the `-[GCLOfflinePack resume]` method is
     called.
     */
    GCLOfflinePackStateActive = 2,
    /**
     The pack has downloaded to completion.
     */
    GCLOfflinePackStateComplete = 3,
    /**
     The pack has been removed using the
     `-[GCLOfflineStorage removePack:withCompletionHandler:]` method. Sending
     any message to the pack will raise an exception.
     */
    GCLOfflinePackStateInvalid = 4,
};

/**
 A structure containing information about an offline pack’s current download
 progress.
 */
typedef struct __attribute__((objc_boxable)) GCLOfflinePackProgress {
    /**
     The number of resources, including tiles, that have been completely
     downloaded and are ready to use offline.
     */
    uint64_t countOfResourcesCompleted;
    /**
     The cumulative size of the downloaded resources on disk, including tiles,
     measured in bytes.
     */
    uint64_t countOfBytesCompleted;
    /**
     The number of tiles that have been completely downloaded and are ready
     to use offline.
     */
    uint64_t countOfTilesCompleted;
    /**
     The cumulative size of the downloaded tiles on disk, measured in bytes.
     */
    uint64_t countOfTileBytesCompleted;
    /**
     The minimum number of resources that must be downloaded in order to view
     the pack’s full region without any omissions.

     At the beginning of a download, this count is a lower bound; the number of
     expected resources may increase as the download progresses.
     */
    uint64_t countOfResourcesExpected;
    /**
     The maximum number of resources that must be downloaded in order to view
     the pack’s full region without any omissions.

     At the beginning of a download, when the exact number of required resources
     is unknown, this field is set to `UINT64_MAX`. Thus this count is always an
     upper bound.
     */
    uint64_t maximumResourcesExpected;
} GCLOfflinePackProgress;

/**
 An `GCLOfflinePack` represents a collection of resources necessary for viewing
 a region offline to a local database.

 To create an instance of `GCLOfflinePack`, use the
 `+[GCLOfflineStorage addPackForRegion:withContext:completionHandler:]` method.
 A pack created using `-[GCLOfflinePack init]` is immediately invalid.
 */
GCL_EXPORT
@interface GCLOfflinePack : NSObject

/**
 The region for which the pack manages resources.
 */
@property (nonatomic, readonly) id <GCLOfflineRegion> region;

/**
 Arbitrary data stored alongside the downloaded resources.

 The context typically holds application-specific information for identifying
 the pack, such as a user-selected name.
 */
@property (nonatomic, readonly) NSData *context;

/**
 The pack’s current state.

 The state of an inactive or completed pack is computed lazily and is set to
 `GCLOfflinePackStateUnknown` by default. To request the pack’s status, use the
 `-requestProgress` method. To get notified when the state becomes known and
 when it changes, observe KVO change notifications on this pack’s `state` key
 path. Alternatively, you can add an observer for
 `GCLOfflinePackProgressChangedNotification`s about this pack that come from the
 default notification center.
 */
@property (nonatomic, readonly) GCLOfflinePackState state;

/**
 The pack’s current progress.

 The progress of an inactive or completed pack is computed lazily, and all its
 fields are set to 0 by default. To request the pack’s progress, use the
 `-requestProgress` method. To get notified when the progress becomes
 known and when it changes, observe KVO change notifications on this pack’s
 `state` key path. Alternatively, you can add an observer for
 `GCLOfflinePackProgressChangedNotification`s about this pack that come from the
 default notification center.
 */
@property (nonatomic, readonly) GCLOfflinePackProgress progress;

/**
 Resumes downloading if the pack is inactive.

 When a pack resumes after being suspended, it may begin by iterating over the
 already downloaded resources. As a result, the `progress` structure’s
 `countOfResourcesCompleted` field may revert to 0 before rapidly returning to
 the level of progress at the time the pack was suspended.

 To temporarily suspend downloading, call the `-suspend` method.
 */
- (void)resume;

/**
 Temporarily stops downloading if the pack is active.

 A pack suspends asynchronously, so some network requests may be sent after this
 method is called. Regardless, the `progress` property will not be updated until
 `-resume` is called.

 If the pack previously reached a higher level of progress before being
 suspended, it may wait to suspend until it returns to that level.

 To resume downloading, call the `-resume` method.
 */
- (void)suspend;

/**
 Request an asynchronous update to the pack’s `state` and `progress` properties.

 The state and progress of an inactive or completed pack are computed lazily. If
 you need the state or progress of a pack whose `state` property is currently
 set to `GCLOfflinePackStateUnknown`, observe KVO change notifications on this
 pack’s `state` key path, then call this method. Alternatively, you can add an
 observer for `GCLOfflinePackProgressChangedNotification` about this pack that
 come from the default notification center.
 */
- (void)requestProgress;

@end

NS_ASSUME_NONNULL_END
