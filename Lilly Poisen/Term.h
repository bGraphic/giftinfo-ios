//
//  Term.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 11.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Poison;

@interface Term : NSManagedObject

@property (nonatomic, retain) NSString * term;
@property (nonatomic, retain) NSSet *poison;
@end

@interface Term (CoreDataGeneratedAccessors)

- (void)addPoisonObject:(Poison *)value;
- (void)removePoisonObject:(Poison *)value;
- (void)addPoison:(NSSet *)values;
- (void)removePoison:(NSSet *)values;

@end
