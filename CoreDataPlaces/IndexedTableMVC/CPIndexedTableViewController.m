//
//  CPIndexedTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/23/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"
#import "CPDataIndexer.h"


@interface CPIndexedTableViewController ()
{
@private
	id<CPDataIndexHandler> CP_dataIndexHandler;
	id<CPTableViewHandling> CP_tableViewHandler;
	NSManagedObjectContext *CP_managedObjectContext;
}
@end

#pragma mark -

@implementation CPIndexedTableViewController

#pragma mark - Synthesize

@synthesize dataIndexHandler = CP_dataIndexHandler;
@synthesize tableViewHandler = CP_tableViewHandler;
@synthesize managedObjectContext = CP_managedObjectContext;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandler>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler;
{
	self = [super initWithStyle:style];
	if (self) 
	{
		self.dataIndexHandler = dataIndexHandler;
		self.tableViewHandler = tableViewHandler;
	}
	return self;
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_dataIndexHandler release];
	[CP_tableViewHandler release];
	[super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if ([self fetchTheElementSections] == nil)
		[self indexTheTableViewData];
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
	 [self.dataIndexHandler indexedSectionsOfTheRawElementsArray:[self fetchTheRawData]]];
	[self.tableView reloadData];
}

@end
