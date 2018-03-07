#import <UIKit/UIKit.h>

#include <mbgl/util/color.hpp>
#include <mbgl/style/property_value.hpp>

@interface UIColor (GCLAdditions)

- (mbgl::Color)mgl_color;

- (mbgl::style::PropertyValue<mbgl::Color>)mgl_colorPropertyValue;

+ (UIColor *)mgl_colorWithColor:(mbgl::Color)color;

@end
