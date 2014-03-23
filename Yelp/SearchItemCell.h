//
//  SearchItemCell.h
//  Yelp
//
//  Created by Stepan Grigoryan on 3/20/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchItem.h"

@interface SearchItemCell : UITableViewCell
@property (nonatomic, strong) SearchItem *searchItem;
+ (NSString *)cellIdentifier;
- (void)setTitle:(NSString *)s;
- (UILabel *)placeTitle;
@end
