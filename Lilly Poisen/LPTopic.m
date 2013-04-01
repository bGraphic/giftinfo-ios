//
//  LPTopic.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPTopic.h"

@implementation LPTopic

+ (LPTopic *) topicFromDict:(NSDictionary *) poisonDict
{
    LPTopic *topic = [[LPTopic alloc] init];
    topic.title = poisonDict[@"title"];
    topic.content = poisonDict[@"content"];
    
    return topic;
}

@end
