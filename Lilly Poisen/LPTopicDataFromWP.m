//
//  LPTopicDataFromWP.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPTopicDataFromWP.h"
#import "LPTopic.h"
#import "LPJSONfromWP.h"

@interface LPTopicDataFromWP ()

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSMutableDictionary *topicData;

@end

@implementation LPTopicDataFromWP

static NSDictionary *topicData;


- (id) initWithFileName: (NSString *) fileName
{
    self = [super init];
    if(self)
    {
        self.fileName = fileName;
        [self loadTopicData];
    }
    
    return self;
}

- (void) loadTopicData
{
    NSArray *dataArray = [LPJSONfromWP wpPostsInFile:@"topics"];
    
   self.topicData = [NSMutableDictionary dictionaryWithCapacity:dataArray.count];
    
    for(NSDictionary *poisonDict in dataArray)
    {
        LPTopic *topic = [[LPTopic alloc] init];
        topic.title = poisonDict[@"title"];
        topic.content = poisonDict[@"content"];
        
        [self.topicData setValue:topic forKey:poisonDict[@"slug"]];
    }
}

+ (NSDictionary *) topicData
{
    if(!topicData)
    {
        LPTopicDataFromWP *topicDataFromWP = [[LPTopicDataFromWP alloc] initWithFileName:@"poisons"];
        topicData = topicDataFromWP.topicData;
    }
    
    return topicData;
}

@end
