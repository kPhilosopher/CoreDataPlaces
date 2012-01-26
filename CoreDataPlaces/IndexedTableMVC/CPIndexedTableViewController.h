//
//  CPIndexedTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/23/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPDataIndexer.h"
//#import "CPTableViewHandler.h"
#import "CPTableViewControllerDataMutating.h"

@class CPIndexedTableViewController;

@interface CPTableViewHandler : NSObject

#pragma mark - Table view data source handler method

- (NSInteger)handleNumberOfSectionsInIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;

- (NSInteger)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;

- (NSArray *)handleSectionIndexTitlesForIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;

- (NSString *)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;

- (NSInteger)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;

- (UITableViewCell *)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Table view delegate handler method

- (void)handleIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CPIndexedTableViewController : UITableViewController <CPTableViewControllerDataMutating>

#pragma mark - Properties

@property (retain) CPDataIndexer *dataIndexer;
@property (retain) CPTableViewHandler *tableViewHandler;

//#pragma mark - Methods to override
//
//- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array;
//- (NSMutableArray *)fetchTheElementSections;
//- (NSArray *)fetchTheRawData;

#pragma mark - Intialization

- (id)initWithStyle:(UITableViewStyle)style withDataIndexer:(CPDataIndexer *)dataIndexer withTableViewHandler:(CPTableViewHandler *)tableViewHandler;

#pragma mark - Helper method

- (CPRefinedElement *)refinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;

@end
