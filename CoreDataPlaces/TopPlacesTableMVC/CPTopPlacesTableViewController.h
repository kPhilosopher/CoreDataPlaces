//
//  CPTopPlacesTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPIndexedTableViewController.h"
#import "CPPlacesTableViewHandler.h"
#import "CPFlickrDataSource.h"

@interface CPTopPlacesTableViewController : CPIndexedTableViewController

extern NSString *CPTopPlacesViewAccessibilityLabel;

#pragma mark - Property

//@property (retain) id<CPTableViewControllerDataReloading> delegateToUpdateMostRecentPlaces;
@property (retain) CPFlickrDataSource *flickrDataSource;
//@property (assign) id<PictureListTableViewControllerDelegate> delegateToTransfer;

#pragma mark - Initialization

//- (id)initWithStyle:(UITableViewStyle)style withDataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate withTableViewHandler:(id<CPTableViewDelegate>)tableViewHandlingDelegate withTheFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource;
- (id)initWithStyle:(UITableViewStyle)style dataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate tableViewHandler:(id<CPTableViewDelegate>)tableViewHandlingDelegate theFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource;

#pragma mark - Factory method

+ (id)topPlacesTableViewController;

@end
