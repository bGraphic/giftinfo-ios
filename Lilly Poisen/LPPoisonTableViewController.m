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
#import <QuartzCore/QuartzCore.h>

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
    
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    searchBar.clipsToBounds = YES;
    
    //to remove searchbar default background layer
    if ([[[searchBar subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
        [[[searchBar subviews] objectAtIndex:0] setAlpha:0.f];
        [[[searchBar subviews] objectAtIndex:0] setBackgroundColor:[UIColor whiteColor]];
        [[[searchBar subviews] objectAtIndex:0] setBackgroundImage:nil];
    }
    
    //to remove search icon. Note that objectAtIndex = 0 because background layer is already removed
    UITextField *textField;
    if ([[[searchBar subviews] objectAtIndex:1] isKindOfClass:[UITextField class]]){
        textField = [[searchBar subviews] objectAtIndex:1];
    }
//    textField.leftView = nil;
    [textField setBackground:nil];
    
    CGRect rect = searchBar.bounds;
    
    UIView *searchBackground = [[UIView alloc] initWithFrame:rect];
    searchBackground.backgroundColor = [UIColor whiteColor];
    
    rect.origin.y = rect.size.height-1.f;
    rect.size.height = 1.f;
    
    UIView *bottomBorder = [[UIView alloc] initWithFrame:rect];
    bottomBorder.backgroundColor = self.tableView.separatorColor;
    [searchBackground addSubview:bottomBorder];
    
    [searchBar insertSubview:searchBackground atIndex:0];
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
    detail.poison = poison;
    
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
