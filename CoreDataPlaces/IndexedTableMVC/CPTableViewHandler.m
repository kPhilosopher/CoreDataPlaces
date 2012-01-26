//
//  CPTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/25/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPTableViewHandler.h"

@implementation CPTableViewHandler

#pragma mark - Table view data source handler method

- (NSArray *)handleSectionIndexTitlesForIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController;
{
	return nil;
}

- (NSString *)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
    return nil;
}

- (NSInteger)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    return nil;
}
- (UITableViewCell *)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return nil;
}

#pragma mark - Table view delegate handler method

- (void)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return;
}

@end
