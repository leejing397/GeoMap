#import <Foundation/Foundation.h>

#import "GCLTypes.h"

NS_ASSUME_NONNULL_BEGIN

// Event types
extern NSString *const GCLEventTypeAppUserTurnstile;
extern NSString *const GCLEventTypeMapLoad;
extern NSString *const GCLEventTypeMapTap;
extern NSString *const GCLEventTypeMapDragEnd;
extern NSString *const GCLEventTypeLocation;

// Event keys
extern NSString *const GCLEventKeyLatitude;
extern NSString *const GCLEventKeyLongitude;
extern NSString *const GCLEventKeyZoomLevel;
extern NSString *const GCLEventKeyGestureID;

// Gestures
extern NSString *const GCLEventGestureSingleTap;
extern NSString *const GCLEventGestureDoubleTap;
extern NSString *const GCLEventGestureTwoFingerSingleTap;
extern NSString *const GCLEventGestureQuickZoom;
extern NSString *const GCLEventGesturePanStart;
extern NSString *const GCLEventGesturePinchStart;
extern NSString *const GCLEventGestureRotateStart;
extern NSString *const GCLEventGesturePitchStart;

typedef NS_DICTIONARY_OF(NSString *, id) GCLMapboxEventAttributes;
typedef NS_MUTABLE_DICTIONARY_OF(NSString *, id) GCLMutableMapboxEventAttributes;

@interface GCLMapboxEvents : NSObject

+ (nullable instancetype)sharedManager;

// You must call these methods from the main thread.
//
+ (void)pushEvent:(NSString *)event withAttributes:(GCLMapboxEventAttributes *)attributeDictionary;
+ (void)ensureMetricsOptoutExists;
+ (void)flush;

@end

NS_ASSUME_NONNULL_END
