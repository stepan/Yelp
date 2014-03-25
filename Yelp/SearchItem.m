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
    id items = object[@"businesses"];
    for(NSDictionary *dictionary in items)
    {
        NSUInteger index = [items indexOfObject:dictionary];
        SearchItem *searchItem = [[SearchItem alloc] initWithDictionary:dictionary index:index];
        [searchItems addObject:searchItem];
    }
    return [searchItems copy];
}
- (id)initWithDictionary:(NSDictionary *)dictionary index:(NSUInteger)index
{
    self = [super init];
    if (self) {
        self.index = index + 1;
        self.dictionary = dictionary;
        self.name = [NSString stringWithFormat:@"%lu. %@", (unsigned long)self.index, self.dictionary[@"name"]];
        self.numberOfReviews = [NSString stringWithFormat:@"%@ Reviews", self.dictionary[@"review_count"]];
        self.address = [NSString stringWithFormat:@"%@, %@", self.dictionary[@"location"][@"display_address"][0], self.dictionary[@"location"][@"display_address"][1]]; ;
        self.categories = [NSString stringWithFormat:@"%@", self.dictionary[@"categories"]];
        NSString *imageUrl;
        if (self.dictionary[@"image_url"]) {
            imageUrl = self.dictionary[@"image_url"];
        } else{ // sometimes the api doesn't return an image so use yelp's logo
         imageUrl = @"http://thaigreenvillage.com/wp-content/uploads/2013/09/yelp-ios-app-icon1.png";
        }
        self.imageUrl = [[NSURL alloc] initWithString:imageUrl];
        
        self.ratingsUrl = [[NSURL alloc] initWithString:self.dictionary[@"rating_img_url_large"]];
        
        NSMutableArray *a = [[NSMutableArray alloc] init];
        for(NSArray *n in self.dictionary[@"categories"]){
            [a addObject:n[0]];
        }
        self.categories = [a componentsJoinedByString:@", "];
    }
    return self;
}
- (CGFloat)extraHeight:(CGFloat)f
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], NSFontAttributeName,
                                [NSParagraphStyle defaultParagraphStyle], NSParagraphStyleAttributeName,
                                nil];
    CGRect r = [self.name boundingRectWithSize:CGSizeMake(137, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return r.size.height - f;
}


@end
