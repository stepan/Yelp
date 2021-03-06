//
//  SearchItem.h
//  Yelp
//
//  Created by Stepan Grigoryan on 3/20/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchItem.h"

@interface SearchItem : NSObject
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *numberOfReviews;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSURL *ratingsUrl;
@property (nonatomic, assign) NSUInteger index;
+ (NSArray *) searchItemsWithObject:(id)object;
- (id) initWithDictionary:(NSDictionary *)dictionary index:(NSUInteger)index;
- (CGFloat)heightDifference:(CGSize)size;
@end
