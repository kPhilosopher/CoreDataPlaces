//
//  CPMostRecentPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosTableViewHandler.h"
#import "Photo+Logic.h"
#import "CPIndexedTableViewController.h"
#import "CPRefinedElement.h"
#import "CPScrollableImageViewController.h"


@implementation CPMostRecentPhotosTableViewHandler

#pragma mark - Table view data source handler method

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	NSString *returningString = nil;
	id undeterminedElement = [[[indexedTableViewController theElementSections] objectAtIndex:section] lastObject];
	if ([[[indexedTableViewController theElementSections] objectAtIndex:section] count] > 0 &&
		[undeterminedElement isKindOfClass:[CPRefinedElement class]])
	{
		CPRefinedElement *refinedElement = (CPRefinedElement *)undeterminedElement;
		NSString *timeIntervalInHours = refinedElement.comparable;
		if ([timeIntervalInHours intValue] == 0)
			returningString = @"Right Now";
        else
			returningString = [[NSString stringWithFormat:@"%d",[timeIntervalInHours intValue]] stringByAppendingString:@" Hour(s) Ago"];
    }
    return returningString;
}

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
		CPScrollableImageViewController *scrollableImageViewController = [CPScrollableImageViewController sharedInstance];
		scrollableImageViewController.title = chosenPhoto.title;
		[scrollableImageViewController setNewCurrentPhoto:chosenPhoto.rawElement];
		if ([self RD_currentDeviceIsiPodOriPhoneWithImageController:scrollableImageViewController])
		{
			[scrollableImageViewController.navigationController popViewControllerAnimated:NO];
			[indexedTableViewController.navigationController pushViewController:scrollableImageViewController animated:YES];
		}
	}
	[indexedTableViewController.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
