//
//  CPPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"


@class CPPlacesRefinedElement;

extern NSString *CPPhotosListViewAccessibilityLabel;

@interface CPPhotosTableViewController : CPIndexedTableViewController

#pragma mark - Property

@property (retain) CPPlacesRefinedElement *placeRefinedElement;

#pragma mark - Factory method

+ (id)photosTableViewControllerWithRefinedElement:(CPPlacesRefinedElement *)refinedElement manageObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext placeRefinedElement:(CPPlacesRefinedElement *)placeRefinedElement;

@end
