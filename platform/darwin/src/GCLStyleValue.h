#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#import "GCLFoundation.h"
#import "GCLTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Options for `GCLStyleFunction` objects.
 */
typedef NSString *GCLStyleFunctionOption NS_STRING_ENUM;

/**
 An `NSNumber` object containing an integer that determines the style function's 
 exponential interpolation base.
 
 The exponential interpolation base controls the rate at which the function’s 
 output values increase. A value of 1 causes the function to increase linearly 
 based on zoom level or attribute value. A higher exponential interpolation base
 causes the function’s output values to vary exponentially, increasing more rapidly
 towards the high end of the function’s range. The default value of this property 
 is 1, for a linear curve.

 This attribute corresponds to the
 <a href="https://www.mapbox.com/mapbox-gl-js/style-spec/#function-base"><code>base</code></a>
 function property in the Mapbox Style Specification.

 This option only applies to functions that use an 
 `GCLInterpolationModeExponential` interpolation mode that are assigned to
 interpolatable style layer properties.
 */
extern GCL_EXPORT const GCLStyleFunctionOption GCLStyleFunctionOptionInterpolationBase;

/**
 An `GCLConstantStyleValue` object that specifies a default value that a style
 function can use when it can't otherwise determine a value.

 A default value can be used to set the value of a style layer property that
 is not otherwise set by a function. For example, a source function with a
 `GCLInterpolationModeCategorical` interpolation mode with stops that specify
 color values to use based on a feature's attributes would set any feature
 that does not have attributes that match the stop key values to this 
 default value.
 
 This option only applies to `GCLSourceStyleFunction` and
 `GCLCompositeStyleFunction` functions.
 */
extern GCL_EXPORT const GCLStyleFunctionOption GCLStyleFunctionOptionDefaultValue;

/** 
 The modes used to interpolate property values between map zoom level changes
 or over a range of feature attribute values.
 */
typedef NS_ENUM(NSUInteger, GCLInterpolationMode) {
    /**
     Values between two stops are interpolated linearly, or exponentially based on 
     the `GCLStyleFunctionOptionInterpolationBase`. A higher interpolation base 
     causes the function’s output values to vary exponentially, increasing more rapidly
     towards the high end of the function’s range. The default interpolation base of 1 
     creates a linear interpolation. Use exponential interpolation mode to show values
     relative to stop keys.
     */
    GCLInterpolationModeExponential = 0,
    /**
     Values between two stops are not interpolated. Instead, properties are set
     to the value of the stop just less than the function input. Use interval
     interpolation mode to show values that fall within a range.
     */
    GCLInterpolationModeInterval,
    /**
     Values between two stops are not interpolated. Instead, properties are set
     to the value of the stop equal to the function input's key value. Use
     categorical interpolation mode to show values that fit into categories.
     */
    GCLInterpolationModeCategorical,
    /**
     Values between two stops are not interpolated. Instead, for any given feature, the
     style value matches a value in that feature’s attributes dictionary. Use identity
     interpolation mode to show attribute values that can be used as style values.
     */
    GCLInterpolationModeIdentity
};

/**
 An `GCLStyleValue` object is a generic container for a style attribute value.
 The layout and paint attribute properties of `GCLStyleLayer` can be set to
 `GCLStyleValue` objects.

 The `GCLStyleValue` class itself represents a class cluster. Under the hood, a
 particular `GCLStyleValue` object may be either an `GCLConstantStyleValue` to
 represent a constant value or one of the concrete subclasses of 
 `GCLStyleFunction` to represent a value function. Do not initialize an 
 `GCLStyleValue` object directly; instead, use one of the class factory methods
 to create an `GCLStyleValue` object.

 The `GCLStyleValue` class takes a generic parameter `T` that indicates the
 Foundation class being wrapped by this class. Common values for `T` include:

 <ul>
 <li><code>NSNumber</code> (for Boolean values and floating-point numbers)</li>
 <li><code>NSValue</code> (for <code>CGVector</code>, <code>NSEdgeInsets</code>, <code>UIEdgeInsets</code>, and enumerations)</li>
 <li><code>NSString</code></li>
 <li><code>NSColor</code> or <code>UIColor</code></li>
 <li><code>NSArray</code></li>
 </ul>
 */
GCL_EXPORT
@interface GCLStyleValue<T> : NSObject

#pragma mark Creating a Style Value

/**
 Creates and returns an `GCLConstantStyleValue` object containing a raw value.

 @param rawValue The constant value contained by the object.
 @return An `GCLConstantStyleValue` object containing `rawValue`, which is
    treated as a constant value.
 */
+ (instancetype)valueWithRawValue:(T)rawValue;

#pragma mark Function values

/**
 Creates and returns an `GCLCameraStyleFunction` object representing a linear camera
 function with one or more stops.

 @param stops A dictionary associating zoom levels with style values.
 @return An `GCLCameraStyleFunction` object with the given stops.
 */
+ (instancetype)valueWithStops:(NS_DICTIONARY_OF(NSNumber *, GCLStyleValue<T> *) *)stops __attribute__((deprecated("Use +[GCLStyleValue valueWithInterpolationMode:cameraStops:options:]")));

/**
 Creates and returns an `GCLCameraStyleFunction` object representing a camera
 function with an exponential interpolation base and one or more stops.

 @param interpolationBase The exponential base of the interpolation curve.
 @param stops A dictionary associating zoom levels with style values.
 @return An `GCLCameraStyleFunction` object with the given interpolation base and stops.
 */
+ (instancetype)valueWithInterpolationBase:(CGFloat)interpolationBase stops:(NS_DICTIONARY_OF(NSNumber *, GCLStyleValue<T> *) *)stops __attribute__((deprecated("Use +[GCLStyleValue valueWithInterpolationMode:cameraStops:options:]")));

/**
 Creates and returns an `GCLCameraStyleFunction` object representing a camera function
 with one or more stops.

 @param interpolationMode The mode used to interpolate property values between 
    map zoom level changes.
 @param cameraStops A dictionary associating zoom levels with style values.
 @param options A dictionary containing `GCLStyleFunctionOption` values that
    specify how a function is applied.
 @return An `GCLCameraStyleFunction` object with the given interpolation mode,
    camera stops, and options.
 */
+ (instancetype)valueWithInterpolationMode:(GCLInterpolationMode)interpolationMode cameraStops:(NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *)cameraStops options:(nullable NS_DICTIONARY_OF(GCLStyleFunctionOption, id) *)options;

/**
 Creates and returns an `GCLSourceStyleFunction` object representing a source function.

 @param interpolationMode The mode used to interpolate property values over a 
    range of feature attribute values.
 @param sourceStops A dictionary associating feature attributes with style values.
 @param attributeName Specifies the feature attribute to take as the function 
    input.
 @param options A dictionary containing `GCLStyleFunctionOption` values that
    specify how a function is applied.
 @return An `GCLSourceStyleFunction` object with the given interpolation mode,
    source stops, attribute name, and options.
 */
+ (instancetype)valueWithInterpolationMode:(GCLInterpolationMode)interpolationMode sourceStops:(nullable NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *)sourceStops attributeName:(NSString *)attributeName options:(nullable NS_DICTIONARY_OF(GCLStyleFunctionOption, id) *)options;

/**
 Creates and returns an `GCLCompositeStyleFunction` object representing a composite
 function.

 @param interpolationMode The mode used to interpolate property values over a 
    range of feature attribute values for each outer zoom level.
 @param compositeStops A dictionary associating feature attributes with style
    values.
 @param attributeName Specifies the feature attribute to take as the function
    input.
 @param options A dictionary containing `GCLStyleFunctionOption` values that
    specify how a function is applied.
 @return An `GCLCompositeStyleFunction` object with the given interpolation mode,
    composite stops, attribute name, and options.
 */
+ (instancetype)valueWithInterpolationMode:(GCLInterpolationMode)interpolationMode compositeStops:(NS_DICTIONARY_OF(id, NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *) *)compositeStops attributeName:(NSString *)attributeName options:(nullable NS_DICTIONARY_OF(GCLStyleFunctionOption, id) *)options;

@end

/**
 An `GCLConstantStyleValue` object is a generic container for a style attribute
 value that remains constant as the zoom level changes. The layout and paint
 attribute properties of `GCLStyleLayer` objects can be set to
 `GCLConstantStyleValue` objects.

 The `GCLConstantStyleValue` class takes a generic parameter `T` that indicates
 the Foundation class being wrapped by this class.
 */
GCL_EXPORT
@interface GCLConstantStyleValue<T> : GCLStyleValue<T>

#pragma mark Creating a Style Constant Value

/**
 Creates and returns an `GCLConstantStyleValue` object containing a raw value.

 @param rawValue The constant value contained by the object.
 @return An `GCLConstantStyleValue` object containing `rawValue`, which is
    treated as a constant value.
 */
+ (instancetype)valueWithRawValue:(T)rawValue;

#pragma mark Initializing a Style Constant Value

- (instancetype)init NS_UNAVAILABLE;

/**
 Returns an `GCLConstantStyleValue` object containing a raw value.

 @param rawValue The value contained by the receiver.
 @return An `GCLConstantStyleValue` object containing `rawValue`.
 */
- (instancetype)initWithRawValue:(T)rawValue NS_DESIGNATED_INITIALIZER;

#pragma mark Accessing the Underlying Value

/**
 The raw value contained by the receiver.
 */
@property (nonatomic) T rawValue;

@end

@compatibility_alias GCLStyleConstantValue GCLConstantStyleValue;

/**
 An `GCLStyleFunction` is a is an abstract superclass for functions that are 
 defined by an `GCLCameraStyleFunction`, `GCLSourceStyleFunction`, or
 `GCLCompositeStyleFunction` object.
 
 Create instances of `GCLCameraStyleFunction`, `GCLSourceStyleFunction`, and
 `GCLCompositeStyleFunction` in order to use `GCLStyleFunction`'s methods. Do
 not create instances of `GCLStyleFunction` directly, and do not create your
 own subclasses of this class.

 The `GCLStyleFunction` class takes a generic parameter `T` that indicates the
 Foundation class being wrapped by this class.
 */
GCL_EXPORT
@interface GCLStyleFunction<T> : GCLStyleValue<T>

#pragma mark Creating a Style Function

/**
 Creates and returns an `GCLCameraStyleFunction` object representing a camera 
 function with a linear interpolation curve.

 @note Do not create function instances using this method unless it is required 
    for backwards compatiblity with your application code.

 @param stops A dictionary associating zoom levels with style values.
 @return An `GCLCameraStyleFunction` object with the given stops.
 */
+ (instancetype)functionWithStops:(NS_DICTIONARY_OF(NSNumber *, GCLStyleValue<T> *) *)stops __attribute__((deprecated("Use +[GCLStyleValue valueWithInterpolationMode:cameraStops:options:]")));

/**
 Creates and returns an `GCLCameraStyleFunction` object representing a camera
 function with an interpolation curve controlled by the provided interpolation 
 base.

 @note Do not create function instances using this method unless it is required
    for backwards compatiblity with your application code.

 @param interpolationBase The exponential base of the interpolation curve.
 @param stops A dictionary associating zoom levels with style values.
 @return An `GCLCameraStyleFunction` object with the given interpolation base and stops.
 */
+ (instancetype)functionWithInterpolationBase:(CGFloat)interpolationBase stops:(NS_DICTIONARY_OF(NSNumber *, GCLStyleValue<T> *) *)stops __attribute__((deprecated("Use +[GCLStyleValue valueWithInterpolationMode:cameraStops:options:]")));

#pragma mark Initializing a Style Function

/**
 Returns an `GCLStyleFunction` object representing a camera function. If the
 function is set as a style layer property value, it will be interpreted
 as a camera function with an interpolation curve controlled by the provided
 interpolation base.
 
 @note Do not create instances of `GCLStyleFunction` unless it is required for
    backwards compatiblity with your application code. You should create and use
    instances of `GCLCameraStyleFunction` to specify how properties will
    be visualized at different zoom levels.

 @param interpolationBase The exponential base of the interpolation curve.
 @param stops A dictionary associating zoom levels with style values.
 @return An `GCLStyleFunction` object with the given interpolation base and stops.
 */
- (instancetype)initWithInterpolationBase:(CGFloat)interpolationBase stops:(NS_DICTIONARY_OF(NSNumber *, GCLStyleValue<T> *) *)stops __attribute__((deprecated("Use +[GCLStyleValue valueWithInterpolationMode:cameraStops:options:]")));

#pragma mark Accessing the Parameters of a Function

/**
 The modes used to interpolate property values between map zoom level changes or
 over a range of feature attribute values.
 */
@property (nonatomic) GCLInterpolationMode interpolationMode;

/**
 A dictionary associating zoom levels with style values.
 */
@property (nonatomic, copy, nullable) NSDictionary *stops;

/**
 The exponential interpolation base of the function’s interpolation curve.
 
 @note This property specifies the exponential base of the interpolation curve 
    of `GCLCameraStyleFunction` and `GCLSourceStyleFunction` functions that use
    a `GCLInterpolationModeExponential` `interpolationMode`. Otherwise, it is
    ignored.
 */
@property (nonatomic) CGFloat interpolationBase;

@end

/**
 An `GCLCameraStyleFunction` is a value function defining a style value that changes
 as the zoom level changes. The layout and paint attribute properties of an
 `GCLStyleLayer` object can be set to `GCLCameraStyleFunction` objects. Use a camera
 function to create the illusion of depth and control data density.

 The `GCLCameraStyleFunction` class takes a generic parameter `T` that indicates the
 Foundation class being wrapped by this class.
 */
GCL_EXPORT
@interface GCLCameraStyleFunction<T> : GCLStyleFunction<T>

#pragma mark Creating a Camera Function

/**
 Creates and returns an `GCLCameraStyleFunction` object representing a camera
 function with one or more stops.

 @param interpolationMode The mode used to interpolate property values between
    map zoom level changes.
 @param stops A dictionary associating zoom levels with style values.
 @param options A dictionary containing `GCLStyleFunctionOption` values that
    specify how a function is applied.
 @return An `GCLCameraStyleFunction` object with the given interpolation mode,
    camera stops, and options.
 */
+ (instancetype)functionWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *)stops options:(nullable NS_DICTIONARY_OF(GCLStyleFunctionOption, id) *)options;

#pragma mark Accessing the Parameters of a Camera Function

/**
 A dictionary associating zoom levels with style values.

 Each of the function’s stops is represented by one key-value pair in the
 dictionary. Each key in the dictionary is an `NSNumber` object containing a
 floating-point zoom level. Each value in the dictionary is an `GCLStyleValue`
 object containing the value of the style attribute when the map is at the
 associated zoom level. An `GCLStyleFunction` object may not be used recursively
 as a stop value.
 */
@property (nonatomic, copy) NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *stops;

@end

/**
 An `GCLSourceStyleFunction` is a value function defining a style value that
 changes with its properties. The layout and paint attribute properties of an
 `GCLStyleLayer` object can be set to `GCLSourceStyleFunction` objects.
 Use source functions to visually differentate types of features within the same 
 layer or create data visualizations.

 The `GCLSourceStyleFunction` class takes a generic parameter `T` that indicates the
 Foundation class being wrapped by this class.
 */
GCL_EXPORT
@interface GCLSourceStyleFunction<T> : GCLStyleFunction<T>

#pragma mark Creating a Source Function

/**
 Creates and returns an `GCLSourceStyleFunction` object representing a source
 function.

 @param interpolationMode The mode used to interpolate property values over a
    range of feature attribute values.
 @param stops A dictionary associating feature attributes with style values.
 @param attributeName Specifies the feature attribute to take as the function
    input.
 @param options A dictionary containing `GCLStyleFunctionOption` values that
    specify how a function is applied.
 @return An `GCLSourceStyleFunction` object with the given interpolation mode,
    source stops, attribute name, and options.
*/
+ (instancetype)functionWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(nullable NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *)stops attributeName:(NSString *)attributeName options:(nullable NS_DICTIONARY_OF(GCLStyleFunctionOption, id) *)options;

#pragma mark Accessing the Parameters of a Source Function

/**
 A string that specifies the feature attribute key whose value be used as the function
 input.
*/
@property (nonatomic, copy) NSString *attributeName;

/**
 A dictionary associating attribute values with style values.

 Each of the function’s stops is represented by one key-value pair in the
 dictionary. Each key in the dictionary is an object representing a feature 
 attribute key or interpolation stop. Each value in the dictionary is an 
 `GCLStyleValue` object containing the value to use when the function is given
 the associated attribute key. An `GCLStyleFunction` object may not be used
 recursively as a stop value.
 */
@property (nonatomic, copy, nullable) NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *stops;

/**
 An `GCLStyleValue` object containing the default value to use when there is
 no input to provide to the function.
 */
@property (nonatomic, nullable) GCLStyleValue<T> *defaultValue;

@end

/**
 An `GCLCompositeStyleFunction` is a value function defining a style value that
 changes with the feature attributes at each map zoom level. The layout and paint 
 attribute properties of an `GCLStyleLayer` object can be set to
 `GCLCompositeStyleFunction` objects. Use composite functions to allow the
 appearance of a map feature to change with both its attributes and the map zoom 
 level.

 The `GCLCompositeStyleFunction` class takes a generic parameter `T` that indicates the
 Foundation class being wrapped by this class.
 */
GCL_EXPORT
@interface GCLCompositeStyleFunction<T> : GCLStyleFunction<T>

#pragma mark Creating a Composite Function

/**
 Creates and returns an `GCLCompositeStyleFunction` object representing a composite
 function.

 @param interpolationMode The mode used to interpolate property values over a
    range of feature attribute values for each outer zoom level.
 @param stops A dictionary associating feature attributes with style values.
 @param attributeName Specifies the feature attribute to take as the function
    input.
 @param options A dictionary containing `GCLStyleFunctionOption` values that
    specify how a function is applied.
 @return An `GCLCompositeStyleFunction` object with the given interpolation mode,
    composite stops, attribute name, and options.
 */
+ (instancetype)functionWithInterpolationMode:(GCLInterpolationMode)interpolationMode stops:(NS_DICTIONARY_OF(id, NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *) *)stops attributeName:(NSString *)attributeName options:(nullable NS_DICTIONARY_OF(GCLStyleFunctionOption, id) *)options;

#pragma mark Accessing the Parameters of a Composite Function

/**
 A string that specifies the feature attribute key whose value be used as the function
 input.
 */
@property (nonatomic, copy) NSString *attributeName;

/**
 A dictionary associating attribute values with style values.

 Each of the function’s stops is represented by one key-value pair in the
 dictionary. Each key in the dictionary is an `NSNumber` object containing a
 floating-point zoom level. Each value in the dictionary is an inner nested 
 dictionary. Each key in the nested dictionary is an object representing a feature
 attribute key or interpolation stop. Each value in the nested dictionary is an
 `GCLStyleValue` object containing the value to use when the function is given
 the associated attribute key. An `GCLStyleFunction` object may not be used
 recursively as a value inside the nested dictionary.
 */
@property (nonatomic, copy) NS_DICTIONARY_OF(id, NS_DICTIONARY_OF(id, GCLStyleValue<T> *) *) *stops;

/**
 An `GCLStyleValue` object containing the default value to use when there is
 no input to provide to the function.
 */
@property (nonatomic, nullable) GCLStyleValue<T> *defaultValue;

@end

NS_ASSUME_NONNULL_END
