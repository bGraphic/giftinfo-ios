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

static NSString *headerString;
static NSString *footerString;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.webView.delegate = self;
    
    [self configureView];
    
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

- (void) setPoison:(LPPoison *) poison
{
    _topic = nil;
    
    if(_poison != poison)
    {
        _poison = poison;
    }
}

- (void) setTopic:(LPTopic *) topic
{
    _poison = nil;
    
    if(_topic != topic)
    {
        _topic = topic;
    }
}

- (void)configureView
{
    if(self.view)
    
    if (self.poison || self.topic)
    {
        if(!headerString) {
        
            NSString *headerPath = [[NSBundle mainBundle] pathForResource:@"header" ofType:@"html"];
        
            NSError *headerError;
            headerString = [NSString stringWithContentsOfFile:headerPath encoding:NSUTF8StringEncoding error:&headerError];
        
            if(headerError)
                NSLog(@"Problems loading content %@", headerError.description);
        }
        
        if(!footerString) {
            NSString *footerPath = [[NSBundle mainBundle] pathForResource:@"footer" ofType:@"html"];
            
            NSError *footerError;
            footerString = [NSString stringWithContentsOfFile:footerPath encoding:NSUTF8StringEncoding error:&footerError];
            
            if(footerError)
                NSLog(@"Problems loading content %@", footerError.description);

        }
        
        NSString *contentString;
        
        if(self.topic)
            contentString = self.topic.content;
        else if (self.poison)
            contentString = self.poison.content;
            
        
        NSString *htmlString = [NSString stringWithFormat:@"%@\n%@\n%@", headerString, contentString, footerString];
        
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
