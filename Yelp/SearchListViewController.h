//
//  SearchListViewController.h
//  Yelp
//
//  Created by Stepan Grigoryan on 3/20/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterOptions.h"

@interface SearchListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (nonatomic, strong) FilterOptions *filterOptions;
@end
