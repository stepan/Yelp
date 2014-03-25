//
//  SearchListViewController.m
//  Yelp
//
//  Created by Stepan Grigoryan on 3/20/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//
#import "SearchListViewController.h"
#import "SearchItemCell.h"
#import "YelpClient.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"g7t7dDPZsBKhktjRXBQf_w";
NSString * const kYelpConsumerSecret = @"RUpXsOoZZxbEc7XwehDeFmQRnJk";
NSString * const kYelpToken = @"IbGkF61FZM5NQuWhr28MEs02tqD_8rNw";
NSString * const kYelpTokenSecret = @"h7Azg-XLhEAnOzcveHMYr2z_N0g";

@interface SearchListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SearchItemCell *prototypeCell;
@property (nonatomic, strong) NSArray *searchItems;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) UINavigationController *fnc;
@end

@implementation SearchListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Yelp";
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    }
    return self;
}

- (SearchItemCell *)prototypeCell
{
    if(!_prototypeCell){
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:[SearchItemCell cellIdentifier]];
    }
    return _prototypeCell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.filterOptions = [[FilterOptions alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchItemCell" bundle:nil] forCellReuseIdentifier:[SearchItemCell cellIdentifier]];
    
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,0.0f)];
	[searchBar sizeToFit];
    searchBar.delegate = self;
    [searchBar setShowsCancelButton:YES];
    searchBar.barStyle = UIBarStyleBlack;
	self.navigationItem.titleView = searchBar;
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleDone target:self action:@selector(onFilterButtonClick)];
    self.navigationItem.leftBarButtonItem = filterButton;
    
    FilterViewController *fvc = [[FilterViewController alloc] init];
    fvc.filterOptions = self.filterOptions;
    self.fnc = [[UINavigationController alloc] initWithRootViewController:fvc];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchData];
}

- (void)fetchData
{
    [self.client searchWithParameters:[self.filterOptions parameters] success:^(AFHTTPRequestOperation *operation, id response) {
        self.searchItems = [SearchItem searchItemsWithObject:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onFilterButtonClick
{
    [self presentViewController:self.fnc animated:YES completion:nil];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchItemCell *cell = (SearchItemCell *) [tableView dequeueReusableCellWithIdentifier:[SearchItemCell cellIdentifier] forIndexPath:indexPath];
    cell.searchItem = self.searchItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchItem *item = self.searchItems[indexPath.row];
    return self.prototypeCell.frame.size.height + ceil([item extraHeight:21]);
}

#pragma mark - Search Bar methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.filterOptions.searchTerm = searchBar.text;
    [self fetchData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    self.filterOptions.searchTerm = nil;
    [self fetchData];
}

@end
