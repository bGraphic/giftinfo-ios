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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:tableView.indexPathForSelectedRow];
    
    UIStoryboard * storyboard = self.storyboard;
    
    LPEntryViewCell *entryCell = (LPEntryViewCell *) cell;
    
    LPInfoViewController * detail = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
    
    detail.contentKey = entryCell.key;
    detail.title = entryCell.name;
    
    [self.navigationController pushViewController: detail animated: YES];
}

@end
