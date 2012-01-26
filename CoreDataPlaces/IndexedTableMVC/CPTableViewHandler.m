//
//  CPTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/25/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPIndexedTableViewController.h"
//#import "CPTableViewHandler.h"

@implementation CPTableViewHandler

#pragma mark - Table view data source handler method

- (NSInteger)handleNumberOfSectionsInIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
//    return [[self fetchTheElementSections] count];
	return nil;
}

- (NSInteger)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;
{
//    return [(NSArray *)[[self fetchTheElementSections] objectAtIndex:section] count];
	return nil;
}

- (NSArray *)handleSectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
{
	return nil;
}

- (NSString *)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
    return nil;
}

- (NSInteger)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    return nil;
}
- (UITableViewCell *)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return nil;
}

#pragma mark - Table view delegate handler method

- (void)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return;
}

@end
