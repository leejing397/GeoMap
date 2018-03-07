#import <Foundation/Foundation.h>

#import "GCLFoundation.h"
#import "GCLStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

@class GCLSource;

/**
 `GCLForegroundStyleLayer` is an abstract superclass for style layers whose
 content is defined by an `GCLSource` object.

 Create instances of `GCLRasterStyleLayer` and the concrete subclasses of
 `GCLVectorStyleLayer` in order to use `GCLForegroundStyleLayer`'s methods.
 Do not create instances of `GCLForegroundStyleLayer` directly, and do not
 create your own subclasses of this class.
 */
GCL_EXPORT
@interface GCLForegroundStyleLayer : GCLStyleLayer

#pragma mark Initializing a Style Layer

- (instancetype)init __attribute__((unavailable("Use -init methods of concrete subclasses instead.")));

#pragma mark Specifying a Style Layer’s Content

/**
 Identifier of the source from which the receiver obtains the data to style.
 */
@property (nonatomic, readonly, nullable) NSString *sourceIdentifier;

@end

NS_ASSUME_NONNULL_END
