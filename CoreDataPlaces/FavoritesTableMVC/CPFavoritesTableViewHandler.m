//
//  CPFavoritesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/6/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPFavoritesTableViewHandler.h"


@implementation CPFavoritesTableViewHandler

#pragma mark - Table view data source handler method

- (NSArray *)sectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
    if ([[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count] > 0)
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    return nil;
}

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

#pragma mark - Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
//	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
//	CPPlacesRefinedElement *placesRefinedElement;
//	if ([refinedElement isKindOfClass:[CPPlacesRefinedElement class]])
//	{
//		placesRefinedElement = (CPPlacesRefinedElement *)refinedElement;
//		//TODO:change the interface to pass the managedobject, not the refinedElement.
//		CPPhotosTableViewController *photosTableViewController = [CPPhotosTableViewController photosTableViewControllerWithRefinedElement:placesRefinedElement manageObjectContext:indexedTableViewController.managedObjectContext];
//		[indexedTableViewController.navigationController pushViewController:photosTableViewController animated:YES];
//	}
}

@end
