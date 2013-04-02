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

static NSString *headerString;
static NSString *footerString;
static NSString *summaryString;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self configureView];
    
    self.toolbarItems = self.navigationController.toolbarItems;
    self.webView1.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.webView1.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 10, 0);
    
    self.webView1.scrollView.bounces = NO;
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
        if(!headerString)
            headerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"header"];
        
        if(!footerString)
            footerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"footer"];
        
        if(!summaryString)
            summaryString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"summary"];
        
        NSString *htmlString;
        
        if(self.topic)
        {
            NSString *headerWithData = [NSString stringWithFormat:headerString, self.topic.title, @""];
            
            htmlString = [NSString stringWithFormat:@"%@\n%@\n%@", headerWithData, self.topic.content, footerString];
        }
        else if (self.poison)
        {
            NSString *summaryWithData = [NSString stringWithFormat:summaryString, self.poison.risk, self.poison.symptoms, self.poison.coal?@"Ja":@"Nei", self.poison.action?self.poison.action:@"Ingen spesielle tiltak"];
            
            NSString *headerWithData = [NSString stringWithFormat:headerString, self.poison.name, [LPHtmlStringHelper stringFromArray:self.poison.otherNames withSeperator:@", "]];
            
            htmlString = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", headerWithData, summaryWithData, self.poison.content, footerString];
        }
        
        
        [self.webView1 loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    }
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
                    
                    detail.poison = poison;
                    
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
                    
                    detail.topic = topic;
                    
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
