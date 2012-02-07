//
//  CPCoreDataPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/6/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPCoreDataPhotosTableViewHandler.h"
#import "Photo.h"


@implementation CPCoreDataPhotosTableViewHandler

#pragma mark Table view data source handler method

//- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;
//{
//	
//}
//
//- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell;
//{
//	
//}
//
//- (NSInteger)numberOfSectionsInIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
//{
//	
//}
//
//- (NSArray *)sectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
//{
//	
//}

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	NSString *returningString = nil;
	if ([[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count] > 0)
	{
		//NSString *elapsedHours = @"";
		//TODO: create an interface to return a string.
		//after checking key-value coding to see if:
		id element = [[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] objectAtIndex:0];
		if ([element isKindOfClass:[Photo class]])
		{
			Photo *photo = (Photo *)element;
			if ([photo.timeLapseSinceUpload intValue] == 0) 
				returningString = @"Right Now";
			else
				returningString = [[NSString stringWithFormat:@"%d",[photo.timeLapseSinceUpload intValue]] stringByAppendingString:@" Hour(s) Ago"];
		}
    }
    return returningString;
}

#pragma mark Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return;
}

@end
