//
//  LPDataSource.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPDataSource.h"
#import "LPAppDelegate.h"
#import "Term.h"
#import "LPEntryViewCell.h"
#import "LPInfoViewController.h"

@interface LPDataSource ()

@property (nonatomic) NSManagedObjectContext *context;

@property NSArray *poisonData;
@property NSArray *termData;
@property NSMutableArray *filteredData;
@property NSString *selectedKey;
@property NSString *searchString;

@end

@implementation LPDataSource

- (id)init {
    self = [super init];

    if(self)
    {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Poison"
                                                  inManagedObjectContext:self.context];
        NSSortDescriptor *nameSort = [[NSSortDescriptor alloc]initWithKey:@"name"  ascending:YES];
        
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:nameSort]];
        
        NSError *error;
        
        self.poisonData = [self.context executeFetchRequest:fetchRequest error:&error];
        for (Poison *poison in self.poisonData) {
//            NSLog(@"Poison: %@", poison.name);
        }
        
        if (error) {
            NSLog(@"Whoops, couldn't fetch: %@", [error localizedDescription]);
        }
    }
    
    return self;
}

- (NSManagedObjectContext *) context
{
    LPAppDelegate *appDelegate = (LPAppDelegate *)[UIApplication sharedApplication].delegate;
    
    return appDelegate.managedObjectContext;
}

- (void) filterContentForSearchText:(NSString*)searchText
{
    if(!self.filteredData)
        self.filteredData = [NSMutableArray arrayWithCapacity:self.poisonData.count];
    else
        [self.filteredData removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY SELF.synonyms.term beginswith[c] %@", searchText];
    self.filteredData = [NSMutableArray arrayWithArray:[self.filteredData filteredArrayUsingPredicate:predicate]];
    
    if(self.filteredData.count == 0)
    {
        predicate = [NSPredicate predicateWithFormat:@"ANY SELF.synonyms.term contains[c] %@", searchText];
        self.filteredData = [NSMutableArray arrayWithArray:[self.poisonData filteredArrayUsingPredicate:predicate]];
    }
}

- (Poison *) getPoisonAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.filteredData)
        return self.filteredData[indexPath.row];
    else
        return self.poisonData[indexPath.row];
}

#pragma mark - Search Display Delegate

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    self.filteredData = nil;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    self.searchString = searchString;
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    Poison *poisonEntry = [self getPoisonAtIndexPath:indexPath];
    
    NSString *synonymsString;
    
    for(Term *term in poisonEntry.synonyms)
    {
        if(!synonymsString)
            synonymsString = term.term;
        else
            synonymsString = [NSString stringWithFormat:@"%@, %@", synonymsString, term.term];
    }
    
    cell.textLabel.text = poisonEntry.name;
    cell.detailTextLabel.text = synonymsString;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
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