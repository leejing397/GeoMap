#import "GCLAnnotationImage.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GCLAnnotationImageDelegate <NSObject>

@required
- (void)annotationImageNeedsRedisplay:(GCLAnnotationImage *)annotationImage;

@end

@interface GCLAnnotationImage (Private)

/// Unique identifier of the sprite image used by the style to represent the receiver’s `image`.
@property (nonatomic, strong, nullable) NSString *styleIconIdentifier;

@property (nonatomic, weak) id<GCLAnnotationImageDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
