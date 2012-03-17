//
//  CPPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewHandler-Internal.h"
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
			if ([self RD_currentDeviceIsiPodOriPhoneWithImageController:scrollableImageViewController])
			{
				[scrollableImageViewController.navigationController popViewControllerAnimated:NO];
				[indexedTableViewController.navigationController pushViewController:scrollableImageViewController animated:YES];
			}
		}
	}
	[indexedTableViewController.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Readability method
//TODO: find a unified place to put this method to reduce redundancy
- (BOOL)RD_currentDeviceIsiPodOriPhoneWithImageController:(UIViewController *)imageController;
{
	return imageController.view.window == nil;
}

@end
