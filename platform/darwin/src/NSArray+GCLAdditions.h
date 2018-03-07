#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import <mbgl/util/feature.hpp>

@interface NSArray (GCLAdditions)

- (std::vector<mbgl::Value>)gcl_vector;

/** Returns a string resulting from inserting a separator between each attributed string in the array */
- (NSAttributedString *)gcl_attributedComponentsJoinedByString:(NSString *)separator;

/**
 Converts std::vector<CLLocationCoordinate> into an NSArray containing dictionary
 representations of coordinates with the following structure:
 [{"latitude": lat, "longitude": lng}]
 */
+ (NSArray *)gcl_coordinatesFromCoordinates:(std::vector<CLLocationCoordinate2D>)coords;

/**
 Converts the receiver into a std::vector<CLLocationCoordinate>.
 Receiver must conform to the following structure:
 [{"latitude": lat, "longitude": lng}]
 */
- (std::vector<CLLocationCoordinate2D>)gcl_coordinates;

@end
