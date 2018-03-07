#import "GCLRasterSource_Private.h"

#import "GCLMapView_Private.h"
#import "GCLSource_Private.h"
#import "GCLTileSource_Private.h"
#import "NSURL+GCLAdditions.h"

#include <mbgl/map/map.hpp>
#include <mbgl/style/sources/raster_source.hpp>

const GCLTileSourceOption GCLTileSourceOptionTileSize = @"GCLTileSourceOptionTileSize";

static const CGFloat GCLRasterSourceClassicTileSize = 256;
static const CGFloat GCLRasterSourceRetinaTileSize = 512;

@interface GCLRasterSource ()

@property (nonatomic, readonly) mbgl::style::RasterSource *rawSource;

@end

@implementation GCLRasterSource

- (instancetype)initWithIdentifier:(NSString *)identifier configurationURL:(NSURL *)configurationURL {
    // The style specification default is 512, but 256 is the expected value for
    // any tile set that would be accessed through a mapbox: URL and therefore
    // any tile URL that this option currently affects.
    BOOL isMapboxURL = ([configurationURL.scheme isEqualToString:@"mapbox"]
                        && [configurationURL.host containsString:@"."]
                        && (!configurationURL.path.length || [configurationURL.path isEqualToString:@"/"]));
    CGFloat tileSize = isMapboxURL ? GCLRasterSourceClassicTileSize : GCLRasterSourceRetinaTileSize;
    return [self initWithIdentifier:identifier configurationURL:configurationURL tileSize:tileSize];
}

- (instancetype)initWithIdentifier:(NSString *)identifier configurationURL:(NSURL *)configurationURL tileSize:(CGFloat)tileSize {
    auto source = std::make_unique<mbgl::style::RasterSource>(identifier.UTF8String,
                                                              configurationURL.gcl_URLByStandardizingScheme.absoluteString.UTF8String,
                                                              uint16_t(round(tileSize)));
    return self = [super initWithPendingSource:std::move(source)];
}

- (instancetype)initWithIdentifier:(NSString *)identifier tileURLTemplates:(NS_ARRAY_OF(NSString *) *)tileURLTemplates options:(nullable NS_DICTIONARY_OF(GCLTileSourceOption, id) *)options {
    mbgl::Tileset tileSet = GCLTileSetFromTileURLTemplates(tileURLTemplates, options);

    uint16_t tileSize = GCLRasterSourceRetinaTileSize;
    if (NSNumber *tileSizeNumber = options[GCLTileSourceOptionTileSize]) {
        if (![tileSizeNumber isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"MGLTileSourceOptionTileSize must be set to an NSNumber."];
        }
        tileSize = static_cast<uint16_t>(round(tileSizeNumber.doubleValue));
    }

    auto source = std::make_unique<mbgl::style::RasterSource>(identifier.UTF8String, tileSet, tileSize);
    return self = [super initWithPendingSource:std::move(source)];
}

- (mbgl::style::RasterSource *)rawSource {
    return (mbgl::style::RasterSource *)super.rawSource;
}

- (NSURL *)configurationURL {
    auto url = self.rawSource->getURL();
    return url ? [NSURL URLWithString:@(url->c_str())] : nil;
}

- (NSString *)attributionHTMLString {
    auto attribution = self.rawSource->getAttribution();
    return attribution ? @(attribution->c_str()) : nil;
}

@end
