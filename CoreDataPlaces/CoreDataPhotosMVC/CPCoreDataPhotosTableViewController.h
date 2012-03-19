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
extern NSString *CPMostRecentPhotosTableViewAccessibilityLabel;

#pragma mark - Property

@property (retain) Place *currentPlace;

#pragma mark - Factory method

+ (id)coreDataPhotosTableViewControllerWithPlace:(Place *)chosenPlace manageObjectContext:(NSManagedObjectContext *)managedObjectContext;

+ (id)mostRecentPhotosTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext fetchRequest:(NSFetchRequest *)fetchRequest place:(Place *)place;

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext title:(NSString *)title fetchRequest:(NSFetchRequest *)fetchRequest;

@end
