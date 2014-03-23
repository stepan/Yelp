//
//  SearchItemCell.m
//  Yelp
//
//  Created by Stepan Grigoryan on 3/20/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//
#import "UIImageView+AFNetworking.h"
#import "SearchItemCell.h"

@interface SearchItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemNumberOfReviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceRangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemCategoriesLabel;

@end

@implementation SearchItemCell

+ (NSString *)cellIdentifier
{
    return @"SearchItemCell";
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSearchItem:(SearchItem *)searchItem
{
    _searchItem = searchItem;
    self.itemNameLabel.text = @"Very very l";
    NSURL *url = [[NSURL alloc] initWithString:@"http://s3-media2.ak.yelpcdn.com/bphoto/7DIHu8a0AHhw-BffrDIxPA/ms.jpg"];
    [self.itemImage setImageWithURL:url];
//    NSUInteger r = arc4random_uniform(16);
}

- (void)setTitle:(NSString *)s
{
    self.itemNameLabel.text = s;
}

- (UILabel *)placeTitle
{
    return self.itemNameLabel;
}
@end
