//
//  SearchListViewController.m
//  Yelp
//
//  Created by Stepan Grigoryan on 3/20/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//
#import "SearchListViewController.h"
#import "SearchItemCell.h"

@interface SearchListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) SearchItemCell *prototypeCell;
@property (nonatomic, strong) NSArray *searchItems;

@end

@implementation SearchListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Yelp";
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
    //self.tableView.rowHeight = 125;
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchItemCell" bundle:nil] forCellReuseIdentifier:[SearchItemCell cellIdentifier]];
    SearchItemCell *cell = [[SearchItemCell alloc] init];
    NSLog(@"Blah Height: %f, Width: %f", cell.frame.size.height, cell.frame.size.width);
    self.searchItems = @[@"This is a long titles", @"short title", @"This might be a really long title", @"This might be a really long title This might be a really long title"];
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
    cell.searchItem = [[SearchItem alloc] init];
    [cell setTitle:self.searchItems[indexPath.row]];
    //NSLog(@"Cell: %f,%f", cell.frame.size.width, cell.frame.size.height);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *s = self.searchItems[indexPath.row];
    UILabel *u = self.prototypeCell.placeTitle;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], NSFontAttributeName,
                                [NSParagraphStyle defaultParagraphStyle], NSParagraphStyleAttributeName,
                                nil];
    CGRect r = [s boundingRectWithSize:CGSizeMake(137, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    NSLog(@"Height: %f, Width: %f", r.size.height, r.size.width);
    SearchItemCell *cell = self.prototypeCell;
    //NSLog(@"Cell: %f,%f", cell.frame.size.width, cell.frame.size.height);
    return cell.frame.size.height - u.frame.size.height + ceil(r.size.height);
}
@end
