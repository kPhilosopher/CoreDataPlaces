//
//  CPPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPIndexedTableViewController.h"

//@class PictureListTableViewController;
//
//@protocol PictureListTableViewControllerDelegate
//
//-(ScrollableImageViewController *)scrollableImageViewControllerForRequestor:(id)requestor;
//
//@end

@interface CPPhotosTableViewController : CPIndexedTableViewController

extern NSString *PictureListViewAccessibilityLabel;
extern NSString *PictureListBackBarButtonAccessibilityLabel;

#pragma mark - Property

@property (retain) NSArray *listOfPhotos;
@property (retain) NSMutableArray *indexedListOfPhotos;
//@property (retain) id <PictureListTableViewControllerDelegate> iPadScrollableImageViewControllerDelegate;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style withDataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate withTableViewHandler:(id<CPTableViewDelegate>)tableViewHandlingDelegate withPlaceIDString:(NSString *)placeID;

#pragma mark - Factory method

+ (id)photosTableViewControllerWithRefinedElement:(CPRefinedElement *)refinedElement;

@end
