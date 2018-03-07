#import <Foundation/Foundation.h>

#include <mbgl/style/filter.hpp>

NS_ASSUME_NONNULL_BEGIN

@interface NSExpression (GCLAdditions)

@property (nonatomic, readonly) mbgl::Value gcl_constantMBGLValue;
@property (nonatomic, readonly) std::vector<mbgl::Value> gcl_aggregateMBGLValue;
@property (nonatomic, readonly) mbgl::FeatureType gcl_featureType;
@property (nonatomic, readonly) std::vector<mbgl::FeatureType> gcl_aggregateFeatureType;
@property (nonatomic, readonly) mbgl::FeatureIdentifier gcl_featureIdentifier;
@property (nonatomic, readonly) std::vector<mbgl::FeatureIdentifier> gcl_aggregateFeatureIdentifier;

@end

NS_ASSUME_NONNULL_END
