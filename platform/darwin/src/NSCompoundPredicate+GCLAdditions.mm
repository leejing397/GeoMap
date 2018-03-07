#import "NSCompoundPredicate+GCLAdditions.h"

#import "NSPredicate+GCLAdditions.h"
#import "NSExpression+GCLAdditions.h"

@implementation NSCompoundPredicate (GCLAdditions)

- (std::vector<mbgl::style::Filter>)mgl_subfilters
{
    std::vector<mbgl::style::Filter>filters;
    for (NSPredicate *predicate in self.subpredicates) {
        filters.push_back(predicate.gcl_filter);
    }
    return filters;
}

- (mbgl::style::Filter)gcl_filter
{
    switch (self.compoundPredicateType) {
        case NSNotPredicateType: {
            NSAssert(self.subpredicates.count <= 1, @"NOT predicate cannot have multiple subpredicates.");
            NSPredicate *subpredicate = self.subpredicates.firstObject;
            mbgl::style::Filter subfilter = subpredicate.gcl_filter;

            // Convert NOT(!= nil) to NotHasFilter.
            if (subfilter.is<mbgl::style::HasFilter>()) {
                auto hasFilter = subfilter.get<mbgl::style::HasFilter>();
                return mbgl::style::NotHasFilter { .key = hasFilter.key };
            }

            // Convert NOT(== nil) to HasFilter.
            if (subfilter.is<mbgl::style::NotHasFilter>()) {
                auto hasFilter = subfilter.get<mbgl::style::NotHasFilter>();
                return mbgl::style::HasFilter { .key = hasFilter.key };
            }

            // Convert NOT(IN) or NOT(CONTAINS) to NotInFilter.
            if (subfilter.is<mbgl::style::InFilter>()) {
                auto inFilter = subfilter.get<mbgl::style::InFilter>();
                mbgl::style::NotInFilter notInFilter;
                notInFilter.key = inFilter.key;
                notInFilter.values = inFilter.values;
                return notInFilter;
            }

            // Convert NOT(), NOT(AND), NOT(NOT), NOT(==), etc. into NoneFilter.
            mbgl::style::NoneFilter noneFilter;
            if (subfilter.is<mbgl::style::AnyFilter>()) {
                // Flatten NOT(OR).
                noneFilter.filters = subfilter.get<mbgl::style::AnyFilter>().filters;
            } else if (subpredicate) {
                noneFilter.filters = { subfilter };
            }
            return noneFilter;
        }
        case NSAndPredicateType: {
            mbgl::style::AllFilter filter;
            filter.filters = self.mgl_subfilters;
            return filter;
        }
        case NSOrPredicateType: {
            mbgl::style::AnyFilter filter;
            filter.filters = self.mgl_subfilters;
            return filter;
        }
    }

    [NSException raise:@"Compound predicate type not handled"
                format:@""];
    return {};
}

@end
