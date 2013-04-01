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

BOOL webView1HasLoaded;
BOOL webView2HasLoaded;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.webView1.delegate = self;
    self.webView2.delegate = self;
    
    [self configureView];
    
    self.toolbarItems = self.navigationController.toolbarItems;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 10, 0);
    
    self.webView1.scrollView.bounces = NO;
    self.webView2.scrollView.bounces = NO;
    
    self.title = @"Giftinfo";
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
            headerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"header"];
        }
        
        if(!footerString) {
            footerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"footer"];
        }
        
        if(!summaryString) {
            summaryString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"summary"];
        }
        
        NSString *htmlString1;
        NSString *htmlString2;
        
        if(self.topic)
        {
            htmlString1 = [NSString stringWithFormat:@"%@\n%@\n%@", headerString, self.topic.content, footerString];
        }
        else if (self.poison)
        {
            NSString *summaryWithData = [NSString stringWithFormat:summaryString, self.poison.risk, self.poison.symptoms, self.poison.coal?@"Ja":@"Nei", self.poison.action];
            
            htmlString1 = [NSString stringWithFormat:@"%@\n%@\n%@", headerString, summaryWithData, footerString];
            htmlString2 = [NSString stringWithFormat:@"%@\n%@\n%@", headerString, self.poison.content, footerString];
        }
        
        
        [self.webView1 loadHTMLString:htmlString1 baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
        [self.webView2 loadHTMLString:htmlString2 baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] resourcePath]]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return self.webView1.frame.size.height + 10.f;
    else
        return self.webView2.frame.size.height + 10.f;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(self.topic)
        return self.topic.title;
    else if(section == 0)
        return self.poison.name;
    else
        return @"Mer informasjon";
}

- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.poison)
        return 2;
    
    return 1;
}

- (void)viewDidUnload {
    [self setWebView1:nil];
    [self setWebView2:nil];
    [self setWebView2:nil];
    [super viewDidUnload];
}

- (void) calculateWebViewSize {
    
    [self.webView1 sizeToFit];
    [self.webView2 sizeToFit];
    
    [self.tableView reloadData];
}

#pragma mark - UIWebViewDelegate

- (void) webViewDidFinishLoad:(UIWebView *)sender {
    if(sender == self.webView1)
        webView1HasLoaded = YES;
    else
        webView2HasLoaded = YES;
    
    if(webView1HasLoaded && webView2HasLoaded)
        [self performSelector:@selector(calculateWebViewSize) withObject:nil afterDelay:0.1];
}

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
