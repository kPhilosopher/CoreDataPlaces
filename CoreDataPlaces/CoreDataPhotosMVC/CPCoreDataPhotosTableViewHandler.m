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
#import "Photo.h"


@implementation CPCoreDataPhotosTableViewHandler

#pragma mark Table view delegate handler method

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
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
			{
				[scrollableImageViewController.navigationController popViewControllerAnimated:NO];
				[indexedTableViewController.navigationController pushViewController:scrollableImageViewController animated:YES];
			}
		}
	}
	[super indexedTableViewController:indexedTableViewController didSelectRowAtIndexPath:indexPath];
}

@end
