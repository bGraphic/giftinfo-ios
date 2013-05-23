//
//  LPDataSource.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPPoison.h"

@interface LPPoisonDataSource : NSObject <UITableViewDataSource, UISearchDisplayDelegate>

- (id)initWithBlock:(void (^)(BOOL succeded)) completionBlock;

- (LPPoison *) poisonAtIndexPath:(NSIndexPath *) indexPath;
- (LPPoison *) poisonWithSlug:(NSString *) slug;

+ (LPPoison *) poisonWithSlug:(NSString *) slug;

@end
