#import "GCLMapCamera.h"
#import "GCLGeometry_Private.h"

#include <mbgl/util/projection.hpp>

BOOL GCLEqualFloatWithAccuracy(CGFloat left, CGFloat right, CGFloat accuracy)
{
    return MAX(left, right) - MIN(left, right) <= accuracy;
}

@implementation GCLMapCamera

+ (BOOL)supportsSecureCoding
{
    return YES;
}

+ (instancetype)camera
{
    return [[self alloc] init];
}

+ (instancetype)cameraLookingAtCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                              fromEyeCoordinate:(CLLocationCoordinate2D)eyeCoordinate
                                    eyeAltitude:(CLLocationDistance)eyeAltitude
{
    CLLocationDirection heading = -1;
    CGFloat pitch = -1;
    if (CLLocationCoordinate2DIsValid(centerCoordinate) && CLLocationCoordinate2DIsValid(eyeCoordinate)) {
        mbgl::LatLng centerLatLng = GCLLatLngFromLocationCoordinate2D(centerCoordinate);
        mbgl::LatLng eyeLatLng = GCLLatLngFromLocationCoordinate2D(eyeCoordinate);
        
        mbgl::ProjectedMeters centerMeters = mbgl::Projection::projectedMetersForLatLng(centerLatLng);
        mbgl::ProjectedMeters eyeMeters = mbgl::Projection::projectedMetersForLatLng(eyeLatLng);
        heading = std::atan((centerMeters.northing() - eyeMeters.northing()) /
                            (centerMeters.easting() - eyeMeters.easting()));
        
        double groundDistance = std::hypot(centerMeters.northing() - eyeMeters.northing(),
                                           centerMeters.easting() - eyeMeters.easting());
        pitch = std::atan(eyeAltitude / groundDistance);
    }

    return [[self alloc] initWithCenterCoordinate:centerCoordinate
                                         altitude:eyeAltitude
                                            pitch:pitch
                                          heading:heading];
}

+ (instancetype)cameraLookingAtCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                   fromDistance:(CLLocationDistance)distance
                                          pitch:(CGFloat)pitch
                                        heading:(CLLocationDirection)heading
{
    return [[self alloc] initWithCenterCoordinate:centerCoordinate
                                         altitude:distance
                                            pitch:pitch
                                          heading:heading];
}

- (instancetype)initWithCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                altitude:(CLLocationDistance)altitude
                                   pitch:(CGFloat)pitch
                                 heading:(CLLocationDirection)heading
{
    if (self = [super init])
    {
        _centerCoordinate = centerCoordinate;
        _altitude = altitude;
        _pitch = pitch;
        _heading = heading;
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        _centerCoordinate = CLLocationCoordinate2DMake([coder decodeDoubleForKey:@"centerLatitude"],
                                                       [coder decodeDoubleForKey:@"centerLongitude"]);
        _altitude = [coder decodeDoubleForKey:@"altitude"];
        _pitch = [coder decodeDoubleForKey:@"pitch"];
        _heading = [coder decodeDoubleForKey:@"heading"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeDouble:_centerCoordinate.latitude forKey:@"centerLatitude"];
    [coder encodeDouble:_centerCoordinate.longitude forKey:@"centerLongitude"];
    [coder encodeDouble:_altitude forKey:@"altitude"];
    [coder encodeDouble:_pitch forKey:@"pitch"];
    [coder encodeDouble:_heading forKey:@"heading"];
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithCenterCoordinate:_centerCoordinate
                                                              altitude:_altitude
                                                                 pitch:_pitch
                                                               heading:_heading];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; centerCoordinate = %f, %f; altitude = %.0fm; heading = %.0f°; pitch = %.0f°>",
            NSStringFromClass([self class]), (void *)self, _centerCoordinate.latitude, _centerCoordinate.longitude, _altitude, _heading, _pitch];
}

- (BOOL)isEqual:(id)other
{
    if ( ! [other isKindOfClass:[self class]])
    {
        return NO;
    }
    if (other == self)
    {
        return YES;
    }

    GCLMapCamera *otherCamera = other;
    return (_centerCoordinate.latitude == otherCamera.centerCoordinate.latitude
            && _centerCoordinate.longitude == otherCamera.centerCoordinate.longitude
            && _altitude == otherCamera.altitude
            && _pitch == otherCamera.pitch && _heading == otherCamera.heading);
}

- (BOOL)isEqualToMapCamera:(GCLMapCamera *)otherCamera
{
    if (otherCamera == self)
    {
        return YES;
    }
    
    return (GCLEqualFloatWithAccuracy(_centerCoordinate.latitude, otherCamera.centerCoordinate.latitude, 1e-6)
            && GCLEqualFloatWithAccuracy(_centerCoordinate.longitude, otherCamera.centerCoordinate.longitude, 1e-6)
            && GCLEqualFloatWithAccuracy(_altitude, otherCamera.altitude, 1e-6)
            && GCLEqualFloatWithAccuracy(_pitch, otherCamera.pitch, 1)
            && GCLEqualFloatWithAccuracy(_heading, otherCamera.heading, 1));
}

- (NSUInteger)hash
{
    return (@(_centerCoordinate.latitude).hash + @(_centerCoordinate.longitude).hash
            + @(_altitude).hash + @(_pitch).hash + @(_heading).hash);
}

@end
