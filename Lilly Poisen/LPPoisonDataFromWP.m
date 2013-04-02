//
//  LPJSONtoObject.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPPoisonDataFromWP.h"
#import "LPTopic.h"
#import "LPPoison.h"
#import "LPJSONfromWP.h"

@interface LPPoisonDataFromWP ()

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSMutableArray *poisonData;

@end

@implementation LPPoisonDataFromWP

static NSArray *poisonData;


- (id) initWithFileName: (NSString *) fileName
{
    self = [super init];
    if(self)
    {
        self.fileName = fileName;
        [self loadPoisonData];
    }
    
    return self;
}

- (void) loadPoisonData
{
    NSArray *wpPostsInFile = [LPJSONfromWP wpPostsInFile:@"poisons"];
    
    self.poisonData = [NSMutableArray arrayWithCapacity:wpPostsInFile.count];
    
    for(NSDictionary *poisonDict in wpPostsInFile)
    {
        [self.poisonData addObjectsFromArray:[self poisonsWithDict:poisonDict]];
    }
    
    NSSortDescriptor *lastDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"name"
                                ascending:YES
                                 selector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.poisonData = [NSMutableArray arrayWithArray:[self.poisonData sortedArrayUsingDescriptors:[NSArray arrayWithObject:lastDescriptor]]];
}

- (NSArray *) poisonsWithDict:(NSDictionary *) poisonDict
{
    NSArray *nameDataArray = [poisonDict[@"title"] componentsSeparatedByString:@","];
    
    NSMutableArray *nameArray = [[NSMutableArray alloc] initWithCapacity:nameDataArray.count];
    NSMutableArray *poisons = [[NSMutableArray alloc] initWithCapacity:nameDataArray.count];
    
    for (NSString *nameData in nameDataArray)
    {
        NSString *name = [nameData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [nameArray addObject:name];
    }
    
    int i = 0;
    
    for (NSString *name in nameArray)
    {
        LPPoison *poison = [[LPPoison alloc] init];
        
        poison.name = name;
        poison.slug = poisonDict[@"slug"];
        poison.content = poisonDict[@"content"];
        poison.symptoms = poisonDict[@"custom_fields"][@"wpcf-symptoms"][0];
        poison.action = poisonDict[@"custom_fields"][@"wpcf-action"][0];
        poison.coal = poisonDict[@"custom_fields"][@"wpcf-coal"][0];
        poison.risk = poisonDict[@"custom_fields"][@"wpcf-risk"][0];
        
        [poisons addObject:poison];
        
        if(i == 0)
        {
            NSMutableArray *firstPoisonsOtherNames = [NSMutableArray arrayWithArray:nameArray];
            [firstPoisonsOtherNames removeObject:poison.name];
            poison.otherNames = firstPoisonsOtherNames;
            
            NSMutableArray *tagArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *tagDict in poisonDict[@"tags"])
            {
                [tagArray addObject:tagDict[@"title"]];
            }
            
            poison.tags = tagArray;
        }
        else
        {
            poison.slug = [NSString stringWithFormat:@"%@-%d", poison.slug, i];
        }
        
        NSLog(@"%@", [poison description]);
        
        i++;
    }
        
    return poisons;
}

+ (NSArray *) poisonData
{
    if(!poisonData)
    {
        LPPoisonDataFromWP *poisonDataFromWP = [[LPPoisonDataFromWP alloc] initWithFileName:@"poisons"];
        poisonData = poisonDataFromWP.poisonData;
    }
    
    return poisonData;
}

@end
