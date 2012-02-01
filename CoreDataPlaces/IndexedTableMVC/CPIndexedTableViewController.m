//
//  CPIndexedTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/23/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPIndexedTableViewController.h"

@interface CPIndexedTableViewController ()
{
@private
	id<CPDataIndexDelegate> CP_dataIndexDelegate;
	id<CPTableViewDelegate> CP_tableViewHandlingDelegate;
	NSManagedObjectContext *CP_managedObjectContext;
}
@end

@implementation CPIndexedTableViewController

#pragma mark - Synthesize

@synthesize dataIndexDelegate = CP_dataIndexDelegate;
@synthesize tableViewHandlingDelegate = CP_tableViewHandlingDelegate;
@synthesize managedObjectContext = CP_managedObjectContext;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style withDataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate withTableViewHandler:(id<CPTableViewDelegate>)tableViewHandlingDelegate;
{
	self = [super initWithStyle:style];
	if (self) 
	{
		self.dataIndexDelegate = dataIndexDelegate;
		self.tableViewHandlingDelegate = tableViewHandlingDelegate;
	}
	return self;
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_dataIndexDelegate release];
	[CP_tableViewHandlingDelegate release];
	[super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if ([self fetchTheElementSections] == nil)
		[self indexTheTableViewData];
	return [self.tableViewHandlingDelegate numberOfSectionsInIndexedTableViewController:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
        cell = 
		[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	
	return [self.tableViewHandlingDelegate indexedTableViewController:self cellForRowAtIndexPath:indexPath withCell:cell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.tableViewHandlingDelegate indexedTableViewController:self numberOfRowsInSection:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return [self.tableViewHandlingDelegate sectionIndexTitlesForIndexedTableViewController:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self.tableViewHandlingDelegate indexedTableViewController:self titleForHeaderInSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return [self.tableViewHandlingDelegate indexedTableViewController:self sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark - Table view delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{	
	return [self.tableViewHandlingDelegate indexedTableViewController:self didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Helper method

- (CPRefinedElement *)refinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;
{
	return [(NSArray *)[[self fetchTheElementSections] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

#pragma mark - CPTableViewControllerDataMutating protocol method

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array;
{
	return;
}

- (NSMutableArray *)fetchTheElementSections;
{
	return nil;
}

- (NSArray *)fetchTheRawData;
{
	return nil;
}

#pragma mark - DataReloadForTableViewControllerProtocol implementation

- (void)indexTheTableViewData
{
	[self setTheElementSectionsToTheFollowingArray:
	 [self.dataIndexDelegate indexedSectionsOfTheRawElementsArray:[self fetchTheRawData]]];
	[self.tableView reloadData];
}

@end
