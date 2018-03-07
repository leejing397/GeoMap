#import "GCLStyleLayer_Private.h"
#import "GCLStyle_Private.h"

#include <mbgl/style/style.hpp>
#include <mbgl/style/layer.hpp>

@interface GCLStyleLayer ()

@property (nonatomic, readonly) mbgl::style::Layer *rawLayer;

@end

@implementation GCLStyleLayer {
    std::unique_ptr<mbgl::style::Layer> _pendingLayer;
}

- (instancetype)initWithRawLayer:(mbgl::style::Layer *)rawLayer {
    if (self = [super init]) {
        _identifier = @(rawLayer->getID().c_str());
        _rawLayer = rawLayer;
        _rawLayer->peer = LayerWrapper { self };
    }
    return self;
}

- (instancetype)initWithPendingLayer:(std::unique_ptr<mbgl::style::Layer>)pendingLayer {
    if (self = [self initWithRawLayer:pendingLayer.get()]) {
        _pendingLayer = std::move(pendingLayer);
    }
    return self;
}

- (void)addToStyle:(GCLStyle *)style belowLayer:(GCLStyleLayer *)otherLayer
{
    if (_pendingLayer == nullptr) {
        [NSException raise:@"MGLRedundantLayerException"
            format:@"This instance %@ was already added to %@. Adding the same layer instance " \
                    "to the style more than once is invalid.", self, style];
    }

    if (otherLayer) {
        const mbgl::optional<std::string> belowLayerId{otherLayer.identifier.UTF8String};
        style.rawStyle->addLayer(std::move(_pendingLayer), belowLayerId);
    } else {
        style.rawStyle->addLayer(std::move(_pendingLayer));
    }
}

- (void)removeFromStyle:(GCLStyle *)style
{
    if (self.rawLayer == style.rawStyle->getLayer(self.identifier.UTF8String)) {
        _pendingLayer = style.rawStyle->removeLayer(self.identifier.UTF8String);
    }
}

- (void)setVisible:(BOOL)visible
{
    GCLAssertStyleLayerIsValid();

    mbgl::style::VisibilityType v = visible
    ? mbgl::style::VisibilityType::Visible
    : mbgl::style::VisibilityType::None;
    self.rawLayer->setVisibility(v);
}

- (BOOL)isVisible
{
    GCLAssertStyleLayerIsValid();

    mbgl::style::VisibilityType v = self.rawLayer->getVisibility();
    return (v == mbgl::style::VisibilityType::Visible);
}

- (void)setMaximumZoomLevel:(float)maximumZoomLevel
{
    GCLAssertStyleLayerIsValid();

    self.rawLayer->setMaxZoom(maximumZoomLevel);
}

- (float)maximumZoomLevel
{
    GCLAssertStyleLayerIsValid();

    return self.rawLayer->getMaxZoom();
}

- (void)setMinimumZoomLevel:(float)minimumZoomLevel
{
    GCLAssertStyleLayerIsValid();

    self.rawLayer->setMinZoom(minimumZoomLevel);
}

- (float)minimumZoomLevel
{
    GCLAssertStyleLayerIsValid();

    return self.rawLayer->getMinZoom();
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@; visible = %@>",
            NSStringFromClass([self class]), (void *)self, self.identifier,
            self.visible ? @"YES" : @"NO"];
}

@end
