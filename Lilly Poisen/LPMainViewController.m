//
//  LPMainViewController.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPMainViewController.h"
#import "LPInfoViewController.h"
#import "LPEntryViewCell.h"

@interface LPMainViewController ()

@end

@implementation LPMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.toolbarItems = self.navigationController.toolbarItems;
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
        [[segue destinationViewController] setContentKey:cell.reuseIdentifier];
        [[segue destinationViewController] setTitle:cell.textLabel.text];
    }
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:tableView.indexPathForSelectedRow];
    
    if([cell isKindOfClass:[LPEntryViewCell class]])
    {
        LPEntryViewCell *entryCell = (LPEntryViewCell *) cell;
        
        UIStoryboard * storyboard = self.storyboard;
        
        LPInfoViewController * detail = [storyboard instantiateViewControllerWithIdentifier:@"contentView"];
        
        detail.contentKey = entryCell.key;
        detail.title = entryCell.name;
        
        NSLog(@"%@", entryCell.key);
        
        [self.navigationController pushViewController: detail animated: YES];
    }
    else if(cell.reuseIdentifier)
    {
        [self performSegueWithIdentifier:@"showContent" sender:self];
    }
}

@end
