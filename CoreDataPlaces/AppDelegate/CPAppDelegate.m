//
//  CPAppDelegate.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//

#import "CPAppDelegate-Internal.h"

@interface CPAppDelegate ()
{
@private
	CPTabBarController *CP_tabBarController;
	//	CPScrollableImageViewController *CP_scrollableImageVC;
	CPSplitViewController *CP_splitVC;
}
@end

#pragma mark -

@implementation CPAppDelegate

#pragma mark - Synthesize

@synthesize window = _window;
@synthesize tabBarController = CP_tabBarController;
//@synthesize scrollableImageVC = CP_scrollableImageVC;
@synthesize splitVC = CP_splitVC;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

NSString *PLTitleOfScrollableViewController = @"Photo";

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_tabBarController release];
//	[CP_scrollableImageVC release];
	[CP_splitVC release];
	[_window release];
	[__managedObjectContext release];
	[__managedObjectModel release];
	[__persistentStoreCoordinator release];
    [super dealloc];
}

#pragma mark - didFinishLaunchingWithOptions sequence

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self RD_setupTheAppDelegateWindow];
	[self RD_initializeTabBarController];
	[self RD_determineTheSetupSequenceForDifferingDevices];
	[self.window makeKeyAndVisible];
	[self RD_runKIFIfRunningIntegrationTest];
    return YES;
}

	- (void)RD_setupTheAppDelegateWindow;
	{
		self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
		self.window.backgroundColor = [UIColor whiteColor];
	}
	- (void)RD_initializeTabBarController;
	{
//		self.tabBarController = [[[CPTabBarController alloc] initWithDelegate:self] autorelease];
		self.tabBarController = [[[CPTabBarController alloc] initWithDelegate:self withManagedObjectContext:self.managedObjectContext] autorelease];
	}
	- (void)RD_determineTheSetupSequenceForDifferingDevices;
	{
		if ([self RD_determineIfTheDeviceIsiPadOrNot])	
			[self RD_setupForiPad];
		else
			[self RD_setupForiPhoneOriPod];
	}
	- (BOOL)RD_determineIfTheDeviceIsiPadOrNot;
	{
		return ([[UIScreen mainScreen] bounds].size.height > 500);
	}
	- (void)RD_setupForiPad;
	{
		[self RD_setupForScrollableImageViewController];
		UINavigationController *navcon = [[UINavigationController alloc] init];
//		[navcon pushViewController:self.scrollableImageVC animated:NO];
		[self RD_setupSplitViewControllerWithNavigationController:navcon];
		self.window.rootViewController = self.splitVC;
		[navcon release];
	}
	- (void)RD_setupForScrollableImageViewController;
	{
//		self.scrollableImageVC = [[[CPScrollableImageViewController alloc] init] autorelease];
//		self.scrollableImageVC.title = CPTitleOfScrollableViewController;
	}
	- (void)RD_setupSplitViewControllerWithNavigationController:(UINavigationController *)navcon;
	{
		self.splitVC = [[[CPSplitViewController alloc] init] autorelease];
//		self.splitVC.delegate = self.scrollableImageVC;
		self.splitVC.viewControllers = [NSArray arrayWithObjects:self.tabBarController, navcon, nil];
	}
	- (void)RD_setupForiPhoneOriPod;
	{
		self.window.rootViewController = self.tabBarController;
	}
	- (void)RD_runKIFIfRunningIntegrationTest;
	{
	#if RUN_KIF_TESTS
		[[PlacesKIFTestController sharedInstance] startTestingWithCompletionBlock:^{
			// Exit after the tests complete so that CI knows we're done
			exit([[PlacesKIFTestController sharedInstance] failureCount]);
		}];
	#endif
	}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataPlaces" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataPlaces.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
