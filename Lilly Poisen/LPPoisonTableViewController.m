//
//  LPTableViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPPoisonTableViewController.h"
#import "LPPoison.h"
#import "LPSearchBar.h"

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
    LPPoison *poison = [self.poisonDataSource poisonAtIndexPath:indexPath];
    
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.webView loadHTMLString:poison.htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    self.webView.hidden = YES;
    
    [self.view addSubview:self.webView];
    
    self.webView.delegate = self;
}

- (void)viewDidUnload {
    [self setPoisonDataSource:nil];
    [super viewDidUnload];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIViewController *detail = [[UIViewController alloc] init];
    
    [detail.view addSubview:webView];
    self.webView.hidden = NO;
    
    detail.toolbarItems = self.toolbarItems;
    self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 10, 0);
    
    [self.navigationController pushViewController: detail animated: YES];
}

@end
