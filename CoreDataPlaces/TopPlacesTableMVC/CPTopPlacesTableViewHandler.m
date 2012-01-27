//
//  CPTopPlacesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

//#import "CPTopPlacesTableViewHandler.h"
#import "CPTopPlacesTableViewController.h"

@implementation CPTopPlacesTableViewHandler


#pragma mark - Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSDictionary *dictionaryToAddToMostRecentList = refinedElement.dictionary;
	if ([indexedTableViewController isKindOfClass:[CPTopPlacesTableViewController class]]) 
	{
		CPTopPlacesTableViewController *topPlacesTableViewController = (CPTopPlacesTableViewController *)indexedTableViewController;
		[topPlacesTableViewController.flickrDataSource addToTheMostRecentPlacesCollectionsTheFollowingDictionary:dictionaryToAddToMostRecentList];
//		[topPlacesTableViewController.delegateToUpdateMostRecentPlaces indexTheTableViewData];
	}
	
	[super indexedTableViewController:indexedTableViewController didSelectRowAtIndexPath:indexPath];
}

@end
