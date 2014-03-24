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
@property (weak, nonatomic) IBOutlet UIImageView *itemRatingsImage;

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
    [self styleCell];
}

- (void)setTitle:(NSString *)s
{
    self.itemNameLabel.text = s;
}

- (UILabel *)placeTitle
{
    return self.itemNameLabel;
}

- (void)styleCell
{
    self.itemNameLabel.text = self.searchItem.name;
    self.itemDistanceLabel.text = self.searchItem.distance;
    self.itemNumberOfReviewsLabel.text = self.searchItem.numberOfReviews;
    self.itemPriceRangeLabel.text = self.searchItem.priceRange;
    self.itemAddressLabel.text = self.searchItem.address;
    self.itemCategoriesLabel.text = self.searchItem.categories;
    [self.itemImage setImageWithURL:self.searchItem.imageUrl];
    [self.itemRatingsImage setImageWithURL:self.searchItem.ratingsUrl];
}
@end
