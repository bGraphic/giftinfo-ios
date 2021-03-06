//
//  LPTopicDataSource.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 02.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPTopicDataSource.h"
#import "LPTopicDataFromWP.h"

@interface LPTopicDataSource ()

@property (strong, nonatomic) NSArray *mainInfoData;
@property (strong, nonatomic) NSDictionary *topicDictonary;

@end

@implementation LPTopicDataSource

- (id) init
{
    self = [super init];
    if(self)
    {
        NSString *propertyFile = [[NSBundle mainBundle] pathForResource:@"main-info" ofType:@"plist"];
        self.mainInfoData = [NSArray arrayWithContentsOfFile:propertyFile];
        self.topicDictonary = [LPTopicDataFromWP topicData];
    }
    
    return self;
}

- (LPTopic *) topicAtIndexPath:(NSIndexPath *) indexPath
{
    NSDictionary *section = self.mainInfoData[indexPath.section];
    
    if(indexPath.section == 0)
    {
        LPTopic *topic = [LPTopic alloc];
        topic.title = section[@"topics"][indexPath.row][@"title"];
        
        return topic;
    }
    else
    {
        NSString *slug = section[@"topics"][indexPath.row];
        LPTopic *topic = [self.topicDictonary valueForKey:slug];
        
        return topic;
    }
}

- (LPTopic *) topicAtSlug:(NSString *) slug
{
    return [self.topicDictonary objectForKey:slug];
}

#pragma mark - Table View Data Source

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
    NSString *CellIdentifier = @"infoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self topicAtIndexPath:indexPath].title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

+ (LPTopic *) topicAtSlug:(NSString *)slug
{
    LPTopicDataSource *dataSource = [[LPTopicDataSource alloc] init];
    
    return [dataSource topicAtSlug:slug];
}

@end
