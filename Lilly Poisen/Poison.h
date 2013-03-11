//
//  Poison.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 11.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Term;

@interface Poison : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *synonyms;
@end

@interface Poison (CoreDataGeneratedAccessors)

- (void)addSynonymsObject:(Term *)value;
- (void)removeSynonymsObject:(Term *)value;
- (void)addSynonyms:(NSSet *)values;
- (void)removeSynonyms:(NSSet *)values;

@end
