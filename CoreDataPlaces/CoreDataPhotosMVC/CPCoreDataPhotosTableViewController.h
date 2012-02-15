//
//  CPCoreDataPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"


@class Place;

@interface CPCoreDataPhotosTableViewController : CoreDataTableViewController

#pragma mark - Initialization

//TODO: new api
- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext fetchedResultsController:(NSFetchedResultsController *)localFetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext chosenPlace:(Place *)chosenPlace;

@end
