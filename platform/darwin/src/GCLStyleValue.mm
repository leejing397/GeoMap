#import "GCLStyleValue_Private.h"

const GCLStyleFunctionOption GCLStyleFunctionOptionInterpolationBase = @"GCLStyleFunctionOptionInterpolationBase";
const GCLStyleFunctionOption GCLStyleFunctionOptionDefaultValue = @"GCLStyleFunctionOptionDefaultValue";

@implementation GCLStyleValue

+ (instancetype)valueWithRawValue:(id)rawValue {
    return [GCLConstantStyleValue valueWithRawValue:rawValue];
}

+ (instancetype)valueWithInterpolationBase:(CGFloat)interpolationBase stops:(NSDictionary *)stops {
    return [GCLCameraStyleFunction functionWithInterpolationMode:GCLInterpolationModeExponential stops:stops options:@{GCLStyleFunctionOptionInterpolationBase: @(interpolationBase)}];
}

+ (instancetype)valueWithStops:(NSDictionary *)stops {
    return [GCLCameraStyleFunction functionWithInterpolationMode:GCLInterpolationModeExponential stops:stops options:nil];
}

+ (instancetype)valueWithInterpolationMode:(GCLInterpolationMode)interpolationMode cameraStops:(NSDictionary *)cameraStops options:(NSDictionary *)options {
    return [GCLCameraStyleFunction functionWithInterpolationMode:interpolationMode stops:cameraStops options:options];
}

+ (instancetype)valueWithInterpolationMode:(GCLInterpolationMode)interpolationMode sourceStops:(NSDictionary *)sourceStops attributeName:(NSString *)attributeName options:(NSDictionary *)options {
    return [GCLSourceStyleFunction functionWithInterpolationMode:interpolationMode stops:sourceStops attributeName:attributeName options:options];
}

+ (instancetype)valueWithInterpolationMode:(GCLInterpolationMode)interpolationMode compositeStops:(NSDictionary *)compositeStops attributeName:(NSString *)attributeName options:(NSDictionary *)options {
    return [GCLCompositeStyleFunction functionWithInterpolationMode:interpolationMode stops:compositeStops attributeName:attributeName options:options];
}

@end

@implementation GCLConstantStyleValue

+ (instancetype)valueWithRawValue:(id)rawValue {
    return [[self alloc] initWithRawValue:rawValue];
}

- (instancetype)initWithRawValue:(id)rawValue {
    if (self = [super init]) {
        _rawValue = rawValue;
    }
    return self;
}

- (NSString *)description {
    return [self.rawValue description];
}

- (NSString *)debugDescription {
    return [self.rawValue debugDescription];
}

- (BOOL)isEqual:(GCLConstantStyleValue *)other {
    return [other isKindOfClass:[self class]] && [other.rawValue isEqual:self.rawValue];
}

- (NSUInteger)hash {
    return [self.rawValue hash];
}

@end

@implementation GCLStyleFunction

+ (instancetype)functionWithStops:(NSDictionary *)stops {
    return [GCLCameraStyleFunction functionWithInterpolationMode:GCLInterpolationModeExponential stops:stops options:nil];
}

+ (instancetype)functionWithInterpolationBase:(CGFloat)interpolationBase stops:(NSDictionary *)stops {
    return [GCLCameraStyleFunction functionWithInterpolationMode:GCLInterpolationModeExponential stops:stops options:@{GCLStyleFunctionOptionInterpolationBase: @(interpolationBase)}];
}

- (instancetype)init {
    if (self = [super init]) {
        self.interpolationBase = 1.0;
        self.stops = @{};
    }
    return self;
}

- (instancetype)initWithInterpolationBase:(CGFloat)interpolationBase stops:(NSDictionary *)stops {
    if (self = [super init]) {
        self.interpolationBase = interpolationBase;
        self.stops = stops;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, \
            stops = %@, \
            interpolationBase = %f>",
            NSStringFromClass([self class]), (void *)self,
            self.stops,
            self.interpolationBase];
}

- (BOOL)isEqual:(GCLStyleFunction *)other {
    return ([other isKindOfClass:[self class]]
            && [other.stops isEqualToDictionary:self.stops]
            && other.interpolationBase == self.interpolationBase);
}

- (NSUInteger)hash {
    return  self.stops.hash + @(self.interpolationBase).hash;
}

@end

@implementation GCLCameraStyleFunction

@dynamic stops;

+ (instancetype)functionWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(NSDictionary *)stops options:(NSDictionary *)options {
    return [[self alloc] initWithInterpolationMode:interpolationMode stops:stops options:options];
}

- (instancetype)initWithInterpolationBase:(CGFloat)interpolationBase stops:(NSDictionary *)stops {
    return [self initWithInterpolationMode:GCLInterpolationModeExponential stops:stops options:@{GCLStyleFunctionOptionInterpolationBase: @(interpolationBase)}];
}

- (instancetype)initWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(NSDictionary *)stops options:(NSDictionary *)options {
    if (![stops count]) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Camera functions must have at least one stop."];
        return {};
    }

    if (self = [super init]) {
        self.interpolationMode = interpolationMode;
        self.stops = stops;

        if ([options.allKeys containsObject:GCLStyleFunctionOptionInterpolationBase]) {
            if ([options[GCLStyleFunctionOptionInterpolationBase] isKindOfClass:[NSNumber class]]) {
                NSNumber *value = (NSNumber *)options[GCLStyleFunctionOptionInterpolationBase];
                self.interpolationBase = [value floatValue];
            } else {
                [NSException raise:NSInvalidArgumentException format:@"Interpolation base must be an NSNumber that represents a CGFloat."];
            }
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, \
            interpolationMode = %lu, \
            stops = %@, \
            interpolationBase = %f>",
            NSStringFromClass([self class]), (void *)self,
            (unsigned long)self.interpolationMode,
            self.stops,
            self.interpolationBase];
}

- (BOOL)isEqual:(GCLCameraStyleFunction *)other {
    return ([other isKindOfClass:[self class]]
            && other.interpolationMode == self.interpolationMode
            && [other.stops isEqualToDictionary:self.stops]
            && other.interpolationBase == self.interpolationBase);
}

- (NSUInteger)hash {
    return  @(self.interpolationMode).hash + self.stops.hash + @(self.interpolationBase).hash;
}

@end

@implementation GCLSourceStyleFunction

@dynamic stops;

+ (instancetype)functionWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(NSDictionary *)stops attributeName:(NSString *)attributeName options:(NSDictionary *)options {
    return [[self alloc] initWithInterpolationMode:interpolationMode stops:stops attributeName:attributeName options:options];
}

- (instancetype)initWithInterpolationBase:(CGFloat)interpolationBase stops:(NSDictionary *)stops {
    return [self initWithInterpolationMode:GCLInterpolationModeExponential stops:stops attributeName:@"" options:@{GCLStyleFunctionOptionInterpolationBase: @(interpolationBase)}];
}

- (instancetype)initWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(NSDictionary *)stops attributeName:(NSString *)attributeName options:(NSDictionary *)options {
    if (self = [super init]) {
        self.interpolationMode = interpolationMode;
        self.stops = stops;
        _attributeName = attributeName;

        if ([options.allKeys containsObject:GCLStyleFunctionOptionDefaultValue]) {
            if ([options[GCLStyleFunctionOptionDefaultValue] isKindOfClass:[GCLStyleValue class]]) {
                GCLStyleValue *value = (GCLStyleValue *)options[GCLStyleFunctionOptionDefaultValue];
                _defaultValue = value;
            } else {
                [NSException raise:NSInvalidArgumentException format:@"Default value must be an GCLStyleValue"];
            }
        }

        if ([options.allKeys containsObject:GCLStyleFunctionOptionInterpolationBase]) {
            if ([options[GCLStyleFunctionOptionInterpolationBase] isKindOfClass:[NSNumber class]]) {
                NSNumber *value = (NSNumber *)options[GCLStyleFunctionOptionInterpolationBase];
                self.interpolationBase = [value floatValue];
            } else {
                [NSException raise:NSInvalidArgumentException format:@"Interpolation base must be an NSNumber that represents a CGFloat."];
            }
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, \
            interpolationMode = %lu, \
            stops = %@, \
            attributeName = %@, \
            defaultValue = %@, \
            interpolationBase = %f>",
            NSStringFromClass([self class]),
            (void *)self,
            (unsigned long)self.interpolationMode,
            self.stops,
            self.attributeName,
            self.defaultValue,
            self.interpolationBase];
}

- (BOOL)isEqual:(GCLSourceStyleFunction *)other {
    return ([other isKindOfClass:[self class]]
            && other.interpolationMode == self.interpolationMode
            && ((self.stops && [other.stops isEqualToDictionary:self.stops]) || (!self.stops && !other.stops))
            && [other.attributeName isEqual:self.attributeName]
            && ((self.defaultValue && [other.defaultValue isEqual:self.defaultValue]) || (!self.defaultValue && !other.defaultValue))
            && other.interpolationBase == self.interpolationBase);
}

- (NSUInteger)hash {
    return @(self.interpolationMode).hash + self.stops.hash + self.attributeName.hash + self.defaultValue.hash + @(self.interpolationBase).hash;
}

@end

@implementation GCLCompositeStyleFunction

@dynamic stops;

+ (instancetype)functionWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(NSDictionary *)stops attributeName:(NSString *)attributeName options:(NSDictionary *)options {
    return [[self alloc] initWithInterpolationMode:interpolationMode stops:stops attributeName:attributeName options:options];
}

- (instancetype)initWithInterpolationBase:(CGFloat)interpolationBase stops:(NSDictionary *)stops {
    return [self initWithInterpolationMode:GCLInterpolationModeExponential stops:stops attributeName:@"" options:@{GCLStyleFunctionOptionInterpolationBase: @(interpolationBase)}];
}

- (instancetype)initWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(NSDictionary *)stops attributeName:(NSString *)attributeName options:(NSDictionary *)options {
    if (self = [super init]) {
        self.interpolationMode = interpolationMode;
        self.stops = stops;
        _attributeName = attributeName;

        if ([options.allKeys containsObject:GCLStyleFunctionOptionDefaultValue]) {
            if ([options[GCLStyleFunctionOptionDefaultValue] isKindOfClass:[GCLStyleValue class]]) {
                GCLStyleValue *value = (GCLStyleValue *)options[GCLStyleFunctionOptionDefaultValue];
                _defaultValue = value;
            } else {
                [NSException raise:NSInvalidArgumentException format:@"Default value must be an GCLStyleValue"];
            }
        }

        if ([options.allKeys containsObject:GCLStyleFunctionOptionInterpolationBase]) {
            if ([options[GCLStyleFunctionOptionInterpolationBase] isKindOfClass:[NSNumber class]]) {
                NSNumber *value = (NSNumber *)options[GCLStyleFunctionOptionInterpolationBase];
                self.interpolationBase = [value floatValue];
            } else {
                [NSException raise:NSInvalidArgumentException format:@"Interpolation base must be an NSNumber that represents a CGFloat."];
            }
        }
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p, \
            interpolationMode = %lu, \
            stops = %@, \
            attributeName = %@, \
            defaultValue = %@, \
            interpolationBase = %f>",
            NSStringFromClass([self class]), (void *)self,
            (unsigned long)self.interpolationMode,
            self.stops,
            self.attributeName,
            self.defaultValue,
            self.interpolationBase];
}

- (BOOL)isEqual:(GCLCompositeStyleFunction *)other {
    return ([other isKindOfClass:[self class]]
            && other.interpolationMode == self.interpolationMode
            && [other.stops isEqualToDictionary:self.stops]
            && [other.attributeName isEqual:self.attributeName]
            && ((self.defaultValue && [other.defaultValue isEqual:self.defaultValue]) || (!self.defaultValue && !other.defaultValue))
            && other.interpolationBase == self.interpolationBase);
}

- (NSUInteger)hash {
    return  @(self.interpolationMode).hash + self.stops.hash + self.attributeName.hash + @(self.interpolationBase).hash;
}

@end
