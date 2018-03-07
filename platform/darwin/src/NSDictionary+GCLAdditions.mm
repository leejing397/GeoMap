#import "NSDictionary+GCLAdditions.h"

#import "NSExpression+MGLAdditions.mm"
#import "NSArray+GCLAdditions.h"

@implementation NSDictionary (GCLAdditions)

- (mbgl::PropertyMap)gcl_propertyMap {
    mbgl::PropertyMap propertyMap;
    for (NSString *key in self.allKeys) {
        if ([self[key] isKindOfClass:[NSDictionary class]]) {
            propertyMap[[key UTF8String]] = [self[key] gcl_propertyMap];
        } else if ([self[key] isKindOfClass:[NSArray class]]) {
            NSArray *array = self[key];
            propertyMap[[key UTF8String]] = [array gcl_vector];
        } else {
            NSExpression *expression = [NSExpression expressionForConstantValue:self[key]];
            propertyMap[[key UTF8String]] = expression.gcl_constantMBGLValue;
        }
    }
    return propertyMap;
}

@end
