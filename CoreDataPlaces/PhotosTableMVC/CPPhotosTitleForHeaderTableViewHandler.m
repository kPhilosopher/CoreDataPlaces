//
//  CPPhotosTitleForHeaderTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/15/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPPhotosTitleForHeaderTableViewHandler.h"
#import "CPIndexedTableViewController.h"
#import "CPRefinedElement.h"


@implementation CPPhotosTitleForHeaderTableViewHandler

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

@end
