//
//  LPMainViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPMainViewController.h"
#import "LPInfoViewController.h"
#import "Poison+LPEntry.h"

@interface LPMainViewController ()

@end

@implementation LPMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.dataSource = self;
    
    CGRect toolbarFrame = self.navigationController.toolbar.frame;
    toolbarFrame.size.height += 10;
    toolbarFrame.origin.y -= 5;
    self.navigationController.toolbar.frame = toolbarFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.tableView.indexPathForSelectedRow];
    
    if([segue.identifier isEqualToString:@"showContent"] && cell.reuseIdentifier)
    {
        NSString *contentPath = [[NSBundle mainBundle] pathForResource:cell.reuseIdentifier ofType:@"html"];
        
        NSError *contentError;
        NSString *contentString = [NSString stringWithContentsOfFile:contentPath encoding:NSUTF8StringEncoding error:&contentError];
        
        if(contentError)
            NSLog(@"Problems loading content %@", contentError.description);

        
        [[segue destinationViewController] setHtmlContentString:contentString];
        [[segue destinationViewController] setTitle:cell.textLabel.text];
    }
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(self.tableView != tableView)
    {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else if(cell.reuseIdentifier)
    {
        [self performSegueWithIdentifier:@"showContent" sender:self];
    }
}

@end
