//
//  SearchItem.m
//  Yelp
//
//  Created by Stepan Grigoryan on 3/20/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "SearchItem.h"

@implementation SearchItem
+ (NSArray *)searchItemsWithObject:(id)object
{
    NSMutableArray *searchItems = [[NSMutableArray alloc] init];
    for(NSDictionary *dictionary in object[@"businesses"])
    {
        SearchItem *searchItem = [[SearchItem alloc] initWithDictionary:dictionary];
        [searchItems addObject:searchItem];
    }
    return [searchItems copy];
}
- (id) initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
        //NSLog(@"%@", self.dictionary[@"categories"]);
        self.name = self.dictionary[@"name"];
        self.numberOfReviews = [NSString stringWithFormat:@"%@ Reviews", self.dictionary[@"review_count"]];
        self.distance = @"1.4 miles";
        self.priceRange = @"$$$$";
        self.address = self.dictionary[@"location"][@"address"][0];
        self.categories = [NSString stringWithFormat:@"%@", self.dictionary[@"categories"]];
        self.categories = @"adsf";
        self.imageUrl = [[NSURL alloc] initWithString:self.dictionary[@"image_url"]];
        self.ratingsUrl = [[NSURL alloc] initWithString:self.dictionary[@"rating_img_url_small"]];
    }
    return self;
}

@end
