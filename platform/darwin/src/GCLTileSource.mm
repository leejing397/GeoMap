#import "GCLTileSource_Private.h"

#import "GCLAttributionInfo_Private.h"
#import "NSString+GCLAdditions.h"

#if TARGET_OS_IPHONE
    #import <UIKit/UIKit.h>
#else
    #import <Cocoa/Cocoa.h>
#endif

#include <mbgl/util/tileset.hpp>

const GCLTileSourceOption GCLTileSourceOptionMinimumZoomLevel = @"GCLTileSourceOptionMinimumZoomLevel";
const GCLTileSourceOption GCLTileSourceOptionMaximumZoomLevel = @"GCLTileSourceOptionMaximumZoomLevel";
const GCLTileSourceOption GCLTileSourceOptionAttributionHTMLString = @"GCLTileSourceOptionAttributionHTMLString";
const GCLTileSourceOption GCLTileSourceOptionAttributionInfos = @"GCLTileSourceOptionAttributionInfos";
const GCLTileSourceOption GCLTileSourceOptionTileCoordinateSystem = @"GCLTileSourceOptionTileCoordinateSystem";

@implementation GCLTileSource

- (NSURL *)configurationURL {
    [NSException raise:@"GCLAbstractClassException"
                format:@"GCLTileSource is an abstract class"];
    return nil;
}

- (NS_ARRAY_OF(GCLAttributionInfo *) *)attributionInfos {
    return [self attributionInfosWithFontSize:0 linkColor:nil];
}

- (NS_ARRAY_OF(GCLAttributionInfo *) *)attributionInfosWithFontSize:(CGFloat)fontSize linkColor:(nullable GCLColor *)linkColor {
    return [GCLAttributionInfo attributionInfosFromHTMLString:self.attributionHTMLString
                                                     fontSize:fontSize
                                                    linkColor:linkColor];
}

- (NSString *)attributionHTMLString {
    [NSException raise:@"GCLAbstractClassException"
                format:@"GCLTileSource is an abstract class"];
    return nil;
}

@end

mbgl::Tileset GCLTileSetFromTileURLTemplates(NS_ARRAY_OF(NSString *) *tileURLTemplates, NS_DICTIONARY_OF(GCLTileSourceOption, id) * _Nullable options) {
    mbgl::Tileset tileSet;

    for (NSString *tileURLTemplate in tileURLTemplates) {
        tileSet.tiles.push_back(tileURLTemplate.UTF8String);
    }

    // set the minimum / maximum zoom range to the values specified by this class if they
    // were set. otherwise, use the core objects default values
    if (NSNumber *minimumZoomLevel = options[GCLTileSourceOptionMinimumZoomLevel]) {
        if (![minimumZoomLevel isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"GCLTileSourceOptionMinimumZoomLevel must be set to an NSNumber."];
        }
        tileSet.zoomRange.min = minimumZoomLevel.integerValue;
    }
    if (NSNumber *maximumZoomLevel = options[GCLTileSourceOptionMaximumZoomLevel]) {
        if (![maximumZoomLevel isKindOfClass:[NSNumber class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"GCLTileSourceOptionMinimumZoomLevel must be set to an NSNumber."];
        }
        tileSet.zoomRange.max = maximumZoomLevel.integerValue;
    }
    if (tileSet.zoomRange.min > tileSet.zoomRange.max) {
        [NSException raise:NSInvalidArgumentException
                    format:@"GCLTileSourceOptionMinimumZoomLevel must be less than GCLTileSourceOptionMaximumZoomLevel."];
    }

    if (NSString *attribution = options[GCLTileSourceOptionAttributionHTMLString]) {
        if (![attribution isKindOfClass:[NSString class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"GCLTileSourceOptionAttributionHTMLString must be set to a string."];
        }
        tileSet.attribution = attribution.UTF8String;
    }

    if (NSArray *attributionInfos = options[GCLTileSourceOptionAttributionInfos]) {
        if (![attributionInfos isKindOfClass:[NSArray class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"GCLTileSourceOptionAttributionInfos must be set to a string."];
        }

        NSAttributedString *attributedString = [GCLAttributionInfo attributedStringForAttributionInfos:attributionInfos];
#if TARGET_OS_IPHONE
        static NSString * const NSExcludedElementsDocumentAttribute = @"ExcludedElements";
#endif
        NSDictionary *documentAttributes = @{
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding),
            // The attribution string is meant to be a simple, inline fragment, not a full-fledged, validating document.
            NSExcludedElementsDocumentAttribute: @[@"XML", @"DOCTYPE", @"html", @"head", @"meta", @"title", @"style", @"body", @"p"],
        };
        NSData *data = [attributedString dataFromRange:attributedString.mgl_wholeRange documentAttributes:documentAttributes error:NULL];
        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        tileSet.attribution = html.UTF8String;
    }

    if (NSNumber *tileCoordinateSystemNumber = options[GCLTileSourceOptionTileCoordinateSystem]) {
        if (![tileCoordinateSystemNumber isKindOfClass:[NSValue class]]) {
            [NSException raise:NSInvalidArgumentException
                        format:@"GCLTileSourceOptionTileCoordinateSystem must be set to an NSValue or NSNumber."];
        }
        GCLTileCoordinateSystem tileCoordinateSystem;
        [tileCoordinateSystemNumber getValue:&tileCoordinateSystem];
        switch (tileCoordinateSystem) {
            case GCLTileCoordinateSystemXYZ:
                tileSet.scheme = mbgl::Tileset::Scheme::XYZ;
                break;
            case GCLTileCoordinateSystemTMS:
                tileSet.scheme = mbgl::Tileset::Scheme::TMS;
                break;
        }
    }

    return tileSet;
}
