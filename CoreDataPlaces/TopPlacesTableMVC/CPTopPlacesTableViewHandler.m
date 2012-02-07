//
//  CPTopPlacesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/6/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPTopPlacesTableViewHandler.h"
#import "CPPlacesRefinedElement.h"
#import "CPPhotosTableViewController.h"


@implementation CPTopPlacesTableViewHandler

#pragma mark - Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	CPPlacesRefinedElement *placesRefinedElement;
	if ([refinedElement isKindOfClass:[CPPlacesRefinedElement class]])
	{
		placesRefinedElement = (CPPlacesRefinedElement *)refinedElement;
		//TODO:change the interface to pass the managedobject, not the refinedElement.
		CPPhotosTableViewController *photosTableViewController = [CPPhotosTableViewController photosTableViewControllerWithRefinedElement:placesRefinedElement manageObjectContext:indexedTableViewController.managedObjectContext];
		[indexedTableViewController.navigationController pushViewController:photosTableViewController animated:YES];
	}
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
