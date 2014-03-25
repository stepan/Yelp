//
//  FilterViewController.m
//  Yelp
//
//  Created by Stepan Grigoryan on 3/24/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Filters";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(onCancelButtonClick)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleDone target:self action:@selector(onSearchButtonClick)];
    self.navigationItem.rightBarButtonItem = searchButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onSearchButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
