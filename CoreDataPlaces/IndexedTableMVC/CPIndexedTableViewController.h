//
//  CPIndexedTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/23/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

// !!!:This is an abstract class. It must be subclassed with appropriate implementation.

#import <UIKit/UIKit.h>
#import "CPTableViewControllerDataMutating.h"
#import "CPTableViewControllerDataReloading.h"


@class CPIndexAssistant;
@class CPRefinary;
@class CPDataIndexer;
@class CPTableViewHandler;
@class CPRefinedElement;

@interface CPIndexedTableViewController : UITableViewController <CPTableViewControllerDataMutating, CPTableViewControllerDataReloading>

#pragma mark - Properties

@property (retain) CPRefinary *refinary;
@property (retain) CPDataIndexer *dataIndexer;
@property (retain) CPTableViewHandler *tableViewHandler;
@property (retain) CPRefinedElement *refinedElementType;
@property (retain) NSManagedObjectContext *managedObjectContext;

#pragma mark - Intialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Helper method

- (id)refinedElementInTheElementSectionsWithTheIndexPath:(NSIndexPath *)indexPath;

@end
