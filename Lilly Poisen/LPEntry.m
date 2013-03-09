//
//  LPEntry.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPEntry.h"

@interface LPEntry ()

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *synonyms;

@end

@implementation LPEntry

+ (id)entryWithKey:(NSString *) key andName:(NSString *) name withSynonyms:(NSString *) synonyms
{
    LPEntry *entry = [[self alloc] init];
    
    entry.key = key;
    entry.name = name;
    entry.synonyms = synonyms;
    
    return entry;
}

@end
