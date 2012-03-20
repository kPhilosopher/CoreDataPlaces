//
//  CPPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"


@class CPPlacesRefinedElement;

@interface CPPhotosTableViewController : CPIndexedTableViewController

extern NSString *CPPhotosListViewAccessibilityLabel;

#pragma mark - Property

@property (retain) CPPlacesRefinedElement *placeRefinedElement;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext placeRefinedElement:(CPPlacesRefinedElement *)placeRefinedElement;

#pragma mark - Factory method

+ (id)photosTableViewControllerWithRefinedElement:(CPPlacesRefinedElement *)refinedElement manageObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
