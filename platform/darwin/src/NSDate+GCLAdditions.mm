#import "NSDate+GCLAdditions.h"

mbgl::Duration GCLDurationFromTimeInterval(NSTimeInterval duration)
{
    return std::chrono::duration_cast<mbgl::Duration>(std::chrono::duration<NSTimeInterval>(duration));
}

NSTimeInterval GCLTimeIntervalFromDuration(mbgl::Duration duration)
{
    return std::chrono::duration<NSTimeInterval, std::ratio<1>>(duration).count();
}
