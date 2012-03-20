//
//  CPCoreDataTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/20/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"


@class Place;

@interface CPCoreDataTableViewController : CPIndexedTableViewController

extern NSString *CPFavoritePhotosTableViewAccessibilityLabel;
extern NSString *CPMostRecentPhotosTableViewAccessibilityLabel;
extern NSString *CPFavoritePlacesTableViewAccessibilityLabel;

#pragma mark - Property

@property (retain) Place *currentPlace;

#pragma mark - Factory method

+ (id)favoritePlacesTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;

+ (id)coreDataPhotosTableViewControllerWithPlace:(Place *)chosenPlace manageObjectContext:(NSManagedObjectContext *)managedObjectContext;

+ (id)mostRecentPhotosTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext fetchRequest:(NSFetchRequest *)fetchRequest place:(Place *)place;

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext fetchRequest:(NSFetchRequest *)fetchRequest title:(NSString *)title;

@end
