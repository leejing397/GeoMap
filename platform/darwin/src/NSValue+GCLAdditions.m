#import "NSValue+GCLAdditions.h"

@implementation NSValue (GCLAdditions)

#pragma mark Geometry

+ (instancetype)valueWithMGLCoordinate:(CLLocationCoordinate2D)coordinate {
    return [self valueWithBytes:&coordinate objCType:@encode(CLLocationCoordinate2D)];
}

- (CLLocationCoordinate2D)GCLCoordinateValue {
    CLLocationCoordinate2D coordinate;
    [self getValue:&coordinate];
    return coordinate;
}

+ (instancetype)valueWithMGLCoordinateSpan:(GCLCoordinateSpan)span {
    return [self valueWithBytes:&span objCType:@encode(GCLCoordinateSpan)];
}

- (GCLCoordinateSpan)GCLCoordinateSpanValue {
    GCLCoordinateSpan span;
    [self getValue:&span];
    return span;
}

+ (instancetype)valueWithGCLCoordinateBounds:(GCLCoordinateBounds)bounds {
    return [self valueWithBytes:&bounds objCType:@encode(GCLCoordinateBounds)];
}

- (GCLCoordinateBounds)GCLCoordinateBoundsValue {
    GCLCoordinateBounds bounds;
    [self getValue:&bounds];
    return bounds;
}

+ (instancetype)valueWithMGLCoordinateQuad:(GCLCoordinateQuad)quad {
    return [self valueWithBytes:&quad objCType:@encode(GCLCoordinateQuad)];
}

- (GCLCoordinateQuad)GCLCoordinateQuadValue {
    GCLCoordinateQuad quad;
    [self getValue:&quad];
    return quad;
}

#pragma mark Offline maps

+ (NSValue *)valueWithGCLOfflinePackProgress:(GCLOfflinePackProgress)progress {
    return [NSValue value:&progress withObjCType:@encode(GCLOfflinePackProgress)];
}

- (GCLOfflinePackProgress)GCLOfflinePackProgressValue {
    GCLOfflinePackProgress progress;
    [self getValue:&progress];
    return progress;
}

#pragma mark Working with Transition Values

+ (NSValue *)valueWithMGLTransition:(GCLTransition)transition; {
    return [NSValue value:&transition withObjCType:@encode(GCLTransition)];
}

- (GCLTransition)GCLTransitionValue {
    GCLTransition transition;
    [self getValue:&transition];
    return transition;
}

+ (NSValue *)valueWithGCLSphericalPosition:(GCLSphericalPosition)lightPosition
{
    return [NSValue value:&lightPosition withObjCType:@encode(GCLSphericalPosition)];
}

- (GCLSphericalPosition)GCLSphericalPositionValue
{
    GCLSphericalPosition lightPosition;
    [self getValue:&lightPosition];
    return lightPosition;
}

+ (NSValue *)valueWithGCLLightAnchor:(GCLLightAnchor)lightAnchor {
    return [NSValue value:&lightAnchor withObjCType:@encode(GCLLightAnchor)];
}

- (GCLLightAnchor)GCLLightAnchorValue
{
    GCLLightAnchor achorType;
    [self getValue:&achorType];
    return achorType;
}

@end
