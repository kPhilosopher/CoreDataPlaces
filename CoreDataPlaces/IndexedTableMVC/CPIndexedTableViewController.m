//
//  CPIndexedTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/23/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"
#import "CPIndexAssistant.h"
#import "CPRefinary.h"
#import "CPDataIndexer.h"
#import "CPTableViewHandler.h"


@interface CPIndexedTableViewController ()
{
@private
	NSArray *CP_listOfRawElements;
	NSMutableArray *CP_indexedRefinedElementSections;
	CPRefinary *CP_refinary;
	CPDataIndexer *CP_dataIndexer;
	CPTableViewHandler *CP_tableViewHandler;
	CPRefinedElement *CP_refinedElementType;
	NSManagedObjectContext *CP_managedObjectContext;
	NSIndexPath *CP_selectedIndexPath;
}
@end

#pragma mark -

@implementation CPIndexedTableViewController

#pragma mark - Synthesize

@synthesize listOfRawElements = CP_listOfRawElements;
@synthesize indexedRefinedElementSections = CP_indexedRefinedElementSections;
@synthesize refinary = CP_refinary;
@synthesize dataIndexer = CP_dataIndexer;
@synthesize tableViewHandler = CP_tableViewHandler;
@synthesize refinedElementType = CP_refinedElementType;
@synthesize managedObjectContext = CP_managedObjectContext;
@synthesize selectedIndexPath = CP_selectedIndexPath;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	self = [super initWithStyle:style];
	if (self) 
	{
		self.refinary = indexAssistant.refinary;
		self.dataIndexer = indexAssistant.dataIndexer;
		self.tableViewHandler = indexAssistant.tableViewHandler;
		self.refinedElementType = indexAssistant.refinedElementType;
		self.managedObjectContext = managedObjectContext;
	}
	return self;
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_listOfRawElements release];
	[CP_indexedRefinedElementSections release];
	[CP_refinary release];
	[CP_dataIndexer release];
	[CP_tableViewHandler release];
	[CP_refinedElementType release];
	[CP_managedObjectContext release];
	[CP_selectedIndexPath release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewDidAppear:animated];
	if (self.selectedIndexPath  && [self.tableView indexPathsForVisibleRows])
	{
		[self.tableView scrollToRowAtIndexPath:self.selectedIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
		self.selectedIndexPath = nil;
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeLeft));
}

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
	self.selectedIndexPath = indexPath;
	return [self.tableViewHandler indexedTableViewController:self didSelectRowAtIndexPath:indexPath];
}

#pragma mark - Helper method

- (id)refinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;
{
	return [(NSArray *)[self.indexedRefinedElementSections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

#pragma mark - DataReloadForTableViewControllerProtocol implementation

- (void)indexTheTableViewData
{
	if (self.dataIndexer && self.refinary && self.refinedElementType && self.listOfRawElements) 
	{
		NSArray *refinedElements = [self.refinary refinedElementsWithGivenRefinedElementType:self.refinedElementType rawElements:self.listOfRawElements];
		self.indexedRefinedElementSections = [self.dataIndexer indexedSectionsOfRefinedElements:refinedElements];
		[self.tableView reloadData];
	}
}

@end
