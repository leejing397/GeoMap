#import <Foundation/Foundation.h>

#import "GCLLight.h"

namespace mbgl {
    namespace style {
        class Light;
    }
}

@interface GCLLight (Private)

/**
 Initializes and returns a `GCLLight` associated with a style's light.
 */
- (instancetype)initWithMBGLLight:(const mbgl::style::Light *)mbglLight;

/**
 Returns an `mbgl::style::Light` representation of the `GCLLight`.
 */
- (mbgl::style::Light)mbglLight;

@end
