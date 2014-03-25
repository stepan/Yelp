//
//  FilterOptions.h
//  Yelp
//
//  Created by Stepan Grigoryan on 3/25/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterOptions : NSObject
@property (nonatomic, strong) NSString *searchTerm;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, assign) NSString *sortType;
@property (nonatomic, strong) NSNumber *radius;
@property (nonatomic, assign) BOOL dealOnly;
@property (nonatomic, strong) NSArray *allOptions;
- (NSDictionary *)parameters;
@end
