#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (GCLAdditions)

- (NSData *)gcl_compressedData;

- (NSData *)gcl_decompressedData;

@end

NS_ASSUME_NONNULL_END
