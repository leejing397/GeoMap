#import <Foundation/Foundation.h>

#import "GCLMapboxEvents.h"
#import "GCLTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCLAPIClient : NSObject <NSURLSessionDelegate>

- (void)postEvents:(NS_ARRAY_OF(GCLMapboxEventAttributes *) *)events completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;
- (void)postEvent:(GCLMapboxEventAttributes *)event completionHandler:(nullable void (^)(NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
