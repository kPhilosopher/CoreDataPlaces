//
//  CPPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewHandler.h"
#import "CPPhotosRefinedElement.h"
#import "CPScrollableImageViewController.h"
#import "CPPhotosTableViewController.h"


@implementation CPPhotosTableViewHandler

#pragma mark - Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	CPPhotosRefinedElement *photosRefinedElement = nil;
	if ([refinedElement isKindOfClass:[CPPhotosRefinedElement class]])
	{
		CPPhotosTableViewController *photosTableViewController = nil;
		if ([indexedTableViewController isKindOfClass:[CPPhotosTableViewController class]]) 
		{
			photosTableViewController = (CPPhotosTableViewController *)indexedTableViewController;
			photosRefinedElement = (CPPhotosRefinedElement *)refinedElement;
			Place *currentPlace = [CPPhotosTableViewController placeWithPlaceRefinedElement:photosTableViewController.placeRefinedElement managedObjectContext:indexedTableViewController.managedObjectContext];
			CPScrollableImageViewController *scrollableImageViewController = [CPScrollableImageViewController sharedInstance];
			[scrollableImageViewController setupNewPhotoWithPhotoRefinedElement:photosRefinedElement place:currentPlace];
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
			{
				[scrollableImageViewController.navigationController popViewControllerAnimated:NO];
				[indexedTableViewController.navigationController pushViewController:scrollableImageViewController animated:YES];
			}
		}
	}
	[indexedTableViewController.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
