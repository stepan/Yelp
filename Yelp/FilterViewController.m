//
//  FilterViewController.m
//  Yelp
//
//  Created by Stepan Grigoryan on 3/24/14.
//  Copyright (c) 2014 Stepan Grigoryan. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL radiusExpanded;
@property (nonatomic, assign) BOOL sortTypeExpanded;
@property (nonatomic, assign) BOOL categoriesExpanded;
@property (nonatomic, assign) NSInteger categoriesIntialRows;
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
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDoneButtonClick)];
    self.navigationItem.leftBarButtonItem = doneButton;
    self.categoriesIntialRows = 5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onDoneButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) { //categories
        if (self.categoriesExpanded) {
            return [self.filterOptions.allOptions[section][@"rows"] count];
        }
        return self.categoriesIntialRows;
    }
    else if(section == 3){ //deals
        return [self.filterOptions.allOptions[section][@"rows"] count];
    }
    else if(section == 0){ //radius
        if (self.radiusExpanded) {
            return [self.filterOptions.allOptions[section][@"rows"] count];
        }
        return 1;
    }
    else{ //sortype
        if (self.sortTypeExpanded) {
            return [self.filterOptions.allOptions[section][@"rows"] count];
        }
        return 1;
    }
    return [self.filterOptions.allOptions[section][@"rows"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.filterOptions.allOptions count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.filterOptions.allOptions[section][@"header"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *rows = self.filterOptions.allOptions[indexPath.section][@"rows"];
    cell.textLabel.text = rows[indexPath.row];
    if (indexPath.section == 2) { //categories
        if (!self.categoriesExpanded && self.categoriesIntialRows - 1== indexPath.row) {
            cell.textLabel.text = @"See All";
        }
        else{
            cell.textLabel.text = rows[indexPath.row];
        }
        if ([self.filterOptions.categories containsObject:@(indexPath.row)]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if(indexPath.section == 3){ //deals
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (self.filterOptions.dealOnly) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    else if(indexPath.section == 0){ //radius
        if (self.radiusExpanded) {
            if (self.filterOptions.radiusIndex == indexPath.row) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        else{
            cell.textLabel.text = self.filterOptions.allOptions[0][@"rows"][self.filterOptions.radiusIndex];
        }

    }
    else{ //sortype
        if (self.sortTypeExpanded) {
            if (self.filterOptions.sortTypeIndex == indexPath.row) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        else{
            cell.textLabel.text = self.filterOptions.allOptions[1][@"rows"][self.filterOptions.sortTypeIndex];
        }
    }

    return cell;
}

- (void)tableView:tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 2) { //categories
        if (!self.categoriesExpanded && self.categoriesIntialRows - 1== indexPath.row) {
            self.categoriesExpanded = YES;
        }
        else{
            if (cell.accessoryType == UITableViewCellAccessoryNone) {
                [self.filterOptions.categories addObject:@(indexPath.row)];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                [self.filterOptions.categories removeObject:@(indexPath.row)];
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(indexPath.section == 3){ //deals
        if (cell.accessoryType == UITableViewCellAccessoryNone) {
            self.filterOptions.dealOnly = YES;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else{
            self.filterOptions.dealOnly = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if(indexPath.section == 0){ //radius
        if (self.radiusExpanded) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            self.filterOptions.radiusIndex = indexPath.row;
            self.radiusExpanded = NO;
        }
        else {
            self.radiusExpanded = YES;
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    else{ //sortType
        if (self.sortTypeExpanded) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            self.filterOptions.sortTypeIndex = indexPath.row;
            self.sortTypeExpanded = NO;
        }
        else {
            self.sortTypeExpanded = YES;
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}


@end
