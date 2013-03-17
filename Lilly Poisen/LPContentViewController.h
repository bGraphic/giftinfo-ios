//
//  LPContentViewController.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 17.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPContentViewController : UITableViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSString *htmlContentString;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
