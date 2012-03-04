//
//  CPMostRecentPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosTableViewHandler.h"
#import "CPIndexedTableViewController.h"
#import "CPMostRecentPhotosRefinedElementInterfacing.h"
#import "CPMostRecentPhotosRefinedElement.h"


@implementation CPMostRecentPhotosTableViewHandler

#pragma mark - Table view data source handler method

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;
{
    return [(NSArray *)[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count];
}

- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell;
{	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	id element = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	
	if ([element conformsToProtocol:@protocol(CPMostRecentPhotosRefinedElementInterfacing)]) {
		id<CPMostRecentPhotosRefinedElementInterfacing> elementWithInterface = (id<CPMostRecentPhotosRefinedElementInterfacing>)element;
		cell.textLabel.text = elementWithInterface.title;
		cell.detailTextLabel.text = elementWithInterface.subtitle;
	}
	return cell;
}

- (NSInteger)numberOfSectionsInIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
    return [[indexedTableViewController fetchTheElementSections] count];
}

- (NSArray *)sectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
	return nil;
}

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	NSString *returningString = nil;
	id undeterminedElement = [[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] lastObject];
	if ([[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count] > 0 &&
		[undeterminedElement isKindOfClass:[CPMostRecentPhotosRefinedElement class]])
	{
		CPMostRecentPhotosRefinedElement *refinedElement = (CPMostRecentPhotosRefinedElement *)undeterminedElement;
		NSString *timeIntervalInHours = refinedElement.comparable;
		if ([timeIntervalInHours intValue] == 0)
			returningString = @"Right Now";
        else
			returningString = [[NSString stringWithFormat:@"%d",[timeIntervalInHours intValue]] stringByAppendingString:@" Hour(s) Ago"];
    }
    return returningString;
}


- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
	return 0;
}

#pragma mark Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return;
}

@end
