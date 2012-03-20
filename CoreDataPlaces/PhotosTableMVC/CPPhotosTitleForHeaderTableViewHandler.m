//
//  CPPhotosTitleForHeaderTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/15/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTitleForHeaderTableViewHandler.h"
#import "CPIndexedTableViewController.h"
#import "CPRefinedElement.h"


@implementation CPPhotosTitleForHeaderTableViewHandler

#pragma mark - Table view data source handler method

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	NSString *returningString = nil;
	id undeterminedElement = [[indexedTableViewController.indexedRefinedElementSections objectAtIndex:section] lastObject];
	if ([[indexedTableViewController.indexedRefinedElementSections objectAtIndex:section] count] > 0 &&
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

@end
