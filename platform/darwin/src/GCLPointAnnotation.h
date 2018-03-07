#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "GCLFoundation.h"
#import "GCLShape.h"

NS_ASSUME_NONNULL_BEGIN

/**
 An `GCLPointAnnotation` object represents a one-dimensional shape located at a
 single geographical coordinate. Depending on how it is used, an
 `GCLPointAnnotation` object is known as a point annotation or point shape. For
 example, you could use a point shape to represent a city at low zoom levels, an
 address at high zoom levels, or the location of a long press gesture.

 You can add point shapes to the map by adding them to an `GCLShapeSource`
 object. Configure the appearance of an `GCLShapeSource`’s or
 `GCLVectorSource`’s point shapes collectively using an `GCLCircleStyleLayer` or
 `GCLSymbolStyleLayer` object.

 For more interactivity, add a selectable point annotation to a map view using
 the `-[GCLMapView addAnnotation:]` method. Alternatively, define your own model
 class that conforms to the `GCLAnnotation` protocol. Configure a point
 annotation’s appearance using
 `-[GCLMapViewDelegate mapView:imageForAnnotation:]` or
 `-[GCLMapViewDelegate mapView:viewForAnnotation:]` (iOS only). A point
 annotation’s `GCLShape.title` and `GCLShape.subtitle` properties define the
 default content of the annotation’s callout (on iOS) or popover (on macOS).

 To group multiple related points together in one shape, use an
 `GCLPointCollection` or `GCLShapeCollection` object.

 A point shape is known as a
 <a href="https://tools.ietf.org/html/rfc7946#section-3.1.2">Point</a> geometry
 in GeoJSON.
 */
GCL_EXPORT
@interface GCLPointAnnotation : GCLShape

/**
 The coordinate point of the shape, specified as a latitude and longitude.
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

NS_ASSUME_NONNULL_END
