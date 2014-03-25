//
//  FilterOptions.m
//  Yelp
//
//  Created by Stepan Grigoryan on 3/25/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "FilterOptions.h"
@interface FilterOptions()
@property (nonatomic, strong) NSDictionary *allCategories;
@end

@implementation FilterOptions

- (id)init
{
    self = [super init];
    self.allCategories = @{@"Active Life": @"active", @"Arts & Entertainment" : @"arts", @"Automotive" : @"auto", @"Beauty & Spas" : @"beautysvc", @"Education" : @"education", @"Event Planning & Services" : @"eventservices", @"Financial Services" : @"financialservices", @"Food" : @"food", @"Health & Medical" : @"health", @"Home Services" : @"homeservices", @"Hotels & Travel" : @"hotelstravel", @"Local Services" : @"localservices", @"Nightlife" : @"nightlife", @"Pets" : @"pets", @"Professional Services" : @"professional", @"Public Services & Government" : @"publicservicesgovt", @"Real Estate" : @"realestate", @"Restaurants" : @"restaurants", @"Shopping" : @"shopping"};
    self.allOptions = @[@{@"header": @"Radius", @"rows": @[@"Auto", @"2 blocks", @"4 blocks", @"8 blocks", @"1 mile", @"2 miles"]},
                        @{@"header": @"Sort By", @"rows": @[@"Best Matched", @"Distance", @"Highest Rated"]},
                        @{@"header": @"Categories", @"rows":[self.allCategories allKeys]},
                        @{@"header": @"Deals", @"rows": @[@"Offers Deal"]},                        ];
    self.radiusIndex = 0;
    self.sortTypeIndex = 0;
    self.categories = [[NSMutableArray alloc] init];
    return self;
}
- (NSDictionary *)parameters{
    NSMutableDictionary *parameters = [@{@"location" : @"San Francisco"} mutableCopy];
    if (self.searchTerm) {
        parameters[@"term"] = self.searchTerm;
    }

    
//    parameters[@"sort"] = [self.sortType];
    
    return [parameters copy];
}
@end
