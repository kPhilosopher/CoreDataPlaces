//
//  CPPlacesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/25/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

//#import "CPTopPlacesTableViewController.h"
#import "CPPlacesTableViewHandler.h"
#import "NSString+TitleExtraction.h"
#import "NSString+FindCharacterInSet.h"

@implementation CPPlacesTableViewHandler

#pragma mark - Table view data source handler method

- (NSInteger)numberOfSectionsInIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
    return [[indexedTableViewController fetchTheElementSections] count];
}

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;
{
    return [(NSArray *)[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count];
}

- (NSArray *)sectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	
    if ([[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count] > 0)
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    return nil;
}

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

//TODO: refactor this method
- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [indexedTableViewController.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
        cell = 
		[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	
	cell.detailTextLabel.text = @"";
	cell.textLabel.text = @"";
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSString *contentString = [refinedElement.dictionary objectForKey:@"_content"];
	cell.textLabel.text = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
	
	if ([contentString enumerateStringToDetermineTheExistanceOfCharacterInSet:[NSString characterSetWithComma]])
	{
		int startingIndexOfSubTitle = [contentString rangeOfCharacterFromSet:[NSString characterSetWithComma]].location + 1;
		NSString *subTitle = [contentString substringFromIndex:startingIndexOfSubTitle +1];
		cell.detailTextLabel.text = [subTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	return cell;
}

#pragma mark - Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSString *placeId = [refinedElement.dictionary objectForKey:@"place_id"];
	
	
	
	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
	NSLog(placeId);
	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
	
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//	
//	//this call needs to be done in a block in the photoListController
//	NSArray *photoList = [indexedTableViewController.flickrDataSource photoListWithFlickrPlaceID:placeId];
//	
//	if ([photoList count] > 0)
//	{
//		//change the initializer to accept the refinedElement, not the picture list
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

@end
