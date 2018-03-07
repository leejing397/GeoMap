#import <UIKit/UIKit.h>

#import "GCLFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GCLFeature;

/// Unique identifier representing a single annotation in mbgl.
typedef uint32_t GCLAnnotationTag;

/** An accessibility element representing something that appears on the map. */
GCL_EXPORT
@interface GCLMapAccessibilityElement : UIAccessibilityElement

@end

/** An accessibility element representing a map annotation. */
@interface GCLAnnotationAccessibilityElement : GCLMapAccessibilityElement

/** The tag of the annotation represented by this element. */
@property (nonatomic) GCLAnnotationTag tag;

- (instancetype)initWithAccessibilityContainer:(id)container tag:(GCLAnnotationTag)identifier NS_DESIGNATED_INITIALIZER;

@end

/** An accessibility element representing a map feature. */
GCL_EXPORT
@interface GCLFeatureAccessibilityElement : GCLMapAccessibilityElement

/** The feature represented by this element. */
@property (nonatomic, strong) id <GCLFeature> feature;

- (instancetype)initWithAccessibilityContainer:(id)container feature:(id <GCLFeature>)feature NS_DESIGNATED_INITIALIZER;

@end

/** An accessibility element representing a place feature. */
GCL_EXPORT
@interface GCLPlaceFeatureAccessibilityElement : GCLFeatureAccessibilityElement
@end

/** An accessibility element representing a road feature. */
GCL_EXPORT
@interface GCLRoadFeatureAccessibilityElement : GCLFeatureAccessibilityElement
@end

/** An accessibility element representing the MGLMapView at large. */
GCL_EXPORT
@interface GCLMapViewProxyAccessibilityElement : UIAccessibilityElement
@end

NS_ASSUME_NONNULL_END
