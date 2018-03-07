#import "GCLSource_Private.h"
#import "GCLStyle_Private.h"
#import "GCLMapView_Private.h"

#include <mbgl/style/style.hpp>
#include <mbgl/map/map.hpp>
#include <mbgl/style/source.hpp>

@interface GCLSource ()

// Even though this class is abstract, GCLStyle uses it to represent some
// special internal source types like mbgl::AnnotationSource.
@property (nonatomic, readonly) mbgl::style::Source *rawSource;

@property (nonatomic, readonly, weak) GCLMapView *mapView;

@end

@implementation GCLSource {
    std::unique_ptr<mbgl::style::Source> _pendingSource;
}


- (instancetype)initWithIdentifier:(NSString *)identifier
{
    if (self = [super init]) {
        _identifier = identifier;
    }
    return self;
}

- (instancetype)initWithRawSource:(mbgl::style::Source *)rawSource mapView:(GCLMapView *)mapView {
    NSString *identifier = @(rawSource->getID().c_str());
    if (self = [self initWithIdentifier:identifier]) {
        _rawSource = rawSource;
        _rawSource->peer = SourceWrapper { self };
        _mapView = mapView;
    }
    return self;
}

- (instancetype)initWithPendingSource:(std::unique_ptr<mbgl::style::Source>)pendingSource {
    if (self = [self initWithRawSource:pendingSource.get() mapView:nil]) {
        _pendingSource = std::move(pendingSource);
    }
    return self;
}

- (void)addToMapView:(GCLMapView *)mapView {
    if (_pendingSource == nullptr) {
        [NSException raise:@"GCLRedundantSourceException"
                    format:@"This instance %@ was already added to %@. Adding the same source instance " \
         "to the style more than once is invalid.", self, mapView.style];
    }
    
    _mapView = mapView;
    _mapView.style.rawStyle->addSource(std::move(_pendingSource));
}

- (void)removeFromMapView:(GCLMapView *)mapView {
    if (self.rawSource == mapView.style.rawStyle->getSource(self.identifier.UTF8String)) {
        _pendingSource = mapView.style.rawStyle->removeSource(self.identifier.UTF8String);
        _mapView = nil;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@>",
            NSStringFromClass([self class]), (void *)self, self.identifier];
}

@end
