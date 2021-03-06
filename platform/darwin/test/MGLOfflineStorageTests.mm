#import <GeoMap/Geocompass.h>

#import "MGLOfflineStorage_Private.h"

#import <XCTest/XCTest.h>

#include <mbgl/util/run_loop.hpp>

@interface MGLOfflineStorageTests : XCTestCase <GCLOfflineStorageDelegate>

@end

@implementation MGLOfflineStorageTests

- (void)setUp {
    [super setUp];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        XCTestExpectation *expectation = [self keyValueObservingExpectationForObject:[GCLOfflineStorage sharedOfflineStorage] keyPath:@"packs" handler:^BOOL(id _Nonnull observedObject, NSDictionary * _Nonnull change) {
            const auto changeKind = static_cast<NSKeyValueChange>([change[NSKeyValueChangeKindKey] unsignedLongValue]);
            return changeKind == NSKeyValueChangeSetting;
        }];
        if ([GCLOfflineStorage sharedOfflineStorage].packs) {
            [expectation fulfill];
            [self waitForExpectationsWithTimeout:0 handler:nil];
        } else {
            [self waitForExpectationsWithTimeout:2 handler:nil];
        }

        XCTAssertNotNil([GCLOfflineStorage sharedOfflineStorage].packs, @"Shared offline storage object should have a non-nil collection of packs by this point.");
    });
}

- (void)testSharedObject {
    XCTAssertEqual([GCLOfflineStorage sharedOfflineStorage], [GCLOfflineStorage sharedOfflineStorage], @"There should only be one shared offline storage object.");
}

- (void)testAddPack {
    NSUInteger countOfPacks = [GCLOfflineStorage sharedOfflineStorage].packs.count;

    NSURL *styleURL = [GCLStyle lightStyleURLWithVersion:8];
    /// Somewhere near Grape Grove, Ohio, United States.
    GCLCoordinateBounds bounds = {
        { .latitude = 39.70358155855172, .longitude = -83.69506472545841 },
        { .latitude = 39.703818870225376, .longitude = -83.69420641857361 },
    };
    double zoomLevel = 20;
    MGLTilePyramidOfflineRegion *region = [[MGLTilePyramidOfflineRegion alloc] initWithStyleURL:styleURL bounds:bounds fromZoomLevel:zoomLevel toZoomLevel:zoomLevel];

    NSString *nameKey = @"Name";
    NSString *name = @"🍇 Grape Grove";

    NSData *context = [NSKeyedArchiver archivedDataWithRootObject:@{
        nameKey: name,
    }];

    __block GCLOfflinePack *pack;
    [self keyValueObservingExpectationForObject:[GCLOfflineStorage sharedOfflineStorage] keyPath:@"packs" handler:^BOOL(id _Nonnull observedObject, NSDictionary * _Nonnull change) {
        const auto changeKind = static_cast<NSKeyValueChange>([change[NSKeyValueChangeKindKey] unsignedLongValue]);
        NSIndexSet *indices = change[NSKeyValueChangeIndexesKey];
        return changeKind == NSKeyValueChangeInsertion && indices.count == 1;
    }];
    XCTestExpectation *additionCompletionHandlerExpectation = [self expectationWithDescription:@"add pack completion handler"];
    [[MGLOfflineStorage sharedOfflineStorage] addPackForRegion:region withContext:context completionHandler:^(GCLOfflinePack * _Nullable completionHandlerPack, NSError * _Nullable error) {
        XCTAssertNotNil(completionHandlerPack, @"Added pack should exist.");
        XCTAssertEqual(completionHandlerPack.state, MGLOfflinePackStateInactive, @"New pack should initially have inactive state.");
        pack = completionHandlerPack;
        [additionCompletionHandlerExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:2 handler:nil];

    XCTAssertEqual([GCLOfflineStorage sharedOfflineStorage].packs.count, countOfPacks + 1, @"Added pack should have been added to the canonical collection of packs owned by the shared offline storage object. This assertion can fail if this test is run before -testAAALoadPacks.");

    XCTAssertEqual(pack, [GCLOfflineStorage sharedOfflineStorage].packs.lastObject, @"Pack should be appended to end of packs array.");

    XCTAssertEqualObjects(pack.region, region, @"Added pack’s region has changed.");

    NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:pack.context];
    XCTAssert([userInfo isKindOfClass:[NSDictionary class]], @"Context of offline pack isn’t a dictionary.");
    XCTAssert([userInfo[nameKey] isKindOfClass:[NSString class]], @"Name of offline pack isn’t a string.");
    XCTAssertEqualObjects(userInfo[nameKey], name, @"Name of offline pack has changed.");

    XCTAssertEqual(pack.state, GCLOfflinePackStateInactive, @"New pack should initially have inactive state.");

    [self keyValueObservingExpectationForObject:pack keyPath:@"state" handler:^BOOL(id _Nonnull observedObject, NSDictionary * _Nonnull change) {
        const auto changeKind = static_cast<NSKeyValueChange>([change[NSKeyValueChangeKindKey] unsignedLongValue]);
        const auto state = static_cast<GCLOfflinePackState>([change[NSKeyValueChangeNewKey] longValue]);
        return changeKind == NSKeyValueChangeSetting && state == GCLOfflinePackStateInactive;
    }];
    [self expectationForNotification:GCLOfflinePackProgressChangedNotification object:pack handler:^BOOL(NSNotification * _Nonnull notification) {
        GCLOfflinePack *notificationPack = notification.object;
        XCTAssert([notificationPack isKindOfClass:[GCLOfflinePack class]], @"Object of notification should be an GCLOfflinePack.");

        NSDictionary *userInfo = notification.userInfo;
        XCTAssertNotNil(userInfo, @"Progress change notification should have a userInfo dictionary.");

        NSNumber *stateNumber = userInfo[GCLOfflinePackUserInfoKeyState];
        XCTAssert([stateNumber isKindOfClass:[NSNumber class]], @"Progress change notification’s state should be an NSNumber.");
        XCTAssertEqual(stateNumber.integerValue, pack.state, @"State in a progress change notification should match the pack’s state.");

        NSValue *progressValue = userInfo[GCLOfflinePackUserInfoKeyProgress];
        XCTAssert([progressValue isKindOfClass:[NSValue class]], @"Progress change notification’s progress should be an NSValue.");
        XCTAssertEqualObjects(progressValue, [NSValue valueWithGCLOfflinePackProgress:pack.progress], @"Progress change notification’s progress should match pack’s progress.");

        return notificationPack == pack && pack.state == GCLOfflinePackStateInactive;
    }];
    [pack requestProgress];
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testBackupExclusion {
    NSURL *cacheDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory
                                                                      inDomain:NSUserDomainMask
                                                             appropriateForURL:nil
                                                                        create:NO
                                                                         error:nil];
    // Unit tests don't use the main bundle; use com.mapbox.ios.sdk instead.
    NSString *bundleIdentifier = [NSBundle bundleForClass:[MGLMapView class]].bundleIdentifier;
    cacheDirectoryURL = [cacheDirectoryURL URLByAppendingPathComponent:bundleIdentifier];
    cacheDirectoryURL = [cacheDirectoryURL URLByAppendingPathComponent:@".mapbox"];
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:cacheDirectoryURL.path], @"Cache subdirectory should exist.");

    NSURL *cacheURL = [cacheDirectoryURL URLByAppendingPathComponent:@"cache.db"];
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:cacheURL.path], @"Cache database should exist.");

    NSError *error = nil;
    NSNumber *exclusionFlag = nil;
    [cacheDirectoryURL getResourceValue:&exclusionFlag
                                 forKey:NSURLIsExcludedFromBackupKey
                                  error:&error];
    XCTAssertTrue(exclusionFlag && [exclusionFlag boolValue], @"Backup exclusion flag should be set for the directory containing the cache database.");
    XCTAssertNil(error, @"No errors should be returned when checking backup exclusion flag.");
}

- (void)testRemovePack {
    NSUInteger countOfPacks = [GCLOfflineStorage sharedOfflineStorage].packs.count;

    GCLOfflinePack *pack = [GCLOfflineStorage sharedOfflineStorage].packs.lastObject;
    XCTAssertNotNil(pack, @"Added pack should still exist.");

    [self keyValueObservingExpectationForObject:[GCLOfflineStorage sharedOfflineStorage] keyPath:@"packs" handler:^BOOL(id _Nonnull observedObject, NSDictionary * _Nonnull change) {
        const auto changeKind = static_cast<NSKeyValueChange>([change[NSKeyValueChangeKindKey] unsignedLongValue]);
        NSIndexSet *indices = change[NSKeyValueChangeIndexesKey];
        return changeKind == NSKeyValueChangeRemoval && indices.count == 1;
    }];
    XCTestExpectation *completionHandlerExpectation = [self expectationWithDescription:@"remove pack completion handler"];
    [[GCLOfflineStorage sharedOfflineStorage] removePack:pack withCompletionHandler:^(NSError * _Nullable error) {
        XCTAssertEqual(pack.state, GCLOfflinePackStateInvalid, @"Removed pack should be invalid in the completion handler.");
        [completionHandlerExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1 handler:nil];

    XCTAssertEqual(pack.state, GCLOfflinePackStateInvalid, @"Removed pack should have been invalidated synchronously.");

    XCTAssertEqual([GCLOfflineStorage sharedOfflineStorage].packs.count, countOfPacks - 1, @"Removed pack should have been removed from the canonical collection of packs owned by the shared offline storage object. This assertion can fail if this test is run before -testAAALoadPacks or -testAddPack.");
}

- (void)testCountOfBytesCompleted {
    XCTAssertGreaterThan([GCLOfflineStorage sharedOfflineStorage].countOfBytesCompleted, 0);
}

- (NSURL *)offlineStorage:(GCLOfflineStorage *)storage
     URLForResourceOfKind:(GCLResourceKind)kind
                  withURL:(NSURL *)url {
    if ([url.scheme isEqual: @"test"] && [url.host isEqual: @"api"]) {
        return [NSURL URLWithString:@"https://api.mapbox.com"];
    } else {
        return url;
    }
}

- (void)testResourceTransform {
    GCLOfflineStorage *os = [GCLOfflineStorage sharedOfflineStorage];
    [os setDelegate:self];

    auto fs = os.mbglFileSource;

    // Delegate returns "https://api.mapbox.com" as a replacement URL.
    const mbgl::Resource resource { mbgl::Resource::Unknown, "test://api" };
    std::unique_ptr<mbgl::AsyncRequest> req;
    req = fs->request(resource, [&](mbgl::Response res) {
        req.reset();
        XCTAssertFalse(res.error.get(), @"Request should not return an error");
        XCTAssertTrue(res.data.get(), @"Request should return data");
        XCTAssertEqual("{\"api\":\"mapbox\"}", *res.data, @"Request did not return expected data");
        CFRunLoopStop(CFRunLoopGetCurrent());
    });

    CFRunLoopRun();

    [os setDelegate:nil];
}

@end
