//
//  LPDataSource.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPPoisonDataLoader.h"
#import "Poison.h"

@implementation LPPoisonDataLoader

static NSArray *poisonArray;

+ (NSArray *) poisonWithDict:(NSDictionary *) poisonDict
{
    NSArray *nameDataArray = [poisonDict[@"title"] componentsSeparatedByString:@","];
    
    NSMutableArray *nameArray = [[NSMutableArray alloc] initWithCapacity:nameDataArray.count];
    NSMutableArray *poisons = [[NSMutableArray alloc] initWithCapacity:nameDataArray.count];
    
    int i = 0;

    for (NSString *nameData in nameDataArray)
    {
        NSString *name = [nameData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [nameArray addObject:name];
        
        Poison *poison = [[Poison alloc] init];
        
        poison.name = name;
        poison.key = poisonDict[@"slug"];
        poison.content = poisonDict[@"content"];
        poison.symptoms = poisonDict[@"custom_fields"][@"wpcf-symptoms"][0];
        poison.action = poisonDict[@"custom_fields"][@"wpcf-action"][0];
        poison.coal = poisonDict[@"custom_fields"][@"wpcf-coal"][0];
        poison.risk = poisonDict[@"custom_fields"][@"wpcf-risk"][0];
        
        [poisons addObject:poison];
        
        if(i > 0)
        {
            poison.key = [NSString stringWithFormat:@"%@-%d", poison.key, i];
        
            NSMutableArray *tagArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *tagDict in poisonDict[@"tags"])
            {
                [tagArray addObject:tagDict[@"title"]];
            }
            
            poison.tags = tagArray;
        }
    
        i++;
    }
    
    Poison *firstPoison = [poisons objectAtIndex:0];
    NSMutableArray *firstPoisonsOtherNames = [NSMutableArray arrayWithArray:nameArray];
    [firstPoisonsOtherNames removeObject:firstPoison.name];
    firstPoison.otherNames = firstPoisonsOtherNames;
    
    return poisons;
}

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

+ (NSArray *) createPoisonArrayFromDataArray:(NSArray *) poisonDataArray
{
    NSMutableArray *poisonDataUnsorted = [NSMutableArray array];
    
    for(NSDictionary *poisonDict in poisonDataArray)
    {
        [poisonDataUnsorted addObjectsFromArray:[LPPoisonDataLoader poisonWithDict:poisonDict]];
    }
    
    NSSortDescriptor *lastDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"name"
                                ascending:YES
                                 selector:@selector(localizedCaseInsensitiveCompare:)];
    
    return [poisonDataUnsorted sortedArrayUsingDescriptors:[NSArray arrayWithObject:lastDescriptor]];
}

+ (void) loadPoisonData
{
    NSArray *dataArray = [LPPoisonDataLoader loadDataArrayFromJSONFile:@"poisons"];
    poisonArray = [LPPoisonDataLoader createPoisonArrayFromDataArray:dataArray];
}

+ (NSArray *) poisonArray
{
    if(!poisonArray)
    {
        [LPPoisonDataLoader loadPoisonData];
    }
    
    return poisonArray;
}

@end
