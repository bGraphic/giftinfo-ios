//
//  LPTableViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPTableViewController.h"
#import "LPInfoViewController.h"
#import "LPEntryViewCell.h"

@interface LPTableViewController ()

@end

@implementation LPTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.toolbarItems = self.navigationController.toolbarItems;
    self.searchDisplayController.searchResultsDataSource = self.dataSource;
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
    
    LPInfoViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
    
    Poison *poison = [self.dataSource getPoisonAtIndexPath:indexPath];
    
    detail.contentKey = poison.key;
    detail.title = poison.name;
    
    [self.navigationController pushViewController: detail animated: YES];
}

- (void)viewDidUnload {
    [self setDataSource:nil];
    [super viewDidUnload];
}

@end
