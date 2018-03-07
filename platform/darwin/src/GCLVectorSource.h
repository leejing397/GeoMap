#import "GCLFeature.h"
#import "GCLFoundation.h"
#import "GCLTileSource.h"

NS_ASSUME_NONNULL_BEGIN

/**
 `GCLVectorSource` is a map content source that supplies tiled vector data in
 <a href="https://www.mapbox.com/vector-tiles/">Mapbox Vector Tile</a> format to
 be shown on the map. The location of and metadata about the tiles are defined
 either by an option dictionary or by an external file that conforms to the
 <a href="https://github.com/mapbox/tilejson-spec/">TileJSON specification</a>.
 A vector source is added to an `GCLStyle` object along with one or more
 `GCLVectorStyleLayer` objects. A vector style layer defines the appearance of
 any content supplied by the vector source.

 Each
 <a href="https://www.mapbox.com/mapbox-gl-style-spec/#sources-vector"><code>vector</code></a>
 source defined by the style JSON file is represented at runtime by an
 `GCLVectorSource` object that you can use to initialize new style layers. You
 can also add and remove sources dynamically using methods such as
 `-[GCLStyle addSource:]` and `-[GCLStyle sourceWithIdentifier:]`.

 Within each vector tile, each geometric coordinate must lie between
 −1&nbsp;×&nbsp;<var>extent</var> and
 (<var>extent</var>&nbsp;×&nbsp;2)&nbsp;−&nbsp;1, inclusive. Any vector style
 layer initialized with a vector source must have a non-`nil` value in its
 `sourceLayerIdentifier` property.
 
 Commonly used vector sources include
 <a href="https://www.mapbox.com/vector-tiles/mapbox-streets/">Mapbox Streets</a>,
 <a href="https://www.mapbox.com/vector-tiles/mapbox-terrain/">Mapbox Terrain</a>,
 and
 <a href="https://www.mapbox.com/vector-tiles/mapbox-traffic-v1/">Mapbox Traffic</a>.

 ### Example

 ```swift
 let source = GCLVectorSource(identifier: "pois", tileURLTemplates: ["https://example.com/vector-tiles/{z}/{x}/{y}.mvt"], options: [
     .minimumZoomLevel: 9,
     .maximumZoomLevel: 16,
     .attributionInfos: [
         GCLAttributionInfo(title: NSAttributedString(string: "© Mapbox"), url: URL(string: "http://mapbox.com"))
     ]
 ])
 mapView.style?.addSource(source)
 ```
 */
GCL_EXPORT
@interface GCLVectorSource : GCLTileSource

#pragma mark Initializing a Source

/**
 Returns a vector source initialized with an identifier and configuration URL.

 After initializing and configuring the source, add it to a map view’s style
 using the `-[GCLStyle addSource:]` method.

 The URL may be a full HTTP or HTTPS URL or, for tile sets hosted by Mapbox, a
 Mapbox URL indicating a map identifier (`mapbox://<mapid>`). The URL should
 point to a JSON file that conforms to the
 <a href="https://github.com/mapbox/tilejson-spec/">TileJSON specification</a>.

 @param identifier A string that uniquely identifies the source in the style to
    which it is added.
 @param configurationURL A URL to a TileJSON configuration file describing the
    source’s contents and other metadata.
 @return An initialized vector source.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier configurationURL:(NSURL *)configurationURL NS_DESIGNATED_INITIALIZER;

/**
 Returns a vector source initialized an identifier, tile URL templates, and
 options.

 Tile URL templates are strings that specify the URLs of the vector tiles to
 load. See the “<a href="../tile-url-templates.html">Tile URL Templates</a>”
 guide for information about the format of a tile URL template.

 After initializing and configuring the source, add it to a map view’s style
 using the `-[GCLStyle addSource:]` method.

 @param identifier A string that uniquely identifies the source in the style to
    which it is added.
 @param tileURLTemplates An array of tile URL template strings. Only the first
    string is used; any additional strings are ignored.
 @param options A dictionary containing configuration options. See
    `GCLTileSourceOption` for available keys and values. Pass in `nil` to use
    the default values.
 @return An initialized tile source.
 */
- (instancetype)initWithIdentifier:(NSString *)identifier tileURLTemplates:(NS_ARRAY_OF(NSString *) *)tileURLTemplates options:(nullable NS_DICTIONARY_OF(GCLTileSourceOption, id) *)options NS_DESIGNATED_INITIALIZER;

#pragma mark Accessing a Source’s Content

/**
 Returns an array of map features loaded by this source, restricted to the given
 source layers and filtered by the given predicate.

 Each object in the returned array represents a feature loaded by the source and
 provides access to attributes specified as part of the loaded feature. The
 source loads a feature if the source is added to an `GCLMapView`’s style; that
 style has a layer that uses the source; and the map view has recently scrolled
 to the region containing the feature.

 Features come from tiled vector data that is converted to tiles internally, so
 feature geometries are clipped at tile boundaries and features may appear
 duplicated across tiles. For example, suppose part of a lengthy polyline
 representing a road has recently scrolled into view. The resulting array
 includes those parts of the road that lie within the map tiles that the source
 has loaded, even if the road extends into other tiles. The portion of the road
 within each map tile is included individually.
 
 Returned features may not necessarily be visible to the user at the time they
 are loaded: the style may contain a layer that forces the source’s tiles to
 load but filters out the features in question, preventing them from being
 drawn. To obtain only _visible_ features, use the
 `-[GCLMapView visibleFeaturesAtPoint:inStyleLayersWithIdentifiers:predicate:]`
 or
 `-[GCLMapView visibleFeaturesInRect:inStyleLayersWithIdentifiers:predicate:]`
 method.

 @param sourceLayerIdentifiers The source layers to include in the query. Only
    the features contained in these source layers are included in the returned
    array. This array may not be empty.
 @param predicate A predicate to filter the returned features. Use `nil` to
    include all loaded features.
 @return An array of objects conforming to the `GCLFeature` protocol that
    represent features loaded by the source that match the predicate.
 */
- (NS_ARRAY_OF(id <GCLFeature>) *)featuresInSourceLayersWithIdentifiers:(NS_SET_OF(NSString *) *)sourceLayerIdentifiers predicate:(nullable NSPredicate *)predicate NS_SWIFT_NAME(features(sourceLayerIdentifiers:predicate:));

@end

NS_ASSUME_NONNULL_END
