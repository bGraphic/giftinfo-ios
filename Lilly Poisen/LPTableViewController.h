//
//  LPTableViewController.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPDataSource.h"

@interface LPTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet LPDataSource *dataSource;
@end
