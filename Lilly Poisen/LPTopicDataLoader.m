//
//  LPTopicDataLoader.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPTopicDataLoader.h"
#import "LPTopic.h"
#import "LPJSONfromWP.h"

@implementation LPTopicDataLoader

static NSDictionary *topicDictonary;


+ (NSDictionary *) createTopicsArrayFromDataArray:(NSArray *) poisonDataArray
{
    NSMutableDictionary *poisonDataUnsorted = [NSMutableDictionary dictionaryWithCapacity:poisonDataArray.count];
    
    for(NSDictionary *poisonDict in poisonDataArray)
    {
        LPTopic *topic = [[LPTopic alloc] init];
        topic.title = poisonDict[@"title"];
        topic.content = poisonDict[@"content"];
        
        [poisonDataUnsorted setValue:topic forKey:poisonDict[@"slug"]];
    }
    
    return poisonDataUnsorted;
}

+ (void) loadTopicData
{
    NSArray *dataArray = [LPJSONfromWP wpPostsInFile:@"topics"];
    topicDictonary = [LPTopicDataLoader createTopicsArrayFromDataArray:dataArray];
}

+ (NSDictionary *) topicDictonary
{
    if(!topicDictonary)
    {
        [LPTopicDataLoader loadTopicData];
    }
    
    return topicDictonary;
}

@end
