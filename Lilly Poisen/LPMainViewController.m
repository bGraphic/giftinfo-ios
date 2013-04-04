//
//  LPMainViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPMainViewController.h"
#import "LPPoison.h"
#import "LPHtmlStringHelper.h"
#import "LPTopicDataSource.h"
#import "LPTopic.h"

@interface LPMainViewController ()

@property (nonatomic, strong) LPTopicDataSource *topicDataSource;


@end

@implementation LPMainViewController

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.tableView.dataSource = self;
    
    CGRect toolbarFrame = self.navigationController.toolbar.frame;
    toolbarFrame.size.height += 10;
    toolbarFrame.origin.y -= 5;
    self.navigationController.toolbar.frame = toolbarFrame;
    
    self.topicDataSource = [[LPTopicDataSource alloc] init];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.hidden = YES;
    
    [self.view addSubview:self.webView];
    
    [self.webView loadHTMLString:@"" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GUI-911_background"]];
    imageView.alpha = 0.6;
    self.tableView.backgroundView = imageView;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.topicDataSource numberOfSectionsInTableView:tableView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.topicDataSource tableView:tableView titleForHeaderInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [self.topicDataSource tableView:tableView titleForFooterInSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.topicDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView != tableView)
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        return [self.topicDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView != tableView)
    {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
        if(indexPath.section == 0)
        {
            [self performSegueWithIdentifier:@"showTable" sender:self];
        }
        else
        {            
            LPTopic *topic = [self.topicDataSource topicAtIndexPath:indexPath];
            
            self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
            [self.webView loadHTMLString:topic.htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
            self.webView.hidden = YES;
            [self.view addSubview:self.webView];
            
            self.webView.delegate = self;
        }
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView != tableView)
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else
    {
        return 50.f;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.tableView != tableView)
    {
        return [super tableView:tableView heightForHeaderInSection:(NSInteger)section];
    }
    else
    {
        if(section == 0)
            return 20.f;
        else
            return 40.f;
    }
}

@end
