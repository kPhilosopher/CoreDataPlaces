//
//  CPTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTableViewHandler.h"
#import "CPRefinedElementInterfacing.h"
#import "CPIndexedTableViewController.h"


@implementation CPTableViewHandler

#pragma mark - Table view data source handler method

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;
{
    return [(NSArray *)[[indexedTableViewController theElementSections] objectAtIndex:section] count];
}

- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell;
{	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	id element = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	
	if ([element conformsToProtocol:@protocol(CPRefinedElementInterfacing)]) {
		id<CPRefinedElementInterfacing> elementWithInterface = (id<CPRefinedElementInterfacing>)element;
		cell.textLabel.text = elementWithInterface.title;
		cell.detailTextLabel.text = elementWithInterface.subtitle;
	}
	return cell;
}

- (NSInteger)numberOfSectionsInIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
    return [[indexedTableViewController theElementSections] count];
}

- (NSArray *)sectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
	return nil;
}

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	return nil;
}

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
	return 0;
}

#pragma mark Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	[indexedTableViewController.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
