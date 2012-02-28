//
//  CPMostRecentPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CoreDataTableViewController.h"
#import "CPIndexedTableViewController.h"


@interface CPMostRecentPhotosTableViewController : CPIndexedTableViewController

extern NSString *CPMostRecentPhotosTableViewAccessibilityLabel;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
