//
//  CPFavoritesTableViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/30/12.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface CPFavoritesTableViewController : CoreDataTableViewController

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style managedObjectContext:(NSManagedObjectContext *)managedContext customSettingsDictionary:(NSDictionary *)customSettings;

@end
