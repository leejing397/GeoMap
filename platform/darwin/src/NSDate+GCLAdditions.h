#import <Foundation/Foundation.h>

#import "GCLFoundation.h"
#include <mbgl/util/chrono.hpp>

NS_ASSUME_NONNULL_BEGIN


/// Converts from a duration in seconds to a duration object usable in mbgl.
GCL_EXPORT
mbgl::Duration GCLDurationFromTimeInterval(NSTimeInterval duration);

/// Converts from an mbgl duration object to a duration in seconds.
GCL_EXPORT
NSTimeInterval GCLTimeIntervalFromDuration(mbgl::Duration duration);

NS_ASSUME_NONNULL_END
