#import <Foundation/Foundation.h>

#import "NSExpression+GCLAdditions.h"
#include <mbgl/style/filter.hpp>

@interface NSPredicate (GCLAdditions)

- (mbgl::style::Filter)gcl_filter;

+ (instancetype)mgl_predicateWithFilter:(mbgl::style::Filter)filter;

@end

