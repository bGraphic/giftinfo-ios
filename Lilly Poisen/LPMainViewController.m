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
#import "BGCommonGraphics.h"
#import "BGInfoNavigationControllerDelegate.h"
#import "LPPhoneBooth.h"

@interface LPMainViewController ()

@property (nonatomic, strong) LPTopicDataSource *topicDataSource;
@property (nonatomic, strong) BGInfoNavigationControllerDelegate *navDelegate;
@property (nonatomic, strong) LPPhoneBooth *phoneBooth;

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
    
    self.webView = [super addWebViewToView:self.view withHtmlString:@""];
    
    self.tableView.backgroundView = [BGCommonGraphics backgroundView];
    
    [self configureInfoButton];
    
    [self configurePhoneButtons];
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
            
            self.webView = [super addWebViewToView:self.view withHtmlString:topic.htmlString];
            
            self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(5.f, 0, 10.f, 0);
            
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
            return 15.f;
        else
            return 40.f;
    }
}

#pragma mark - Toolbar Items

- (void)configureInfoButton
{
    self.navDelegate = [[BGInfoNavigationControllerDelegate alloc] init];
    self.navigationController.delegate = self.navDelegate;
}

- (void)configurePhoneButtons
{
    self.phoneBooth = [[LPPhoneBooth alloc] init];
    
    [[self.toolbarItems objectAtIndex:0] setAction:@selector(callAmbulance:)];
    [[self.toolbarItems objectAtIndex:0] setTarget:self.phoneBooth];
    [[self.toolbarItems objectAtIndex:2] setAction:@selector(callInfo:)];
    [[self.toolbarItems objectAtIndex:2] setTarget:self.phoneBooth];
}

@end
