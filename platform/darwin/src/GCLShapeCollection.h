#import <Foundation/Foundation.h>

#import "GCLFoundation.h"
#import "GCLShape.h"

#import "GCLTypes.h"

NS_ASSUME_NONNULL_BEGIN

/**
 An `GCLShapeCollection` object represents a shape consisting of zero or more
 distinct but related shapes that are instances of `GCLShape`. The constituent
 shapes can be a mixture of different kinds of shapes.

 `GCLShapeCollection` is most commonly used to add multiple shapes to a single
 `GCLShapeSource`. Configure the appearance of an `GCLShapeSource`’s or
 `GCLVectorSource`’s shape collection collectively using an
 `GCLSymbolStyleLayer` object, or use multiple instances of
 `GCLCircleStyleLayer`, `GCLFillStyleLayer`, and `GCLLineStyleLayer` to
 configure the appearance of each kind of shape inside the collection.

 You cannot add an `GCLShapeCollection` object directly to a map view as an
 annotation. However, you can create individual `GCLPointAnnotation`,
 `GCLPolyline`, and `GCLPolygon` objects from the `shapes` array and add those
 annotation objects to the map view using the `-[GCLMapView addAnnotations:]`
 method.

 To represent a collection of point, polyline, or polygon shapes, it may be more
 convenient to use an `GCLPointCollection`, `GCLMultiPolyline`, or
 `GCLMultiPolygon` object, respectively.

 A shape collection is known as a
 <a href="https://tools.ietf.org/html/rfc7946#section-3.1.8">GeometryCollection</a>
 geometry in GeoJSON.
 */
GCL_EXPORT
@interface GCLShapeCollection : GCLShape

/**
 An array of shapes forming the shape collection.
 */
@property (nonatomic, copy, readonly) NS_ARRAY_OF(GCLShape *) *shapes;

/**
 Creates and returns a shape collection consisting of the given shapes.

 @param shapes The array of shapes defining the shape collection. The data in
    this array is copied to the new object.
 @return A new shape collection object.
 */
+ (instancetype)shapeCollectionWithShapes:(NS_ARRAY_OF(GCLShape *) *)shapes;

@end

NS_ASSUME_NONNULL_END
