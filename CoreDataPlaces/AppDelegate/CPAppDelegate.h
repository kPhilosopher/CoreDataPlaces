//
//  CPAppDelegate.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//

#import <UIKit/UIKit.h>
#import "CPTabBarController.h"
#import "CPSplitViewController.h"

@interface CPAppDelegate : UIResponder <UIApplicationDelegate>

extern NSString *PLTitleOfScrollableViewController;

@property (strong, nonatomic) UIWindow *window;
@property (retain) CPTabBarController *tabBarController;
//@property (retain) CPScrollableImageViewController *scrollableImageVC;
@property (retain) CPSplitViewController *splitVC;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
