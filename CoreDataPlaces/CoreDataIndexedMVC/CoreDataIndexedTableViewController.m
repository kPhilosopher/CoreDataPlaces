//
//  CoreDataIndexedTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/5/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CoreDataIndexedTableViewController.h"
#import "CPTableViewControllerDataMutating.h"
#import "CPTableViewHandler.h"


@implementation CoreDataIndexedTableViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [self.tableViewHandler numberOfSectionsInIndexedTableViewController:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
        cell = 
		[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	
	return [self.tableViewHandler indexedTableViewController:self cellForRowAtIndexPath:indexPath cell:cell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.tableViewHandler indexedTableViewController:self numberOfRowsInSection:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return [self.tableViewHandler sectionIndexTitlesForIndexedTableViewController:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self.tableViewHandler indexedTableViewController:self titleForHeaderInSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return [self.tableViewHandler indexedTableViewController:self sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark - Table view delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return [self.tableViewHandler indexedTableViewController:self didSelectRowAtIndexPath:indexPath];
}

#pragma mark - CPTableViewControllerDataMutating protocol method

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array;
{
	NSLog(@"should not be calling setTheElementSectionsToTheFollowingArray in coredatacontroller");
	abort();
	return;
}

- (NSMutableArray *)fetchTheElementSections;
{
	return [NSMutableArray arrayWithArray:[self.fetchedResultsController fetchedObjects]];
}

- (NSArray *)fetchTheRawData;
{
	NSLog(@"should not be calling fetchTheRawData in coredatacontroller");
	abort();
	return nil;
}

@end
