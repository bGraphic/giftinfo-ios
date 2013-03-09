//
//  LPDataSource.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 09.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPDataSource.h"
#import "LPEntry.h"

@interface LPDataSource ()

@property NSArray *poisonData;
@property NSMutableArray *filteredData;

@end

@implementation LPDataSource

- (id)init {
    self = [super init];

    if(self)
    {
        LPEntry *entry1 = [LPEntry entryWithKey:@"white-sprite" andName:@"White Sprite" withSynonyms:@"hvit sprit"];
        LPEntry *entry2 = [LPEntry entryWithKey:@"baby-oil" andName:@"Baby Oil" withSynonyms:@"barne olje"];
        LPEntry *entry3 = [LPEntry entryWithKey:@"petrol" andName:@"Bensin" withSynonyms:@"petrol"];
        LPEntry *entry4 = [LPEntry entryWithKey:@"test" andName:@"Test" withSynonyms:@"test, prøve, hei på deg, hei"];
        
        
        self.poisonData = [NSArray arrayWithObjects:entry1, entry2, entry3, entry4, nil];
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
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    

    LPEntry *poisonEntry;
    
    if(self.filteredData)
        poisonEntry = self.filteredData[indexPath.row];
    else
        poisonEntry = self.poisonData[indexPath.row];
    
    cell.textLabel.text = poisonEntry.name;
    
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