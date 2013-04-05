//
//  LPTableViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPPoisonTableViewController.h"
#import "LPPoison.h"
#import "BGSearchBar.h"

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
    
    BGSearchBar *searchBar = (BGSearchBar *) self.searchDisplayController.searchBar;
    searchBar.borderColor = self.tableView.separatorColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationIsPortrait(interfaceOrientation));
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LPPoison *poison = [self.poisonDataSource poisonAtIndexPath:indexPath];
    
    self.webView = [self addWebViewToView:self.view withHtmlString:poison.htmlString];
    
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(5.f, 0, 54.f, 0);
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 44.f, 0);
    }
    else
    {
        self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(5.f, 0, 10.f, 0);
    }
    
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

- (UIWebView *) addWebViewToView:(UIView *) view withHtmlString:(NSString *) htmlString
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    webView.hidden = YES;

    [view addSubview:webView];
    
    [webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    return webView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIViewController *detail = [[UIViewController alloc] init];
    
    [detail.view addSubview:webView];
    self.webView.hidden = NO;
    
    detail.toolbarItems = self.toolbarItems;
    
    [self.navigationController pushViewController: detail animated: YES];
}

@end
