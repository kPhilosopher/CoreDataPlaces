//
//  CPPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPIndexedTableViewController.h"
//#import "CPPlacesRefinedElement.h"
//#import "Place.h"


@class Place;
@class CPPlacesRefinedElement;

//@class PictureListTableViewController;
//
//@protocol PictureListTableViewControllerDelegate
//
//-(ScrollableImageViewController *)scrollableImageViewControllerForRequestor:(id)requestor;
//
//@end

@interface CPPhotosTableViewController : CPIndexedTableViewController

extern NSString *CPPhotosListViewAccessibilityLabel;
//extern NSString *PictureListBackBarButtonAccessibilityLabel;
extern NSString *CPActivityIndicatorMarkerForKIF;

#pragma mark - Property

@property (retain) NSArray *listOfPhotos;
@property (retain) NSMutableArray *indexedListOfPhotos;
@property (copy) NSString *placeID;
@property (retain) Place *currentPlace;
//@property (retain) id <PictureListTableViewControllerDelegate> iPadScrollableImageViewControllerDelegate;

#pragma mark - Initialization

//- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler withPlaceIDString:(NSString *)placeID;
- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler placeIDString:(NSString *)placeID;

#pragma mark - Factory method

//+ (id)photosTableViewControllerWithRefinedElement:(CPRefinedElement *)refinedElement;
+ (id)photosTableViewControllerWithRefinedElement:(CPPlacesRefinedElement *)refinedElement manageObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
