//
//  LPTopicDataLoader.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPTopicDataLoader.h"
#import "LPTopic.h"

@implementation LPTopicDataLoader

static NSDictionary *topicDictonary;

+ (NSArray *) loadDataArrayFromJSONFile:(NSString *) poisonFile
{
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:poisonFile ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:contentPath];
    
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if(error) {
        NSLog(@"Error: %@", [error description]);
    }
    
    data = nil;
    
    return [json objectForKey:@"posts"];
}

+ (NSDictionary *) createPoisonArrayFromDataArray:(NSArray *) poisonDataArray
{
    NSMutableDictionary *poisonDataUnsorted = [NSMutableDictionary dictionaryWithCapacity:poisonDataArray.count];
    
    for(NSDictionary *poisonDict in poisonDataArray)
    {
        [poisonDataUnsorted setObject:[LPTopic topicFromDict:poisonDict] forKey:poisonDict[@"slug"]];
    }
    
    return poisonDataUnsorted;
}

+ (void) loadTopicData
{
    NSArray *dataArray = [LPTopicDataLoader loadDataArrayFromJSONFile:@"topics"];
    topicDictonary = [LPTopicDataLoader createPoisonArrayFromDataArray:dataArray];
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
