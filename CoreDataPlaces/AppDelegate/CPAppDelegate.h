//
//  CPAppDelegate.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CPSplitViewController;
@class CPTabBarController;
@class CPScrollableImageViewController;

extern NSString *CPTitleOfScrollableViewController;

@interface CPAppDelegate : UIResponder <UIApplicationDelegate>

#pragma mark - Property

@property (strong, nonatomic) UIWindow *window;
@property (retain) CPTabBarController *tabBarController;
@property (retain) CPScrollableImageViewController *scrollableImageVC;
@property (retain) CPSplitViewController *splitVC;

#pragma mark --Core Data

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark --Core Data

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
