//
//  CPIndexedTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/23/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

// !!!:This is an abstract class. It must be subclassed with appropriate implementation.

#import <UIKit/UIKit.h>
#import "CPTableViewControllerDataReloading.h"


@class CPIndexAssistant;
@class CPRefinary;
@class CPDataIndexer;
@class CPTableViewHandler;
@class CPRefinedElement;

@interface CPIndexedTableViewController : UITableViewController <CPTableViewControllerDataReloading>

#pragma mark - Properties

@property (retain) NSArray *listOfRawElements;
@property (retain) NSMutableArray *indexedRefinedElementSections;
@property (retain) CPRefinary *refinary;
@property (retain) CPDataIndexer *dataIndexer;
@property (retain) CPTableViewHandler *tableViewHandler;
@property (retain) CPRefinedElement *refinedElementType;
@property (retain) NSManagedObjectContext *managedObjectContext;
@property (retain) NSIndexPath *selectedIndexPath;

#pragma mark - Intialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Helper method

- (id)refinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;

@end
