#import "GCLTilePyramidOfflineRegion.h"

#if !TARGET_OS_IPHONE && !TARGET_OS_SIMULATOR
    #import <Cocoa/Cocoa.h>
#endif

#import "GCLOfflineRegion_Private.h"
#import "GCLGeometry_Private.h"
#import "GCLStyle.h"

@interface GCLTilePyramidOfflineRegion () <GCLOfflineRegion_Private>

@end

@implementation GCLTilePyramidOfflineRegion {
    NSURL *_styleURL;
}

@synthesize styleURL = _styleURL;

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)init {
    [NSException raise:@"Method unavailable"
                format:
     @"-[GCLTilePyramidOfflineRegion init] is unavailable. "
     @"Use -initWithStyleURL:bounds:fromZoomLevel:toZoomLevel: instead."];
    return nil;
}

- (instancetype)initWithStyleURL:(NSURL *)styleURL bounds:(GCLCoordinateBounds)bounds fromZoomLevel:(double)minimumZoomLevel toZoomLevel:(double)maximumZoomLevel {
    if (self = [super init]) {
        if (!styleURL) {
            styleURL = [GCLStyle streetsStyleURLWithVersion:GCLStyleDefaultVersion];
        }

        if (!styleURL.scheme) {
            [NSException raise:@"Invalid style URL" format:
             @"%@ does not support setting a relative file URL as the style URL. "
             @"To download the online resources required by this style, "
             @"specify a URL to an online copy of this style. "
             @"For Mapbox-hosted styles, use the mapbox: scheme.",
             NSStringFromClass([self class])];
        }

        _styleURL = styleURL;
        _bounds = bounds;
        _minimumZoomLevel = minimumZoomLevel;
        _maximumZoomLevel = maximumZoomLevel;
    }
    return self;
}

- (instancetype)initWithOfflineRegionDefinition:(const mbgl::OfflineRegionDefinition &)definition {
    NSURL *styleURL = [NSURL URLWithString:@(definition.styleURL.c_str())];
    GCLCoordinateBounds bounds = GCLCoordinateBoundsFromLatLngBounds(definition.bounds);
    return [self initWithStyleURL:styleURL bounds:bounds fromZoomLevel:definition.minZoom toZoomLevel:definition.maxZoom];
}

- (const mbgl::OfflineRegionDefinition)offlineRegionDefinition {
#if TARGET_OS_IPHONE || TARGET_OS_SIMULATOR
    const float scaleFactor = [UIScreen instancesRespondToSelector:@selector(nativeScale)] ? [[UIScreen mainScreen] nativeScale] : [[UIScreen mainScreen] scale];
#elif TARGET_OS_MAC
    const float scaleFactor = [NSScreen mainScreen].backingScaleFactor;
#endif
    return mbgl::OfflineTilePyramidRegionDefinition(_styleURL.absoluteString.UTF8String,
                                                    GCLLatLngBoundsFromCoordinateBounds(_bounds),
                                                    _minimumZoomLevel, _maximumZoomLevel,
                                                    scaleFactor);
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    NSURL *styleURL = [coder decodeObjectForKey:@"styleURL"];
    CLLocationCoordinate2D sw = CLLocationCoordinate2DMake([coder decodeDoubleForKey:@"southWestLatitude"],
                                                           [coder decodeDoubleForKey:@"southWestLongitude"]);
    CLLocationCoordinate2D ne = CLLocationCoordinate2DMake([coder decodeDoubleForKey:@"northEastLatitude"],
                                                           [coder decodeDoubleForKey:@"northEastLongitude"]);
    GCLCoordinateBounds bounds = GCLCoordinateBoundsMake(sw, ne);
    double minimumZoomLevel = [coder decodeDoubleForKey:@"minimumZoomLevel"];
    double maximumZoomLevel = [coder decodeDoubleForKey:@"maximumZoomLevel"];

    return [self initWithStyleURL:styleURL bounds:bounds fromZoomLevel:minimumZoomLevel toZoomLevel:maximumZoomLevel];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_styleURL forKey:@"styleURL"];
    [coder encodeDouble:_bounds.sw.latitude forKey:@"southWestLatitude"];
    [coder encodeDouble:_bounds.sw.longitude forKey:@"southWestLongitude"];
    [coder encodeDouble:_bounds.ne.latitude forKey:@"northEastLatitude"];
    [coder encodeDouble:_bounds.ne.longitude forKey:@"northEastLongitude"];
    [coder encodeDouble:_maximumZoomLevel forKey:@"maximumZoomLevel"];
    [coder encodeDouble:_minimumZoomLevel forKey:@"minimumZoomLevel"];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[[self class] allocWithZone:zone] initWithStyleURL:_styleURL bounds:_bounds fromZoomLevel:_minimumZoomLevel toZoomLevel:_maximumZoomLevel];
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
    if (![other isKindOfClass:[self class]]) {
        return NO;
    }

    GCLTilePyramidOfflineRegion *otherRegion = other;
    return (_minimumZoomLevel == otherRegion->_minimumZoomLevel
            && _maximumZoomLevel == otherRegion->_maximumZoomLevel
            && GCLCoordinateBoundsEqualToCoordinateBounds(_bounds, otherRegion->_bounds)
            && [_styleURL isEqual:otherRegion->_styleURL]);
}

- (NSUInteger)hash {
    return (_styleURL.hash
            + @(_bounds.sw.latitude).hash + @(_bounds.sw.longitude).hash
            + @(_bounds.ne.latitude).hash + @(_bounds.ne.longitude).hash
            + @(_minimumZoomLevel).hash + @(_maximumZoomLevel).hash);
}

@end
