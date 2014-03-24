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

NSString * const kYelpConsumerKey = @"g7t7dDPZsBKhktjRXBQf_w";
NSString * const kYelpConsumerSecret = @"RUpXsOoZZxbEc7XwehDeFmQRnJk";
NSString * const kYelpToken = @"IbGkF61FZM5NQuWhr28MEs02tqD_8rNw";
NSString * const kYelpTokenSecret = @"h7Azg-XLhEAnOzcveHMYr2z_N0g";

@interface SearchListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SearchItemCell *prototypeCell;
@property (nonatomic, strong) NSArray *searchItems;
@property (nonatomic, strong) YelpClient *client;

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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchItemCell" bundle:nil] forCellReuseIdentifier:[SearchItemCell cellIdentifier]];
    //self.searchItems = @[@"This is a long titles", @"short title", @"This might be a really long title", @"This might be a really long title This might be a really long title"];
    
    
	UISearchBar *searchBar = [[UISearchBar alloc]
                                 initWithFrame:CGRectMake(0.0f,0.0f,320.0f,0.0f)];
	[searchBar sizeToFit];
	self.navigationItem.titleView = searchBar;
	self.navigationItem.titleView.autoresizingMask = UIViewAutoresizingNone;
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleBordered target:nil action:nil];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.leftBarButtonItem = filterButton;
    self.navigationItem.rightBarButtonItem = searchButton;
    [self fetchData];
}

- (void)fetchData
{
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"response: %@", response);
        self.searchItems = [SearchItem searchItemsWithObject:response];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *s = @"some string";
    UILabel *u = self.prototypeCell.placeTitle;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], NSFontAttributeName,
                                [NSParagraphStyle defaultParagraphStyle], NSParagraphStyleAttributeName,
                                nil];
    CGRect r = [s boundingRectWithSize:CGSizeMake(137, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return self.prototypeCell.frame.size.height - u.frame.size.height + ceil(r.size.height);
}
@end
