//
//  LPContentViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 17.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPContentViewController.h"
#import "LPHtmlStringHelper.h"
#import "LPPoisonDataSource.h"
#import "LPTopicDataSource.h"

@interface LPContentViewController ()

@end

@implementation LPContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self configureView];
    
    self.toolbarItems = self.navigationController.toolbarItems;
    self.webView1.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.webView1.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 10, 0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Content

- (void) setHtmlString:(NSString *)htmlString
{
    _htmlString = nil;
    
    if(![_htmlString isEqualToString:htmlString])
    {
        _htmlString = htmlString;
    }
}

- (void)configureView
{
    [self.webView1 loadHTMLString:self.htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
}

#pragma mark - UIWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        NSString *absoluteString = request.URL.absoluteString;
        
        NSRange range1 = [absoluteString rangeOfString:@"http://data-poison.lillyapps.no/" options:NSCaseInsensitiveSearch];
        NSRange range2 = [absoluteString rangeOfString:@"data-poison.lillyapps.no/" options:NSCaseInsensitiveSearch];
        
        BOOL isLocalLink = range1.location != NSNotFound || range2.location != NSNotFound;
        
        if (isLocalLink)
        {
            NSArray *stringArray = [request.URL.absoluteString componentsSeparatedByString:@"/"];
            NSString *slug = [stringArray objectAtIndex:stringArray.count-1];
            
            if([slug isEqualToString:@""])
                slug = [stringArray objectAtIndex:stringArray.count-2];
            
            BOOL isPoisonLink = [absoluteString rangeOfString:@"/poison/" options:NSCaseInsensitiveSearch].location != NSNotFound;
            
            if(isPoisonLink) {
            
                LPPoison *poison = [LPPoisonDataSource poisonWithSlug:slug];
            
                if(poison)
                {
                    UIStoryboard * storyboard = self.storyboard;
                    LPContentViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
                    
                    detail.htmlString = poison.htmlString;
                    
                    [self.navigationController pushViewController: detail animated: YES];
                    
                    return NO;
                }
            }
            else
            {
                LPTopic *topic = [LPTopicDataSource topicAtSlug:slug];
                
                if(topic)
                {
                    UIStoryboard * storyboard = self.storyboard;
                    LPContentViewController *detail = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
                    
                    detail.htmlString = topic.htmlString;
                    
                    [self.navigationController pushViewController: detail animated: YES];
                    
                    return NO;
                }

            }

        }

        UIApplication *appDelegate = [UIApplication sharedApplication];
        
        if([appDelegate openURL:request.URL])
            return NO;
        
    }
    
    return YES;
}

@end
