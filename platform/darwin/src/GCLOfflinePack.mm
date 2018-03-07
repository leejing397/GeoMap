#import "GCLOfflinePack_Private.h"

#import "GCLOfflineStorage_Private.h"
#import "GCLOfflineRegion_Private.h"
#import "GCLTilePyramidOfflineRegion.h"

#import "NSValue+GCLAdditions.h"

#include <mbgl/storage/default_file_source.hpp>

/**
 Assert that the current offline pack is valid.

 This macro should be used at the beginning of any public-facing instance method
 of `GCLOfflinePack`. For private methods, an assertion is more appropriate.
 */
#define GCLAssertOfflinePackIsValid() \
    do { \
        if (_state == GCLOfflinePackStateInvalid) { \
            [NSException raise:@"Invalid offline pack" \
                        format: \
             @"-[MGLOfflineStorage removePack:withCompletionHandler:] has been called " \
             @"on this instance of MGLOfflinePack, rendering it invalid. It is an " \
             @"error to send any message to this pack."]; \
        } \
    } while (NO);

class MBGLOfflineRegionObserver : public mbgl::OfflineRegionObserver {
public:
    MBGLOfflineRegionObserver(GCLOfflinePack *pack_) : pack(pack_) {}

    void statusChanged(mbgl::OfflineRegionStatus status) override;
    void responseError(mbgl::Response::Error error) override;
    void mapboxTileCountLimitExceeded(uint64_t limit) override;

private:
    __weak GCLOfflinePack *pack = nullptr;
};

@interface GCLOfflinePack ()

@property (nonatomic, nullable, readwrite) mbgl::OfflineRegion *mbglOfflineRegion;
@property (nonatomic, readwrite) GCLOfflinePackProgress progress;

@end

@implementation GCLOfflinePack {
    BOOL _isSuspending;
}

- (instancetype)init {
    if (self = [super init]) {
        _state = GCLOfflinePackStateInvalid;
        NSLog(@"%s called; did you mean to call +[MGLOfflineStorage addPackForRegion:withContext:completionHandler:] instead?", __PRETTY_FUNCTION__);
    }
    return self;
}

- (instancetype)initWithMBGLRegion:(mbgl::OfflineRegion *)region {
    if (self = [super init]) {
        _mbglOfflineRegion = region;
        _state = GCLOfflinePackStateUnknown;

        mbgl::DefaultFileSource *mbglFileSource = [[GCLOfflineStorage sharedOfflineStorage] mbglFileSource];
        mbglFileSource->setOfflineRegionObserver(*_mbglOfflineRegion, std::make_unique<MBGLOfflineRegionObserver>(self));
    }
    return self;
}

- (void)dealloc {
    NSAssert(_state == GCLOfflinePackStateInvalid, @"MGLOfflinePack was not invalided prior to deallocation.");
}

- (id <GCLOfflineRegion>)region {
    GCLAssertOfflinePackIsValid();

    const mbgl::OfflineRegionDefinition &regionDefinition = _mbglOfflineRegion->getDefinition();
    NSAssert([GCLTilePyramidOfflineRegion conformsToProtocol:@protocol(GCLOfflineRegion_Private)], @"GCLTilePyramidOfflineRegion should conform to MGLOfflineRegion_Private.");
    return [(id <GCLOfflineRegion_Private>)[GCLTilePyramidOfflineRegion alloc] initWithOfflineRegionDefinition:regionDefinition];
}

- (NSData *)context {
    GCLAssertOfflinePackIsValid();

    const mbgl::OfflineRegionMetadata &metadata = _mbglOfflineRegion->getMetadata();
    return [NSData dataWithBytes:&metadata[0] length:metadata.size()];
}

- (void)resume {
    GCLAssertOfflinePackIsValid();

    self.state = GCLOfflinePackStateActive;

    mbgl::DefaultFileSource *mbglFileSource = [[GCLOfflineStorage sharedOfflineStorage] mbglFileSource];
    mbglFileSource->setOfflineRegionDownloadState(*_mbglOfflineRegion, mbgl::OfflineRegionDownloadState::Active);
}

- (void)suspend {
    GCLAssertOfflinePackIsValid();

    if (self.state == GCLOfflinePackStateActive) {
        self.state = GCLOfflinePackStateInactive;
        _isSuspending = YES;
    }

    mbgl::DefaultFileSource *mbglFileSource = [[GCLOfflineStorage sharedOfflineStorage] mbglFileSource];
    mbglFileSource->setOfflineRegionDownloadState(*_mbglOfflineRegion, mbgl::OfflineRegionDownloadState::Inactive);
}

- (void)invalidate {
    NSAssert(_state != GCLOfflinePackStateInvalid, @"Cannot invalidate an already invalid offline pack.");

    self.state = GCLOfflinePackStateInvalid;
    mbgl::DefaultFileSource *mbglFileSource = [[GCLOfflineStorage sharedOfflineStorage] mbglFileSource];
    mbglFileSource->setOfflineRegionObserver(*self.mbglOfflineRegion, nullptr);
    self.mbglOfflineRegion = nil;
}

- (void)setState:(GCLOfflinePackState)state {
    if (!self.mbglOfflineRegion) {
        // A progress update has arrived after the call to
        // -[MGLOfflineStorage removePack:withCompletionHandler:] but before the
        // removal is complete and the completion handler is called.
        NSAssert(_state == GCLOfflinePackStateInvalid, @"A valid GCLOfflinePack has no mbgl::OfflineRegion.");
        return;
    }

    NSAssert(_state != GCLOfflinePackStateInvalid, @"Cannot change the state of an invalid offline pack.");

    if (!_isSuspending || state != GCLOfflinePackStateActive) {
        _isSuspending = NO;
        _state = state;
    }
}

- (void)requestProgress {
    GCLAssertOfflinePackIsValid();

    mbgl::DefaultFileSource *mbglFileSource = [[GCLOfflineStorage sharedOfflineStorage] mbglFileSource];

    __weak GCLOfflinePack *weakSelf = self;
    mbglFileSource->getOfflineRegionStatus(*_mbglOfflineRegion, [&, weakSelf](__unused std::exception_ptr exception, mbgl::optional<mbgl::OfflineRegionStatus> status) {
        if (status) {
            mbgl::OfflineRegionStatus checkedStatus = *status;
            dispatch_async(dispatch_get_main_queue(), ^{
                GCLOfflinePack *strongSelf = weakSelf;
                [strongSelf offlineRegionStatusDidChange:checkedStatus];
            });
        }
    });
}

- (void)offlineRegionStatusDidChange:(mbgl::OfflineRegionStatus)status {
    NSAssert(_state != GCLOfflinePackStateInvalid, @"Cannot change update progress of an invalid offline pack.");

    switch (status.downloadState) {
        case mbgl::OfflineRegionDownloadState::Inactive:
            self.state = status.complete() ? GCLOfflinePackStateComplete : GCLOfflinePackStateInactive;
            break;

        case mbgl::OfflineRegionDownloadState::Active:
            self.state = GCLOfflinePackStateActive;
            break;
    }

    if (_isSuspending) {
        return;
    }

    GCLOfflinePackProgress progress;
    progress.countOfResourcesCompleted = status.completedResourceCount;
    progress.countOfBytesCompleted = status.completedResourceSize;
    progress.countOfTilesCompleted = status.completedTileCount;
    progress.countOfTileBytesCompleted = status.completedTileSize;
    progress.countOfResourcesExpected = status.requiredResourceCount;
    progress.maximumResourcesExpected = status.requiredResourceCountIsPrecise ? status.requiredResourceCount : UINT64_MAX;
    self.progress = progress;

    NSDictionary *userInfo = @{GCLOfflinePackUserInfoKeyState: @(self.state),
                               GCLOfflinePackUserInfoKeyProgress: [NSValue valueWithGCLOfflinePackProgress:progress]};

    NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
    [noteCenter postNotificationName:GCLOfflinePackProgressChangedNotification
                              object:self
                            userInfo:userInfo];
}

- (void)didReceiveError:(NSError *)error {
    NSDictionary *userInfo = @{ GCLOfflinePackUserInfoKeyError: error };
    NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
    [noteCenter postNotificationName:GCLOfflinePackErrorNotification
                              object:self
                            userInfo:userInfo];
}

- (void)didReceiveMaximumAllowedMapboxTiles:(uint64_t)limit {
    NSDictionary *userInfo = @{ GCLOfflinePackUserInfoKeyMaximumCount: @(limit) };
    NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
    [noteCenter postNotificationName:GCLOfflinePackMaximumMapboxTilesReachedNotification
                              object:self
                            userInfo:userInfo];
}

NSError *MGLErrorFromResponseError(mbgl::Response::Error error) {
    NSInteger errorCode = GCLErrorCodeUnknown;
    switch (error.reason) {
        case mbgl::Response::Error::Reason::NotFound:
            errorCode = GCLErrorCodeNotFound;
            break;

        case mbgl::Response::Error::Reason::Server:
            errorCode = GCLErrorCodeBadServerResponse;
            break;

        case mbgl::Response::Error::Reason::Connection:
            errorCode = GCLErrorCodeConnectionFailed;
            break;

        default:
            break;
    }
    return [NSError errorWithDomain:GCLErrorDomain code:errorCode userInfo:@{
        NSLocalizedFailureReasonErrorKey: @(error.message.c_str())
    }];
}

@end

void MBGLOfflineRegionObserver::statusChanged(mbgl::OfflineRegionStatus status) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [pack offlineRegionStatusDidChange:status];
    });
}

void MBGLOfflineRegionObserver::responseError(mbgl::Response::Error error) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [pack didReceiveError:MGLErrorFromResponseError(error)];
    });
}

void MBGLOfflineRegionObserver::mapboxTileCountLimitExceeded(uint64_t limit) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [pack didReceiveMaximumAllowedMapboxTiles:limit];
    });
}
