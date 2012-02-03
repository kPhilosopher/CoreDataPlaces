//
//  CPFavoritesTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/30/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface CPFavoritesTableViewController : CoreDataTableViewController

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedContext customSettingsDictionary:(NSDictionary *)customSettings;

@end
