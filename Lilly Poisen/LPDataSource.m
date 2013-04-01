//
//  LPDataSource.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPDataSource.h"
#import "Poison.h"

@implementation LPDataSource

static NSArray *poisonArray;

+ (NSArray *) poisonWithDict:(NSDictionary *) poisonDict
{
    NSArray *nameArray = [poisonDict[@"title"] componentsSeparatedByString:@","];
    
    NSMutableArray *poisons = [[NSMutableArray alloc] initWithCapacity:nameArray.count];
    
    NSLog(@"name array %d", nameArray.count);
    
    for (int i=0; i < nameArray.count; i++)
    {
        NSString *name = [[nameArray objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        Poison *poison = [[Poison alloc] init];
        
        poison.name = name;
        poison.key = poisonDict[@"slug"];
        poison.content = poisonDict[@"content"];
        poison.symptoms = poisonDict[@"custom_fields"][@"wpcf-symptoms"][0];
        poison.action = poisonDict[@"custom_fields"][@"wpcf-action"][0];
        poison.coal = poisonDict[@"custom_fields"][@"wpcf-coal"][0];
        poison.risk = poisonDict[@"custom_fields"][@"wpcf-risk"][0];
        
        NSMutableArray *tagArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *tagDict in poisonDict[@"tags"])
        {
            NSLog(@"%@", poisonDict[@"tags"]);
            
            [tagArray addObject:tagDict[@"title"]];
        }
        
        NSLog(@"%@", [tagArray description]);
        
        poison.tags = [[NSArray alloc] initWithArray:tagArray];
        
        if(i > 0)
        {
            poison.key = [NSString stringWithFormat:@"%@-%d", poison.key, i];
            poison.tags = nil;
        }
        
        [poisons addObject:poison];
    }
    
    return poisons;
}

+ (NSArray *) loadPoisonsArrayFromJSONFile:(NSString *) poisonFile
{
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:poisonFile ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:contentPath];
    
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    if(error) {
        NSLog(@"Error: %@", [error description]);
    }
    
    return [json objectForKey:@"posts"];
}

+ (NSArray *) createPoisonListFromJSONArray:(NSArray *) poisonJSONArray
{
    NSMutableArray *poisonDataUnsorted = [NSMutableArray array];
    
    for(NSDictionary *poisonDict in poisonJSONArray)
    {
        [poisonDataUnsorted addObjectsFromArray:[LPDataSource poisonWithDict:poisonDict]];
    }
    
    NSSortDescriptor *lastDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"name"
                                ascending:YES
                                 selector:@selector(localizedCaseInsensitiveCompare:)];
    
    return [poisonDataUnsorted sortedArrayUsingDescriptors:[NSArray arrayWithObject:lastDescriptor]];
}

+ (void) loadPoisonData
{
    NSArray *poisonJSONArray = [LPDataSource loadPoisonsArrayFromJSONFile:@"poisons"];
    poisonArray = [LPDataSource createPoisonListFromJSONArray:poisonJSONArray];
}

+ (NSArray *) poisonArray
{
    if(!poisonArray)
    {
        [LPDataSource loadPoisonData];
    }
    
    return poisonArray;
}

@end
