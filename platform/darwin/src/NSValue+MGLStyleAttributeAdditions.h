#import <Foundation/Foundation.h>

#include <array>

@interface NSValue (GCLStyleAttributeAdditions)

+ (instancetype)mgl_valueWithOffsetArray:(std::array<float, 2>)offsetArray;
+ (instancetype)mgl_valueWithPaddingArray:(std::array<float, 4>)paddingArray;

- (std::array<float, 2>)gcl_offsetArrayValue;
- (std::array<float, 4>)gcl_paddingArrayValue;
- (std::array<float, 3>)gcl_lightPositionArrayValue;

@end
