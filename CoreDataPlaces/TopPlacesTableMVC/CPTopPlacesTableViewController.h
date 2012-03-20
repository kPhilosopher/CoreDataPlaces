//
//  CPTopPlacesTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"


@interface CPTopPlacesTableViewController : CPIndexedTableViewController

extern NSString *CPTopPlacesTableViewAccessibilityLabel;

#pragma mark - Factory method

+ (id)topPlacesTableViewControllerWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
