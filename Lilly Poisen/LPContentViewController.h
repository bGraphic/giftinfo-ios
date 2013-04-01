//
//  LPContentViewController.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 17.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPTopic.h"
#import "LPPoison.h"

@interface LPContentViewController : UITableViewController <UIWebViewDelegate>

@property (strong, nonatomic) LPTopic *topic;
@property (strong, nonatomic) LPPoison *poison;

@property (weak, nonatomic) IBOutlet UIWebView *webView1;

@property (weak, nonatomic) IBOutlet UIWebView *webView2;
@end
