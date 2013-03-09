//
//  LPEntry.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPEntry : NSObject

@property (strong, nonatomic, readonly) NSString *key;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSString *synonyms;

+ (id)entryWithKey:(NSString *) key andName:(NSString *) name withSynonyms:(NSString *) synonyms;

@end
