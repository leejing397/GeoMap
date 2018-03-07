#import <Foundation/Foundation.h>

#import "GCLFoundation.h"
#import "GCLTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `GCLStyleLayer` is an abstract base class for style layers. A style layer
 manages the layout and appearance of content at a specific z-index in a style.
 An `GCLStyle` object consists of one or more `GCLStyleLayer` objects.

 Each style layer defined by the style JSON file is represented at runtime by an
 `GCLStyleLayer` object, which you can use to refine the map’s appearance. You
 can also add and remove style layers dynamically.

 Create instances of `GCLBackgroundStyleLayer` and the concrete subclasses of
 `GCLForegroundStyleLayer` in order to use `GCLStyleLayer`'s properties and methods.
 You do not create instances of `GCLStyleLayer` directly, and do not
 create your own subclasses of this class.
 
 Do not add `GCLStyleLayer` objects to the `style` property of a `GCLMapView` before
 `-mapView:didFinishLoadingStyle:` is called.
 */
GCL_EXPORT
@interface GCLStyleLayer : NSObject

#pragma mark Initializing a Style Layer

- (instancetype)init __attribute__((unavailable("Use -init methods of concrete subclasses instead.")));

#pragma mark Identifying a Style Layer

/**
 A string that uniquely identifies the style layer in the style to which it is
 added.
 */
@property (nonatomic, copy, readonly) NSString *identifier;

#pragma mark Configuring a Style Layer’s Visibility

/**
 Whether this layer is displayed. A value of `NO` hides the layer.
 */
@property (nonatomic, assign, getter=isVisible) BOOL visible;

/**
 The maximum zoom level at which the layer gets parsed and appears. This value is a floating-point number.
 */
@property (nonatomic, assign) float maximumZoomLevel;

/**
 The minimum zoom level at which the layer gets parsed and appears. This value is a floating-point number.
 */
@property (nonatomic, assign) float minimumZoomLevel;

@end

NS_ASSUME_NONNULL_END
