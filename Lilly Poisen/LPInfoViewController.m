//
//  LPInfoViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPInfoViewController.h"

@interface LPInfoViewController ()

@end

@implementation LPInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self configureView];
    
    self.toolbarItems = self.navigationController.toolbarItems;
    
    CGRect frame = self.webView.frame;
    frame.size.height -= 20;
    self.webView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Content

- (void)setHtmlContentString:(NSString *) newHtmlContentString
{
    _htmlContentString = newHtmlContentString;

    [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.htmlContentString)
    {
        NSString *headerPath = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"html"];
        
        NSError *headerError;
        NSString *headerString = [NSString stringWithContentsOfFile:headerPath encoding:NSUTF8StringEncoding error:&headerError];
        
        if(headerError)
            NSLog(@"Problems loading content %@", headerError.description);
        
        NSString *footerPath = [[NSBundle mainBundle] pathForResource:@"footer" ofType:@"html"];
        
        NSError *footerError;
        NSString *footerString = [NSString stringWithContentsOfFile:footerPath encoding:NSUTF8StringEncoding error:&footerError];
        
        if(footerError)
            NSLog(@"Problems loading content %@", footerError.description);
        
        
        NSString *htmlString = [NSString stringWithFormat:@"%@\n%@\n%@", headerString, self.htmlContentString, footerString];
        
        [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    }
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
