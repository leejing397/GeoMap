#import <Foundation/Foundation.h>

#import "GCLGeometry.h"
#import "GCLLight.h"
#import "GCLOfflinePack.h"
#import "GCLTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Methods for round-tripping values for Mapbox-defined types.
 */
@interface NSValue (GCLAdditions)

#pragma mark Working with Geographic Coordinate Values

/**
 Creates a new value object containing the specified Core Location geographic
 coordinate structure.

 @param coordinate The value for the new object.
 @return A new value object that contains the geographic coordinate information.
 */
+ (instancetype)valueWithMGLCoordinate:(CLLocationCoordinate2D)coordinate;

/**
 The Core Location geographic coordinate structure representation of the value.
 */
@property (readonly) CLLocationCoordinate2D GCLCoordinateValue;

/**
 Creates a new value object containing the specified Mapbox coordinate span
 structure.

 @param span The value for the new object.
 @return A new value object that contains the coordinate span information.
 */
+ (instancetype)valueWithMGLCoordinateSpan:(GCLCoordinateSpan)span;

/**
 The Mapbox coordinate span structure representation of the value.
 */
@property (readonly) GCLCoordinateSpan GCLCoordinateSpanValue;

/**
 Creates a new value object containing the specified Mapbox coordinate bounds
 structure.

 @param bounds The value for the new object.
 @return A new value object that contains the coordinate bounds information.
 */
+ (instancetype)valueWithGCLCoordinateBounds:(GCLCoordinateBounds)bounds;

/**
 The Mapbox coordinate bounds structure representation of the value.
 */
@property (readonly) GCLCoordinateBounds GCLCoordinateBoundsValue;

/**
 Creates a new value object containing the specified Mapbox coordinate 
 quad structure.

 @param quad The value for the new object.
 @return A new value object that contains the coordinate quad information.
 */
+ (instancetype)valueWithMGLCoordinateQuad:(GCLCoordinateQuad)quad;

/**
 The Mapbox coordinate quad structure representation of the value.
 */
- (GCLCoordinateQuad)GCLCoordinateQuadValue;

#pragma mark Working with Offline Map Values

/**
 Creates a new value object containing the given `MGLOfflinePackProgress`
 structure.

 @param progress The value for the new object.
 @return A new value object that contains the offline pack progress information.
 */
+ (NSValue *)valueWithGCLOfflinePackProgress:(GCLOfflinePackProgress)progress;

/**
 The `MGLOfflinePackProgress` structure representation of the value.
 */
@property (readonly) GCLOfflinePackProgress GCLOfflinePackProgressValue;

#pragma mark Working with Transition Values

/**
 Creates a new value object containing the given `MGLTransition`
 structure.
 
 @param transition The value for the new object.
 @return A new value object that contains the transition information.
 */
+ (NSValue *)valueWithMGLTransition:(GCLTransition)transition;

/**
 The `MGLTransition` structure representation of the value.
 */
@property (readonly) GCLTransition GCLTransitionValue;

/**
 Creates a new value object containing the given `MGLSphericalPosition`
 structure.
 
 @param lightPosition The value for the new object.
 @return A new value object that contains the light position information.
 */
+ (instancetype)valueWithGCLSphericalPosition:(GCLSphericalPosition)lightPosition;

/**
 The `MGLSphericalPosition` structure representation of the value.
 */
@property (readonly) GCLSphericalPosition GCLSphericalPositionValue;

/**
 Creates a new value object containing the given `MGLLightAnchor`
 enum.
 
 @param lightAnchor The value for the new object.
 @return A new value object that contains the light anchor information.
 */
+ (NSValue *)valueWithGCLLightAnchor:(GCLLightAnchor)lightAnchor;

/**
 The `MGLLightAnchor` enum representation of the value.
 */
@property (readonly) GCLLightAnchor GCLLightAnchorValue;

@end

NS_ASSUME_NONNULL_END
