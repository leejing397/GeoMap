#import "SMCalloutView.h"
#import "GCLCalloutView.h"

/**
 A concrete implementation of `GCLCalloutView` based on
 <a href="https://github.com/nfarina/calloutview">SMCalloutView</a>. This
 callout view displays the represented annotation’s title, subtitle, and
 accessory views in a compact, two-line layout.
 */
@interface GCLCompactCalloutView : SMCalloutView <GCLCalloutView>

+ (instancetype)platformCalloutView;

@end
