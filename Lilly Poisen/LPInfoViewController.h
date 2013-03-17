//
//  LPInfoViewController.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPInfoViewController : UIViewController

@property (strong, nonatomic) NSString *htmlContentString;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
