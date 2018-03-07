#import "GCLImageSource.h"

#import "GCLGeometry_Private.h"
#import "GCLSource_Private.h"
#import "GCLTileSource_Private.h"
#import "NSURL+GCLAdditions.h"
#if TARGET_OS_IPHONE
    #import "UIImage+GCLAdditions.h"
#else
    #import "NSImage+GCLAdditions.h"
#endif

#include <mbgl/style/sources/image_source.hpp>
#include <mbgl/util/premultiply.hpp>

@interface GCLImageSource ()
- (instancetype)initWithIdentifier:(NSString *)identifier coordinateQuad:(GCLCoordinateQuad)coordinateQuad NS_DESIGNATED_INITIALIZER;

@property (nonatomic, readonly) mbgl::style::ImageSource *rawSource;

@end

@implementation GCLImageSource

- (instancetype)initWithIdentifier:(NSString *)identifier coordinateQuad:(GCLCoordinateQuad)coordinateQuad {

    const auto coordsArray = GCLLatLngArrayFromCoordinateQuad(coordinateQuad);
    auto source = std::make_unique<mbgl::style::ImageSource>(identifier.UTF8String, coordsArray);
    return self = [super initWithPendingSource:std::move(source)];
}


- (instancetype)initWithIdentifier:(NSString *)identifier coordinateQuad:(GCLCoordinateQuad)coordinateQuad URL:(NSURL *)url {
    self =  [self initWithIdentifier:identifier coordinateQuad: coordinateQuad];
    self.URL = url;
    return self;
}


- (instancetype)initWithIdentifier:(NSString *)identifier coordinateQuad:(GCLCoordinateQuad)coordinateQuad image:(GCLImage *)image {
    self =  [self initWithIdentifier:identifier coordinateQuad: coordinateQuad];
    self.image = image;

    return self;
}

- (NSURL *)URL {
    auto url = self.rawSource->getURL();
    return url ? [NSURL URLWithString:@(url->c_str())] : nil;
}

- (void)setURL:(NSURL *)url {
    if (url) {
        self.rawSource->setURL(url.gcl_URLByStandardizingScheme.absoluteString.UTF8String);
        _image = nil;
    } else {
        self.image = nullptr;
    }
}

- (void)setImage:(GCLImage *)image {
    if (image != nullptr) {
        self.rawSource->setImage(image.mgl_premultipliedImage);
    } else {
        self.rawSource->setImage(mbgl::PremultipliedImage({0,0}));
    }
    _image = image;
}

- (GCLCoordinateQuad)coordinates {
    return GCLCoordinateQuadFromLatLngArray(self.rawSource->getCoordinates());
}

- (void)setCoordinates: (GCLCoordinateQuad)coordinateQuad {
    self.rawSource->setCoordinates(GCLLatLngArrayFromCoordinateQuad(coordinateQuad));
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@; coordinates = %@; URL = %@; image = %@>",
            NSStringFromClass([self class]), (void *)self, self.identifier, GCLStringFromCoordinateQuad(self.coordinates), self.URL, self.image];
}

- (mbgl::style::ImageSource *)rawSource {
    return (mbgl::style::ImageSource *)super.rawSource;
}

- (NSString *)attributionHTMLString {
    auto attribution = self.rawSource->getAttribution();
    return attribution ? @(attribution->c_str()) : nil;
}

@end
