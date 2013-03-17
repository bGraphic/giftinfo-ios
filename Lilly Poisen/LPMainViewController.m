//
//  LPMainViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPMainViewController.h"
#import "LPContentViewController.h"
#import "Poison.h"
#import "LPHtmlStringHelper.h"

@interface LPMainViewController ()

@property (strong, nonatomic) NSArray *mainInfoData;

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
    
    
    [self loadTableData];
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

- (void) loadTableData
{
    NSString *propertyFile = [[NSBundle mainBundle] pathForResource:@"main-info" ofType:@"plist"];
    self.mainInfoData = [NSArray arrayWithContentsOfFile:propertyFile];
}

- (NSDictionary *) topicAtIndexPath:(NSIndexPath *) indexPath
{
    NSDictionary *section = self.mainInfoData[indexPath.section];
    NSDictionary *topic = section[@"topics"][indexPath.row];
    
    return topic;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mainInfoData.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.mainInfoData[section][@"title"];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return self.mainInfoData[section][@"footer"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDict = self.mainInfoData[section];
    NSArray *topics = sectionDict[@"topics"];
    
    return topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView != tableView)
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        NSString *CellIdentifier = @"infoCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = [self topicAtIndexPath:indexPath][@"title"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return cell;
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
            UIStoryboard * storyboard = self.storyboard;
            LPContentViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
            
            NSDictionary *topic = [self topicAtIndexPath:indexPath];
            
            detail.htmlContentString = [LPHtmlStringHelper stringFromHtmlFileWithName:topic[@"html"]];
            detail.title = topic[@"title"];
            
            [self.navigationController pushViewController: detail animated: YES];
        }
    }
}

@end
