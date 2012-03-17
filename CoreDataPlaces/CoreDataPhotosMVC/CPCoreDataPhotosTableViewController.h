//
//  CPCoreDataPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"


@class Place;

@interface CPCoreDataPhotosTableViewController : CPIndexedTableViewController

extern NSString *CPFavoritePhotosTableViewAccessibilityLabel;

#pragma mark - Property

@property (retain) Place *currentPlace;

#pragma mark - Factory method

+ (id)coreDataPhotosTableViewControllerWithPlace:(Place *)chosenPlace manageObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext place:(Place *)place;

@end
