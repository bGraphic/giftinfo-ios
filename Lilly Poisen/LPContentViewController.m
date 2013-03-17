//
//  LPContentViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 17.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPContentViewController.h"

@interface LPContentViewController ()

@end

@implementation LPContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.webView.delegate = self;
    
    [self configureView];
    
    self.toolbarItems = self.navigationController.toolbarItems;
    
    self.toolbarItems = self.navigationController.toolbarItems;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 10, 0);
    
    self.webView.scrollView.bounces = NO;
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
    
//    [self configureView];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.webView.frame.size.height + 10.f;
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}

- (void) webViewDidFinishLoad:(UIWebView *)sender {
    [self performSelector:@selector(calculateWebViewSize) withObject:nil afterDelay:0.1];
}

- (void) calculateWebViewSize {
    [self.webView sizeToFit];
    [self.tableView reloadData];
}

@end
