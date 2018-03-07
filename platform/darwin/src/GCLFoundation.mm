#import "GCLFoundation_Private.h"

/// Initializes the run loop shim that lives on the main thread.
void GCLInitializeRunLoop() {
    static mbgl::util::RunLoop runLoop;
}
