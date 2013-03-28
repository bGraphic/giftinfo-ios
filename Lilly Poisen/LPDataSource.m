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
#import "LPContentViewController.h"

@interface LPDataSource ()

@property (nonatomic) NSManagedObjectContext *context;

@property NSArray *poisonData;
@property NSMutableArray *filteredData;
@property NSString *selectedKey;
@property NSString *searchString;

@end

@implementation LPDataSource

- (id)init {
    self = [super init];

    if(self)
    {
        [self loadPoisonData];
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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.name contains[c] %@) OR (ANY SELF.synonyms contains[c] %@)", searchText, searchText];
    
    self.filteredData = [NSMutableArray arrayWithArray:[self.poisonData filteredArrayUsingPredicate:predicate]];
    
//    if(self.filteredData.count == 0)
//    {
//        predicate = [NSPredicate predicateWithFormat:@"ANY SELF.synonyms contains[c] %@", searchText];
//        self.filteredData = [NSMutableArray arrayWithArray:[self.poisonData filteredArrayUsingPredicate:predicate]];
//    }
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

- (void) loadPoisonData
{
    
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:@"poisons" ofType:@"json"];

    NSData *data = [NSData dataWithContentsOfFile:contentPath];
    
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSLog(@"Error %@", error.description);
    
    NSLog(@"json dict: %@", [json description]);
    
    NSArray *poisonRawData = [json objectForKey:@"posts"];

    NSLog(@"raw data: %@", [poisonRawData description]);
    
//    NSString *propertyFile = [[NSBundle mainBundle] pathForResource:@"poison-data" ofType:@"plist"];
//    NSArray *poisonRawData = [NSArray arrayWithContentsOfFile:propertyFile];
//    
    NSMutableArray *poisonDataUnsorted = [NSMutableArray arrayWithCapacity:poisonRawData.count];
    
    for(NSDictionary *poisonDict in poisonRawData)
    {
        [poisonDataUnsorted addObject:[Poison poisonWithDict:poisonDict]];
    }

    NSSortDescriptor *lastDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"name"
                                ascending:YES
                                 selector:@selector(localizedCaseInsensitiveCompare:)];
    
    self.poisonData = [poisonDataUnsorted sortedArrayUsingDescriptors:[NSArray arrayWithObject:lastDescriptor]];
}

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
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF contains[c] %@)", self.searchString];
    
    
    NSString *synonymsString;
    
    for(NSString *synonym in [poisonEntry.synonyms filteredArrayUsingPredicate:predicate])
    {
        if(!synonymsString)
            synonymsString = synonym;
        else
            synonymsString = [NSString stringWithFormat:@"%@, %@", synonymsString, synonym];
    }
    
    cell.textLabel.text = poisonEntry.name;
    cell.detailTextLabel.text = synonymsString;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

@end