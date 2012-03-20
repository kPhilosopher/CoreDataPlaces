//
//  CPPlacesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPPlacesTableViewHandler.h"
#import "CPIndexedTableViewController.h"


@implementation CPPlacesTableViewHandler

#pragma mark Table view data source handler method

- (NSArray *)sectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
    if ([[indexedTableViewController.indexedRefinedElementSections objectAtIndex:section] count] > 0)
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    return nil;
}

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

@end
