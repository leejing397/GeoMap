#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (GCLAdditions)

/**
 Returns the given URL, modified if necessary to use the asset: URL scheme
 expected by mbgl for local requests.
 */
- (nullable NSURL *)gcl_URLByStandardizingScheme;

@end

NS_ASSUME_NONNULL_END
