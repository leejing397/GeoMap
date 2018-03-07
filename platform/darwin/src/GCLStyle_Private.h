#import "GCLStyle.h"

#import "GCLStyleLayer.h"
#import "GCLFillStyleLayer.h"

NS_ASSUME_NONNULL_BEGIN

namespace mbgl {
    namespace style {
        class Style;
    }
}

@class LAttributionInfo;
@class GCLMapView;
@class GCLOpenGLStyleLayer;
@class GCLVectorSource;
@class LVectorStyleLayer;

@interface GCLStyle (Private)

- (instancetype)initWithRawStyle:(mbgl::style::Style *)rawStyle mapView:(GCLMapView *)mapView;

@property (nonatomic, readonly, weak) GCLMapView *mapView;
@property (nonatomic, readonly) mbgl::style::Style *rawStyle;

- (nullable NS_ARRAY_OF(LAttributionInfo *) *)attributionInfosWithFontSize:(CGFloat)fontSize linkColor:(nullable GCLColor *)linkColor;

@property (nonatomic, readonly, strong) NS_MUTABLE_DICTIONARY_OF(NSString *, GCLOpenGLStyleLayer *) *openGLLayers;

- (void)setStyleClasses:(NS_ARRAY_OF(NSString *) *)appliedClasses transitionDuration:(NSTimeInterval)transitionDuration;

@end

@interface GCLStyle (MGLStreetsAdditions)

@property (nonatomic, readonly, copy) NS_ARRAY_OF(LVectorStyleLayer *) *placeStyleLayers;
@property (nonatomic, readonly, copy) NS_ARRAY_OF(LVectorStyleLayer *) *roadStyleLayers;

@end

NS_ASSUME_NONNULL_END
