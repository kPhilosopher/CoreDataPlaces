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

//- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedContext customSettingsDictionary:(NSDictionary *)customSettings;
- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedContext chosenPlace:(Place *)chosenPlace;

@end
