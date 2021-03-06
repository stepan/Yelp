//
//  FilterViewController.h
//  Yelp
//
//  Created by Stepan Grigoryan on 3/24/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterOptions.h"

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) FilterOptions *filterOptions;
@end
