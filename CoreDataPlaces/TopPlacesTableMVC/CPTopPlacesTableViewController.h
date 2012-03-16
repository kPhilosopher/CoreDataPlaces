//
//  CPTopPlacesTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"


@class CPFlickrDataSource;

@interface CPTopPlacesTableViewController : CPIndexedTableViewController

extern NSString *CPTopPlacesTableViewAccessibilityLabel;

#pragma mark - Property

//@property (retain) NSArray *listOfPlaces;
//@property (retain) NSMutableArray *indexedListOfPlaces;
//@property (retain) id<CPTableViewControllerDataReloading> delegateToUpdateMostRecentPlaces;
//@property (retain) CPFlickrDataSource *flickrDataSource;
//@property (assign) id<PictureListTableViewControllerDelegate> delegateToTransfer;

#pragma mark - Initialization

//- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler theFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource;
//- (id)initWithStyle:(UITableViewStyle)style tableViewHandler:(CPTableViewHandler *)tableViewHandler dataHandler:(CPDataHandler *)dataHandler managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Factory method

+ (id)topPlacesTableViewControllerWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
