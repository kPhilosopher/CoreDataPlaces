//
//  CPCoreDataPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/6/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPCoreDataPhotosTableViewHandler.h"
#import "CPIndexedTableViewController.h"
#import "CPRefinedElement.h"
#import "CPScrollableImageViewController.h"
#import "Photo+Logic.h"


@implementation CPCoreDataPhotosTableViewHandler

#pragma mark Table view delegate handler method

//TODO: create a file that has this method for all classes that use it, or create an inheritance or strategy re-architecture to reduce redundancy.
- (BOOL)RD_currentDeviceIsiPodOriPhoneWithImageController:(UIViewController *)imageController;
{
	return imageController.view.window == nil;
}

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	id undeterminedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	if ([undeterminedElement isKindOfClass:[CPRefinedElement class]])
	{
		CPRefinedElement *chosenPhoto = (CPRefinedElement *)undeterminedElement;
		if ([chosenPhoto.rawElement isKindOfClass:[Photo class]]) 
		{
			CPScrollableImageViewController *scrollableImageViewController = [CPScrollableImageViewController sharedInstance];
			[scrollableImageViewController setNewCurrentPhoto:chosenPhoto.rawElement];
			if ([self RD_currentDeviceIsiPodOriPhoneWithImageController:scrollableImageViewController])
			{
				[scrollableImageViewController.navigationController popViewControllerAnimated:NO];
				[indexedTableViewController.navigationController pushViewController:scrollableImageViewController animated:YES];
			}
		}
	}
	[indexedTableViewController.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
