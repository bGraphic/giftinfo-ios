//
//  LPDataSource.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPDataSource.h"
#import "LPAppDelegate.h"
#import "Poison.h"
#import "Term.h"
#import "LPEntryViewCell.h"
#import "LPInfoViewController.h"

@interface LPDataSource ()

@property NSArray *poisonData;
@property NSMutableArray *filteredData;
@property NSString *selectedKey;

@end

@implementation LPDataSource

- (id)init {
    self = [super init];

    if(self)
    {
        LPAppDelegate *appDelegate = (LPAppDelegate *)[UIApplication sharedApplication].delegate;
    
        NSManagedObjectContext *context = appDelegate.managedObjectContext;
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Poison"
                                                  inManagedObjectContext:context];
        
        [fetchRequest setEntity:entity];
        
        NSError *error;
        
        self.poisonData = [context executeFetchRequest:fetchRequest error:&error];
        for (Poison *poison in self.poisonData) {
            NSLog(@"Poison: %@", poison.name);
        }
        
        if (error) {
            NSLog(@"Whoops, couldn't fetch: %@", [error localizedDescription]);
        }
    }
    
    return self;
}

- (void) filterContentForSearchText:(NSString*)searchText
{
    if(!self.filteredData)
        self.filteredData = [NSMutableArray arrayWithCapacity:self.poisonData.count];
    else
        [self.filteredData removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name beginswith[c] %@", searchText];
    self.filteredData = [NSMutableArray arrayWithArray:[self.poisonData filteredArrayUsingPredicate:predicate]];
    
    if(self.filteredData.count == 0)
    {
        predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", searchText];
        self.filteredData = [NSMutableArray arrayWithArray:[self.poisonData filteredArrayUsingPredicate:predicate]];
    }
}

#pragma mark - Search Display Delegate

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    self.filteredData = nil;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{    
    [self filterContentForSearchText:searchString];

    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.filteredData)
        return self.filteredData.count;
    else
        return self.poisonData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PoisonCell";
    
    [tableView registerClass:[LPEntryViewCell class] forCellReuseIdentifier:CellIdentifier];
    LPEntryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Poison *poisonEntry;
    
    if(self.filteredData)
        poisonEntry = self.filteredData[indexPath.row];
    else
        poisonEntry = self.poisonData[indexPath.row];
    
    cell.textLabel.text = poisonEntry.name;
    
    for(Term *term in poisonEntry.synonyms)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", cell.detailTextLabel.text, term.term];
    }
    
    cell.key = poisonEntry.key;
    cell.name = poisonEntry.name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


@end