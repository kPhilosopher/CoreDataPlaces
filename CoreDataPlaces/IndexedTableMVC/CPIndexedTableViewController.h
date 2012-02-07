//
//  CPIndexedTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/23/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CPDataIndexer.h"
#import "CPTableViewControllerDataMutating.h"
#import "CPTableViewControllerDataReloading.h"


@class CPDataIndexer;
@class CPIndexedTableViewController;
@class CPRefinedElement;
@protocol CPDataIndexHandling;

@protocol CPTableViewHandling <NSObject>
//the table view controller that utilizes an object that complies to this protocol should comply to CPTableViewControllerDataMutating.

#pragma mark - Required

@required

#pragma mark Table view data source handler method

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell;

#pragma mark - Optional

@optional

#pragma mark Table view data source handler method

- (NSInteger)numberOfSectionsInIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;

- (NSArray *)sectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;

- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

#pragma mark Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark -

@interface CPIndexedTableViewController : UITableViewController <CPTableViewControllerDataMutating, CPTableViewControllerDataReloading>

#pragma mark - Properties

@property (retain) id<CPDataIndexHandling> dataIndexHandler;
@property (retain) id<CPTableViewHandling> tableViewHandler;
@property (retain) NSManagedObjectContext *managedObjectContext;

#pragma mark - Intialization

- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler;

#pragma mark - Helper method

//- (CPRefinedElement *)refinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;
- (id)refinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;

@end
