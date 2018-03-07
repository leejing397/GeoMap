#import <Foundation/Foundation.h>

#import "GCLFoundation.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `GCLSource` is an abstract base class for map content sources. A map content
 source supplies content to be shown on the map. A source is added to an
 `GCLStyle` object along with an `GCLForegroundStyleLayer` object. The
 foreground style layer defines the appearance of any content supplied by the
 source.

 Each source defined by the style JSON file is represented at runtime by an
 `GCLSource` object that you can use to refine the map’s content. You can also
 add and remove sources dynamically using methods such as
 `-[GCLStyle addSource:]` and `-[GCLStyle sourceWithIdentifier:]`.

 Create instances of `GCLShapeSource`, `GCLImageSource` and the concrete subclasses of
 `GCLTileSource` (`GCLVectorSource` and `GCLRasterSource`) in order to use
 `GCLSource`'s properties and methods. Do not create instances of `GCLSource`
 directly, and do not create your own subclasses of this class.
 */
GCL_EXPORT
@interface GCLSource : NSObject

#pragma mark Initializing a Source

- (instancetype)init __attribute__((unavailable("Use -initWithIdentifier: instead.")));

/**
 Returns a source initialized with an identifier.

 After initializing and configuring the source, add it to a map view’s style
 using the `-[GCLStyle addSource:]` method.

 @param identifier A string that uniquely identifies the source in the style to
    which it is added.
 @return An initialized source.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier;

#pragma mark Identifying a Source

/**
 A string that uniquely identifies the source in the style to which it is added.
 */
@property (nonatomic, copy) NSString *identifier;

@end

NS_ASSUME_NONNULL_END
