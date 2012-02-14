//
//  PhotoTimeLapseCalculatorTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPPhotoTimeIntervalCalculatorTests.h"


@interface PhotoTimeLapseCalculatorTests ()
{
@private
	NSManagedObjectContext *__managedObjectContext;
	NSManagedObjectModel *__managedObjectModel;
	NSPersistentStoreCoordinator *__persistentStoreCoordinator;
}
@end

@implementation PhotoTimeLapseCalculatorTests

#pragma mark - Synthesize

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[__managedObjectContext release];
	[__managedObjectModel release];
	[__persistentStoreCoordinator release];
	[super dealloc];
}

#pragma mark - Tests

- (void)setUp;
{
	[super setUp];
}

- (void)tearDown;
{
	//delete the sqlite file
	NSURL *path = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataPlaces.sqlite"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL fileExists = [fileManager fileExistsAtPath:[path path]];
	//    NSLog(@"Path to file: %@", path);        
	//    NSLog(@"File exists: %d", fileExists);
	//    NSLog(@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:[path path]]);
    if (fileExists) 
    {
		BOOL success = [fileManager removeItemAtURL:path error:&error];
		//        BOOL success = [fileManager removeItemAtPath:path error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
    }
	[super tearDown];
}

- (void)testPhotoTimeLapseCalculator;
{
	Photo *currentPhoto = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
	currentPhoto.photoURL = @"unique01";
	currentPhoto.title = @"title01";
	currentPhoto.subtitle = @"subtitle01";
	currentPhoto.isFavorite = [NSNumber numberWithBool:NO];
	currentPhoto.itsPlace = nil;
	int hoursForUpload = 2;
	int secondsBetween1970AndUpload = [[NSDate date] timeIntervalSince1970] - (hoursForUpload * 3600);
	NSDate *uploadDate = [NSDate dateWithTimeIntervalSince1970:secondsBetween1970AndUpload];
	currentPhoto.timeOfUpload = uploadDate;
	
	STAssertTrue([currentPhoto.timeLapseSinceUpload isEqualToNumber:[NSNumber numberWithInt:hoursForUpload]],@"time lapse since upload is not returning the correct value");
	
	int hoursForLastView = 4;
	int secondsBetween1970AndLastView = [[NSDate date] timeIntervalSince1970] - (hoursForLastView * 3600);
	NSDate *lastViewDate = [NSDate dateWithTimeIntervalSince1970:secondsBetween1970AndLastView];
	currentPhoto.timeOfLastView = lastViewDate;
	STAssertTrue([currentPhoto.timeLapseSinceLastView isEqualToNumber:[NSNumber numberWithInt:hoursForLastView]],@"time lapse since last view is not returning the correct value");
	
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
	__managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:[NSBundle allBundles]] retain];
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
	//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	//	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
	//	NSLog([[NSFileManager defaultManager] currentDirectoryPath]);
	//	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
	return [NSURL fileURLWithPath:[[NSFileManager defaultManager] currentDirectoryPath]];
}

@end
