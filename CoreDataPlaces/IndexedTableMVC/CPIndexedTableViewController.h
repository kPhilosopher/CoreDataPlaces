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
@protocol CPDataIndexDelegate;

@protocol CPTableViewHandling <NSObject>

#pragma mark - Required

@required

#pragma mark Table view data source handler method

- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell;

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

@property (retain) id<CPDataIndexDelegate> dataIndexDelegate;
@property (retain) id<CPTableViewHandling> tableViewHandler;
@property (retain) NSManagedObjectContext *managedObjectContext;

#pragma mark - Intialization

- (id)initWithStyle:(UITableViewStyle)style dataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate tableViewHandler:(id<CPTableViewHandling>)tableViewHandler;

#pragma mark - Helper method

- (CPRefinedElement *)refinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;

@end
