//
//  CPMostRecentPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPIndexedTableViewController.h"


@interface CPMostRecentPhotosTableViewController : CPIndexedTableViewController

extern NSString *CPMostRecentPhotosTableViewAccessibilityLabel;

#pragma mark - Factory method

+ (id)mostRecentPhotosTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
