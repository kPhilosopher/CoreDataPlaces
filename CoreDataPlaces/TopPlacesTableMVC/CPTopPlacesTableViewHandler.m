//
//  CPTopPlacesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/6/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTopPlacesTableViewHandler.h"
#import "CPRefinedElement.h"
#import "CPTopPlacesTableViewController.h"
//#import "CPPhotosTableViewController.h"


@implementation CPTopPlacesTableViewHandler

#pragma mark - Table view delegate handler method

- (NSArray *)sectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
    if ([[[indexedTableViewController theElementSections] objectAtIndex:section] count] > 0)
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    return nil;
}

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
//	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
//	CPPlacesRefinedElement *placesRefinedElement;
//	if ([refinedElement isKindOfClass:[CPRefinedElement class]])
//	{
//		placesRefinedElement = (CPPlacesRefinedElement *)refinedElement;
//		//TODO:change the interface to pass the managedobject, not the refinedElement.
//		CPPhotosTableViewController *photosTableViewController = [CPPhotosTableViewController photosTableViewControllerWithRefinedElement:placesRefinedElement manageObjectContext:indexedTableViewController.managedObjectContext];
//		[indexedTableViewController.navigationController pushViewController:photosTableViewController animated:YES];
//	}
	
	
	
	
	
	
	
	
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
