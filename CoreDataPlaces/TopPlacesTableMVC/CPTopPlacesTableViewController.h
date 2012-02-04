//
//  CPTopPlacesTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPIndexedTableViewController.h"
//#import "CPPlacesTableViewHandler.h"
//#import "CPFlickrDataSource.h"


@class CPFlickrDataSource;

@interface CPTopPlacesTableViewController : CPIndexedTableViewController

extern NSString *CPTopPlacesViewAccessibilityLabel;

#pragma mark - Property

//@property (retain) id<CPTableViewControllerDataReloading> delegateToUpdateMostRecentPlaces;
@property (retain) CPFlickrDataSource *flickrDataSource;
//@property (assign) id<PictureListTableViewControllerDelegate> delegateToTransfer;

#pragma mark - Initialization

//- (id)initWithStyle:(UITableViewStyle)style dataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate tableViewHandler:(id<CPTableViewHandling>)tableViewHandler withTheFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource;
- (id)initWithStyle:(UITableViewStyle)style dataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate tableViewHandler:(id<CPTableViewHandling>)tableViewHandler theFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource;

#pragma mark - Factory method

+ (id)topPlacesTableViewController;

@end
