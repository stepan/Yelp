//
//  FilterOptions.m
//  Yelp
//
//  Created by Stepan Grigoryan on 3/25/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "FilterOptions.h"

@implementation FilterOptions
- (id)init
{
    self = [super init];
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
