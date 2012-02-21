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

#pragma mark - Table view data source handler method

//TODO: refactor this method.
- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	NSString *returningString = nil;
	if ([[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count] > 0)
	{
		//TODO: create an interface to return a string.
		//after checking key-value coding to see if:
		CPRefinedElement *refinedElement = [[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] objectAtIndex:0];
		NSString *elapsedHours = refinedElement.comparable;
		if ([elapsedHours intValue] == 0) 
			returningString = @"Right Now";
        else
			returningString = [[NSString stringWithFormat:@"%d",[elapsedHours intValue]] stringByAppendingString:@" Hour(s) Ago"];
    }
    return returningString;
}

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
			//TODO: pass the place_id into photosRefinedElement, not the managed object.
			photosRefinedElement.itsPlace = photosTableViewController.currentPlace;
			CPScrollableImageViewController *scrollableImageViewController = [CPScrollableImageViewController sharedInstance];
			scrollableImageViewController.photosRefinedElement = photosRefinedElement;
			scrollableImageViewController.title = photosRefinedElement.title;
			if ([self RD_currentDeviceIsiPodOriPhoneWithImageController:scrollableImageViewController])
			{
				[scrollableImageViewController.navigationController popViewControllerAnimated:NO];
				//TODO: change to only pass the managedobject with the url.
				[indexedTableViewController.navigationController pushViewController:scrollableImageViewController animated:YES];
			}
//			else if ([UIApplication sharedApplication].keyWindow.bounds.size.width > 500.0)
//			{
//				
//			}
		}
	}
	[indexedTableViewController.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Readability method

- (BOOL)RD_currentDeviceIsiPodOriPhoneWithImageController:(UIViewController *)imageController;
{
	return imageController.view.window == nil;
}

@end
