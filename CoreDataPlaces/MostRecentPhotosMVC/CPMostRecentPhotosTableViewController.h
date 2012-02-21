//
//  CPMostRecentPhotosTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"


@interface CPMostRecentPhotosTableViewController : CoreDataTableViewController

extern NSString *CPMostRecentPhotosViewAccessibilityLabel;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
