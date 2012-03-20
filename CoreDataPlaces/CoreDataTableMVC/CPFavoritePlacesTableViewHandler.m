//
//  CPFavoritePlacesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPFavoritePlacesTableViewHandler.h"
#import "CPPlacesRefinedElement.h"
#import "Place.h"
#import "CPCoreDataTableViewController.h"


@implementation CPFavoritePlacesTableViewHandler

#pragma mark - Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	if ([refinedElement.rawElement isKindOfClass:[Place class]])
	{
		Place *chosenPlace = (Place *)refinedElement.rawElement;
		CPCoreDataTableViewController *coreDataPhotosTableViewController = [CPCoreDataTableViewController coreDataPhotosTableViewControllerWithPlace:chosenPlace manageObjectContext:indexedTableViewController.managedObjectContext];
		[indexedTableViewController.navigationController pushViewController:coreDataPhotosTableViewController animated:YES];
	}
	[super indexedTableViewController:indexedTableViewController didSelectRowAtIndexPath:indexPath];
}

@end
