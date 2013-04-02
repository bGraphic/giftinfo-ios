//
//  LPTableViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPPoisonTableViewController.h"
#import "LPContentViewController.h"
#import "LPPoison.h"
#import "LPSearchBar.h"

@interface LPPoisonTableViewController ()

@end

@implementation LPPoisonTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.poisonDataSource = [[LPPoisonDataSource alloc] init];
    
    self.toolbarItems = self.navigationController.toolbarItems;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 10, 0);
    
    
    self.tableView.dataSource = self.poisonDataSource;
    self.searchDisplayController.delegate = self.poisonDataSource;
    self.searchDisplayController.searchResultsDataSource = self.poisonDataSource;
    
    LPSearchBar *searchBar = (LPSearchBar *) self.searchDisplayController.searchBar;
    searchBar.borderColor = self.tableView.separatorColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * storyboard = self.storyboard;
    LPContentViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
    
    LPPoison *poison = [self.poisonDataSource poisonAtIndexPath:indexPath];
    detail.htmlString = poison.htmlString;
    
    [self.navigationController pushViewController: detail animated: YES];
}

- (void)viewDidUnload {
    [self setPoisonDataSource:nil];
    [super viewDidUnload];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

@end
