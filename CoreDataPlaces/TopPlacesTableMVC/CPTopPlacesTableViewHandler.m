//
//  CPTopPlacesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/6/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
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
		CPPhotosTableViewController *photosTableViewController = [CPPhotosTableViewController photosTableViewControllerWithRefinedElement:placesRefinedElement manageObjectContext:indexedTableViewController.managedObjectContext];
		[indexedTableViewController.navigationController pushViewController:photosTableViewController animated:YES];
	}
	[super indexedTableViewController:indexedTableViewController didSelectRowAtIndexPath:indexPath];
}

@end
