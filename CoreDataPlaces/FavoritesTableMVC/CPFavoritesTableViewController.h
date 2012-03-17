//
//  CPFavoritesTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/30/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CoreDataTableViewController.h"


@interface CPFavoritesTableViewController : CoreDataTableViewController

extern NSString *CPFavoritePlacesTableViewAccessibilityLabel;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedObjectContext customSettingsDictionary:(NSDictionary *)customSettings;

@end
