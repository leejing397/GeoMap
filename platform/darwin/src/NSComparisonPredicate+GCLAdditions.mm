#import "NSComparisonPredicate+GCLAdditions.h"

#import "NSPredicate+GCLAdditions.h"
#import "NSExpression+GCLAdditions.h"

@implementation NSComparisonPredicate (GCLAdditions)

- (mbgl::style::Filter)gcl_filter {
    NSExpression *leftExpression = self.leftExpression;
    NSExpression *rightExpression = self.rightExpression;
    NSExpressionType leftType = leftExpression.expressionType;
    NSExpressionType rightType = rightExpression.expressionType;
    BOOL isReversed = ((leftType == NSConstantValueExpressionType || leftType == NSAggregateExpressionType)
                       && rightType == NSKeyPathExpressionType);
    switch (self.predicateOperatorType) {
        case NSEqualToPredicateOperatorType: {
            mbgl::style::EqualsFilter eqFilter;
            eqFilter.key = self.mgl_keyPath.UTF8String;
            eqFilter.value = self.mgl_constantValue;
            
            // Convert $type == to TypeEqualsFilter.
            if (eqFilter.key == "$type") {
                mbgl::style::TypeEqualsFilter typeEqFilter;
                typeEqFilter.value = self.mgl_featureType;
                return typeEqFilter;
            }
            
            // Convert $id == to IdentifierEqualsFilter.
            if (eqFilter.key == "$id") {
                // Convert $id == nil to NotHasIdentifierFilter.
                if (eqFilter.value.is<mbgl::NullValue>()) {
                    return mbgl::style::NotHasIdentifierFilter();
                }
                
                mbgl::style::IdentifierEqualsFilter idEqFilter;
                idEqFilter.value = self.mgl_featureIdentifier;
                return idEqFilter;
            }

            // Convert == nil to NotHasFilter.
            if (eqFilter.value.is<mbgl::NullValue>()) {
                mbgl::style::NotHasFilter notHasFilter;
                notHasFilter.key = eqFilter.key;
                return notHasFilter;
            }

            return eqFilter;
        }
        case NSNotEqualToPredicateOperatorType: {
            mbgl::style::NotEqualsFilter neFilter;
            neFilter.key = self.mgl_keyPath.UTF8String;
            neFilter.value = self.mgl_constantValue;
            
            // Convert $type != to TypeNotEqualsFilter.
            if (neFilter.key == "$type") {
                mbgl::style::TypeNotEqualsFilter typeNeFilter;
                typeNeFilter.value = self.mgl_featureType;
                return typeNeFilter;
            }
            
            // Convert $id != to IdentifierNotEqualsFilter.
            if (neFilter.key == "$id") {
                // Convert $id != nil to HasIdentifierFilter.
                if (neFilter.value.is<mbgl::NullValue>()) {
                    return mbgl::style::HasIdentifierFilter();
                }
                
                mbgl::style::IdentifierNotEqualsFilter idNeFilter;
                idNeFilter.value = self.mgl_featureIdentifier;
                return idNeFilter;
            }

            // Convert != nil to HasFilter.
            if (neFilter.value.is<mbgl::NullValue>()) {
                mbgl::style::HasFilter hasFilter;
                hasFilter.key = neFilter.key;
                return hasFilter;
            }

            return neFilter;
        }
        case NSGreaterThanPredicateOperatorType: {
            if (isReversed) {
                mbgl::style::LessThanFilter ltFilter;
                ltFilter.key = self.mgl_keyPath.UTF8String;
                ltFilter.value = self.mgl_constantValue;
                return ltFilter;
            } else {
                mbgl::style::GreaterThanFilter gtFilter;
                gtFilter.key = self.mgl_keyPath.UTF8String;
                gtFilter.value = self.mgl_constantValue;
                return gtFilter;
            }
        }
        case NSGreaterThanOrEqualToPredicateOperatorType: {
            if (isReversed) {
                mbgl::style::LessThanEqualsFilter lteFilter;
                lteFilter.key = self.mgl_keyPath.UTF8String;
                lteFilter.value = self.mgl_constantValue;
                return lteFilter;
            } else {
                mbgl::style::GreaterThanEqualsFilter gteFilter;
                gteFilter.key = self.mgl_keyPath.UTF8String;
                gteFilter.value = self.mgl_constantValue;
                return gteFilter;
            }
        }
        case NSLessThanPredicateOperatorType: {
            if (isReversed) {
                mbgl::style::GreaterThanFilter gtFilter;
                gtFilter.key = self.mgl_keyPath.UTF8String;
                gtFilter.value = self.mgl_constantValue;
                return gtFilter;
            } else {
                mbgl::style::LessThanFilter ltFilter;
                ltFilter.key = self.mgl_keyPath.UTF8String;
                ltFilter.value = self.mgl_constantValue;
                return ltFilter;
            }
        }
        case NSLessThanOrEqualToPredicateOperatorType: {
            if (isReversed) {
                mbgl::style::GreaterThanEqualsFilter gteFilter;
                gteFilter.key = self.mgl_keyPath.UTF8String;
                gteFilter.value = self.mgl_constantValue;
                return gteFilter;
            } else {
                mbgl::style::LessThanEqualsFilter lteFilter;
                lteFilter.key = self.mgl_keyPath.UTF8String;
                lteFilter.value = self.mgl_constantValue;
                return lteFilter;
            }
        }
        case NSInPredicateOperatorType: {
            if (isReversed) {
                if (leftType == NSConstantValueExpressionType && [leftExpression.constantValue isKindOfClass:[NSString class]]) {
                    [NSException raise:NSInvalidArgumentException
                                format:@"CONTAINS not supported for string comparison."];
                }
                [NSException raise:NSInvalidArgumentException
                            format:@"Predicate cannot compare values IN attribute."];
            }
            
            // Convert $type IN to TypeInFilter.
            if ([leftExpression.keyPath isEqualToString:@"$type"]) {
                mbgl::style::TypeInFilter typeInFilter;
                typeInFilter.values = rightExpression.gcl_aggregateFeatureType;
                return typeInFilter;
            }
            
            // Convert $id IN to IdentifierInFilter.
            if ([leftExpression.keyPath isEqualToString:@"$id"]) {
                mbgl::style::IdentifierInFilter idInFilter;
                idInFilter.values = rightExpression.gcl_aggregateFeatureIdentifier;
                return idInFilter;
            }
            
            mbgl::style::InFilter inFilter;
            inFilter.key = leftExpression.keyPath.UTF8String;
            inFilter.values = rightExpression.gcl_aggregateMBGLValue;
            return inFilter;
        }
        case NSContainsPredicateOperatorType: {
            if (!isReversed) {
                if (rightType == NSConstantValueExpressionType && [rightExpression.constantValue isKindOfClass:[NSString class]]) {
                    [NSException raise:NSInvalidArgumentException
                                format:@"IN not supported for string comparison."];
                }
                [NSException raise:NSInvalidArgumentException
                            format:@"Predicate cannot compare attribute CONTAINS values."];
            }
            
            // Convert CONTAINS $type to TypeInFilter.
            if ([rightExpression.keyPath isEqualToString:@"$type"]) {
                mbgl::style::TypeInFilter typeInFilter;
                typeInFilter.values = leftExpression.gcl_aggregateFeatureType;
                return typeInFilter;
            }
            
            // Convert CONTAINS $id to IdentifierInFilter.
            if ([rightExpression.keyPath isEqualToString:@"$id"]) {
                mbgl::style::IdentifierInFilter idInFilter;
                idInFilter.values = leftExpression.gcl_aggregateFeatureIdentifier;
                return idInFilter;
            }
            
            mbgl::style::InFilter inFilter;
            inFilter.key = rightExpression.keyPath.UTF8String;
            inFilter.values = leftExpression.gcl_aggregateMBGLValue;
            return inFilter;
        }
        case NSBetweenPredicateOperatorType: {
            if (isReversed) {
                [NSException raise:NSInvalidArgumentException
                            format:@"Predicate cannot compare bounds BETWEEN attribute."];
            }
            if (![rightExpression.constantValue isKindOfClass:[NSArray class]]) {
                [NSException raise:NSInvalidArgumentException
                            format:@"Right side of BETWEEN predicate must be an array."]; // not NSSet
            }
            auto values = rightExpression.gcl_aggregateMBGLValue;
            if (values.size() != 2) {
                [NSException raise:NSInvalidArgumentException
                            format:@"Right side of BETWEEN predicate must have two items."];
            }
            mbgl::style::AllFilter allFilter;
            mbgl::style::GreaterThanEqualsFilter gteFilter;
            gteFilter.key = leftExpression.keyPath.UTF8String;
            gteFilter.value = values[0];
            allFilter.filters.push_back(gteFilter);
            mbgl::style::LessThanEqualsFilter lteFilter;
            lteFilter.key = leftExpression.keyPath.UTF8String;
            lteFilter.value = values[1];
            allFilter.filters.push_back(lteFilter);
            return allFilter;
        }
        case NSMatchesPredicateOperatorType:
        case NSLikePredicateOperatorType:
        case NSBeginsWithPredicateOperatorType:
        case NSEndsWithPredicateOperatorType:
        case NSCustomSelectorPredicateOperatorType:
            [NSException raise:NSInvalidArgumentException
                        format:@"NSPredicateOperatorType:%lu is not supported.", (unsigned long)self.predicateOperatorType];
    }

    return {};
}

- (NSString *)mgl_keyPath {
    NSExpression *leftExpression = self.leftExpression;
    NSExpression *rightExpression = self.rightExpression;
    NSExpressionType leftType = leftExpression.expressionType;
    NSExpressionType rightType = rightExpression.expressionType;
    if (leftType == NSKeyPathExpressionType && rightType == NSConstantValueExpressionType) {
        return leftExpression.keyPath;
    } else if (leftType == NSConstantValueExpressionType && rightType == NSKeyPathExpressionType) {
        return rightExpression.keyPath;
    }

    [NSException raise:NSInvalidArgumentException
                format:@"Comparison predicate must compare an attribute (as a key path) to a constant or vice versa."];
    return nil;
}

- (mbgl::Value)mgl_constantValue {
    NSExpression *leftExpression = self.leftExpression;
    NSExpression *rightExpression = self.rightExpression;
    NSExpressionType leftType = leftExpression.expressionType;
    NSExpressionType rightType = rightExpression.expressionType;
    mbgl::Value value;
    if (leftType == NSKeyPathExpressionType && rightType == NSConstantValueExpressionType) {
        value = rightExpression.gcl_constantMBGLValue;
    } else if (leftType == NSConstantValueExpressionType && rightType == NSKeyPathExpressionType) {
        value = leftExpression.gcl_constantMBGLValue;
    } else {
        [NSException raise:NSInvalidArgumentException
                    format:@"Comparison predicate must compare an attribute (as a key path) to a constant or vice versa."];
    }
    return value;
}

- (mbgl::FeatureType)mgl_featureType {
    NSExpression *leftExpression = self.leftExpression;
    NSExpression *rightExpression = self.rightExpression;
    NSExpressionType leftType = leftExpression.expressionType;
    NSExpressionType rightType = rightExpression.expressionType;
    mbgl::FeatureType type;
    if (leftType == NSKeyPathExpressionType && rightType == NSConstantValueExpressionType) {
        type = rightExpression.gcl_featureType;
    } else if (leftType == NSConstantValueExpressionType && rightType == NSKeyPathExpressionType) {
        type = leftExpression.gcl_featureType;
    } else {
        [NSException raise:NSInvalidArgumentException
                    format:@"Comparison predicate must compare an attribute (as a key path) to a constant or vice versa."];
    }
    return type;
}

- (mbgl::FeatureIdentifier)mgl_featureIdentifier {
    NSExpression *leftExpression = self.leftExpression;
    NSExpression *rightExpression = self.rightExpression;
    NSExpressionType leftType = leftExpression.expressionType;
    NSExpressionType rightType = rightExpression.expressionType;
    mbgl::FeatureIdentifier identifier;
    if (leftType == NSKeyPathExpressionType && rightType == NSConstantValueExpressionType) {
        identifier = rightExpression.gcl_featureIdentifier;
    } else if (leftType == NSConstantValueExpressionType && rightType == NSKeyPathExpressionType) {
        identifier = leftExpression.gcl_featureIdentifier;
    } else {
        [NSException raise:NSInvalidArgumentException
                    format:@"Comparison predicate must compare an attribute (as a key path) to a constant or vice versa."];
    }
    return identifier;
}

@end
