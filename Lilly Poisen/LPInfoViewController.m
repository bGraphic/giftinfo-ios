//
//  LPInfoViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPInfoViewController.h"

@interface LPInfoViewController ()

@property NSURL *contentUrl;

@end

@implementation LPInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self configureView];
    
    self.toolbarItems = self.navigationController.toolbarItems;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Content

- (void)setContentKey:(NSString *) newContentKey
{
    if (![_contentKey isEqualToString:newContentKey])
    {
        _contentKey = newContentKey;
        
        @try {
            self.contentUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                                      pathForResource:newContentKey ofType:@"html"] isDirectory:NO];
        } @catch (NSException *ex)
        {
            NSLog(@"Could not find file: %@ because: %@", newContentKey, ex.description);
        }
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.contentUrl)
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.contentUrl]];
    }
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
