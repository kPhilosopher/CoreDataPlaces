//
//  CPMostRecentPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPMostRecentPhotosDataIndexer.h"
//#import "CoreDataTableViewController.h"
#import "CPIndexedTableViewController.h"
#import "CPRefining.h"


@class CPMostRecentPhotosDataHandler;

@interface CPMostRecentPhotosTableViewController : CPIndexedTableViewController

extern NSString *CPMostRecentPhotosTableViewAccessibilityLabel;

#pragma mark - Properties

@property (retain) id<CPDataIndexHandlingTemporary> tempDataIndexer;
@property (retain) id<CPRefining> refinary;
@property (retain) CPMostRecentPhotosRefinedElement *refinedElementType;

#pragma mark - Factory method

+ (id)mostRecentPhotosTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Initialization

//TODO: change this when refactoring.
- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler managedObjectContext:(NSManagedObjectContext *)managedObjectContext dataHandler:(CPMostRecentPhotosDataHandler *)dataHandler;

//- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
