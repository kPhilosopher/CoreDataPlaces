//
//  CPTableViewHandler.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/25/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndexedTableViewController.h"

@interface CPTableViewHandler : NSObject

#pragma mark - Table view data source handler method

- (NSArray *)handleSectionIndexTitlesForIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController;

- (NSString *)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;

- (NSInteger)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

- (UITableViewCell *)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Table view delegate handler method

- (void)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
