#import <GeoMap/Geocompass.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCLVectorSource (GCLAdditions)

+ (NSString *)preferredMapboxStreetsLanguage;

- (NS_DICTIONARY_OF(NSString *, NSString *) *)localizedKeysByKeyForPreferredLanguage:(nullable NSString *)preferredLanguage;

@property (nonatomic, readonly, getter=isMapboxStreets) BOOL mapboxStreets;

@end

NS_ASSUME_NONNULL_END
