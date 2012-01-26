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
	CPDataIndexer *CP_dataIndexer;
	CPTableViewHandler *CP_tableViewHandler;
}
@end

@implementation CPIndexedTableViewController

#pragma mark - Synthesize

@synthesize dataIndexer = CP_dataIndexer;
@synthesize tableViewHandler = CP_tableViewHandler;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style withDataIndexer:(CPDataIndexer *)dataIndexer withTableViewHandler:(CPTableViewHandler *)tableViewHandler;
{
	self = [super initWithStyle:style];
	if (self) {
		self.dataIndexer = dataIndexer;
		self.tableViewHandler = tableViewHandler;
	}
	return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSMutableArray *indexedSections = [self.dataIndexer returnTheIndexedSectionsOfTheGiven:[self fetchTheRawData]];
	[self setTheElementSectionsToTheFollowingArray:indexedSections];
}

- (void)dealloc
{
	[CP_tableViewHandler release];
	[CP_dataIndexer release];
	[super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return [[self fetchTheElementSections] count];
	[self.tableViewHandler handleNumberOfSectionsInIndexedTableViewController:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [(NSArray *)[[self fetchTheElementSections] objectAtIndex:section] count];
	return [self.tableViewHandler handleIndexedTableViewController:self numberOfRowsInSection:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
	return [self.tableViewHandler handleSectionIndexTitlesForIndexedTableViewController:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if ([[[self fetchTheElementSections] objectAtIndex:section] count] > 0)
//        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
//    return nil;
	return [self.tableViewHandler handleIndexedTableViewController:self titleForHeaderInSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
	return [self.tableViewHandler handleIndexedTableViewController:self sectionForSectionIndexTitle:title atIndex:index];
}

//TODO: refactor this method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self.tableViewHandler handleIndexedTableViewController:self cellForRowAtIndexPath:indexPath];
	//    static NSString *CellIdentifier = @"Cell";
	//    
	//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	//    if (cell == nil) 
	//        cell = 
	//		[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	//	
	//	cell.detailTextLabel.text = @"";
	//	cell.textLabel.text = @"";
	//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	//	
	//	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	//	NSString *contentString = [refinedElement.dictionary objectForKey:@"_content"];
	//	cell.textLabel.text = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
	//	
	//	if ([contentString enumerateStringToDetermineTheExistanceOfCharacterInSet:[NSString characterSetWithComma]])
	//	{
	//		int startingIndexOfSubTitle = [contentString rangeOfCharacterFromSet:[NSString characterSetWithComma]].location + 1;
	//		NSString *subTitle = [contentString substringFromIndex:startingIndexOfSubTitle +1];
	//		cell.detailTextLabel.text = [subTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	//	}
	//	return cell;
}

#pragma mark - Table view delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	return [self.tableViewHandler handleIndexedTableViewController:self didSelectRowAtIndexPath:indexPath];
	//	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	//	NSString *placeId = [refinedElement.dictionary objectForKey:@"place_id"];
	//	
	//	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	//	
	//	NSArray *photoList = [self.flickrDataSource photoListWithFlickrPlaceID:placeId];
	//	
	//	if ([photoList count] > 0)
	//	{
	//		PictureListTableViewController *pltvc = [[PictureListTableViewController alloc] initWithStyle:UITableViewStylePlain withPictureList:photoList];
	//		pltvc.delegate = self.delegateToTransfer;
	//		
	//		NSString *contentString = [refinedElement.dictionary objectForKey:@"_content"];
	//		pltvc.title = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
	//		
	//		[self.navigationController pushViewController:pltvc animated:YES];
	//		[pltvc release];
	//	}
	//	
	//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

@end
