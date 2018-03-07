#import <Foundation/Foundation.h>

#import "GCLFoundation.h"
#import "GCLAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `GCLShape` is an abstract class that represents a shape or annotation. Shapes
 constitute the content of a map – not only the overlays atop the map, but also
 the content that forms the base map.

 Create instances of `GCLPointAnnotation`, `GCLPointCollection`, `GCLPolyline`,
 `GCLMultiPolyline`, `GCLPolygon`, `GCLMultiPolygon`, or `GCLShapeCollection` in
 order to use `GCLShape`'s methods. Do not create instances of `GCLShape` directly,
 and do not create your own subclasses of this class. The shape classes correspond
 to the <a href="https://tools.ietf.org/html/rfc7946#section-3.1">Geometry</a> object
 types in the GeoJSON standard, but some have nonstandard names for backwards
 compatibility.

 Although you do not create instances of this class directly, you can use its
 `+[GCLShape shapeWithData:encoding:error:]` factory method to create one of the
 concrete subclasses of `GCLShape` noted above from GeoJSON data.

 You can add shapes to the map by adding them to an `GCLShapeSource` object.
 Configure the appearance of an `GCLShapeSource`’s or `GCLVectorSource`’s shapes
 collectively using a concrete instance of `GCLVectorStyleLayer`. Alternatively,
 you can add some kinds of shapes directly to a map view as annotations or
 overlays.
 */
GCL_EXPORT
@interface GCLShape : NSObject <GCLAnnotation, NSSecureCoding>

#pragma mark Creating a Shape

/**
 Returns an `GCLShape` object initialized with the given data interpreted as a
 string containing a GeoJSON object.

 If the GeoJSON object is a geometry, the returned value is a kind of
 `GCLShape`. If it is a feature object, the returned value is a kind of
 `GCLShape` that conforms to the `GCLFeature` protocol. If it is a feature
 collection object, the returned value is an instance of
 `GCLShapeCollectionFeature`.

 ### Example

 ```swift
 let url = mainBundle.url(forResource: "amsterdam", withExtension: "geojson")!
 let data = try! Data(contentsOf: url)
 let feature = try! GCLShape(data: data, encoding: String.Encoding.utf8.rawValue) as! GCLShapeCollectionFeature
 ```

 @param data String data containing GeoJSON source code.
 @param encoding The encoding used by `data`.
 @param outError Upon return, if an error has occurred, a pointer to an
    `NSError` object describing the error. Pass in `NULL` to ignore any error.
 @return An `GCLShape` object representation of `data`, or `nil` if `data` could
    not be parsed as valid GeoJSON source code. If `nil`, `outError` contains an
    `NSError` object describing the problem.
 */
+ (nullable GCLShape *)shapeWithData:(NSData *)data encoding:(NSStringEncoding)encoding error:(NSError * _Nullable *)outError;

#pragma mark Accessing the Shape Attributes

/**
 The title of the shape annotation.

 The default value of this property is `nil`.

 This property is ignored when the shape is used in an `GCLShapeSource`. To name
 a shape used in a shape source, create an `GCLFeature` and add an attribute to
 the `GCLFeature.attributes` property.
 */
@property (nonatomic, copy, nullable) NSString *title;

/**
 The subtitle of the shape annotation. The default value of this property is
 `nil`.

 This property is ignored when the shape is used in an `GCLShapeSource`. To
 provide additional information about a shape used in a shape source, create an
 `GCLFeature` and add an attribute to the `GCLFeature.attributes` property.
 */
@property (nonatomic, copy, nullable) NSString *subtitle;

#if !TARGET_OS_IPHONE

/**
 The tooltip of the shape annotation.

 The default value of this property is `nil`.

 This property is ignored when the shape is used in an `GCLShapeSource`.
 */
@property (nonatomic, copy, nullable) NSString *toolTip;

#endif

#pragma mark Creating GeoJSON Data

/**
 Returns the GeoJSON string representation of the shape encapsulated in a data
 object.

 @param encoding The string encoding to use.
 @return A data object containing the shape’s GeoJSON string representation.
 */
- (NSData *)geoJSONDataUsingEncoding:(NSStringEncoding)encoding;

@end

NS_ASSUME_NONNULL_END
