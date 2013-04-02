//
//  LPTableViewController.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPPoisonDataSource.h"

@interface LPPoisonTableViewController : UITableViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet LPPoisonDataSource *poisonDataSource;

@property UIWebView *webView;

@end
