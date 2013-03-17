//
//  LPDataSource.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poison.h"

@interface LPDataSource : NSObject <UITableViewDataSource, UISearchDisplayDelegate>

- (Poison *) getPoisonAtIndexPath:(NSIndexPath *)indexPath;

@end
