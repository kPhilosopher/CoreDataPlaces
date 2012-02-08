//
//  CPManagedObjectInsertionHandlerTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/5/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPManagedObjectInsertionHandlerTests.h"
#import "CPManagedObjectInsertionHandler.h"
#import "CPPlacesRefinedElement.h"
#import "CPPhotosRefinedElement.h"
#import "Place.h"
#import "Photo.h"


@interface CPManagedObjectInsertionHandlerTests ()
{
	@private
	NSManagedObjectContext *__managedObjectContext;
	NSManagedObjectModel *__managedObjectModel;
	NSPersistentStoreCoordinator *__persistentStoreCoordinator;
	CPManagedObjectInsertionHandler *CP_insertionHandler;
}
@end

@implementation CPManagedObjectInsertionHandlerTests

#pragma mark - Synthesize

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize insertionHandler = CP_insertionHandler;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[__managedObjectContext release];
	[__managedObjectModel release];
	[__persistentStoreCoordinator release];
	[CP_insertionHandler release];
	[super dealloc];
}

#pragma mark - Tests

// All code under test must be linked into the Unit Test bundle

- (void)setUp;
{
	[super setUp];
	self.insertionHandler = [[CPManagedObjectInsertionHandler alloc] initWithManagedObjectContext:self.managedObjectContext];
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

- (void)testTheManagedObjectContext;
{
	Place *chosenPlace = (Place *)[NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
	chosenPlace.title = @"titlePic";
	chosenPlace.subtitle = @"subtitlePic";
	chosenPlace.placeID = @"blabla01";
	chosenPlace.hasFavoritePhoto = [NSNumber numberWithBool:NO];
	
	NSError *error = nil;
	
	NSLog(@"about to save: inserted %d registered %d deleted %d", self.managedObjectContext.insertedObjects.count, self.managedObjectContext.registeredObjects.count, self.managedObjectContext.deletedObjects.count);
	if (![self.managedObjectContext save:&error])
	{
		//handle the error.
		NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
	}
	NSLog(@"after save: inserted %d registered %d deleted %d", self.managedObjectContext.insertedObjects.count, self.managedObjectContext.registeredObjects.count, self.managedObjectContext.deletedObjects.count);
	
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.fetchBatchSize = 20;
//	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"placeID like %@",placeID];
	[fetchRequest setSortDescriptors:nil];
	
	
	NSError *error2 = nil;
	NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error2];
//	NSUInteger returnedObjectCount = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
	if (fetchedObjects && !error)
	{
		NSLog(@"++++++");
		NSLog(@"The fetched objects list:");
		NSLog(@" ");
		for (id element in fetchedObjects) {
			if ([element isKindOfClass:[Place class]]) {
				Place *place = (Place *)element;
				NSLog(@"Place has title:%@, subtitle:%@, and placeID:%@",place.title, place.subtitle, place.placeID);
			}
		}
		NSLog(@" ");
		NSLog(@"end of the list:");
		NSLog(@"++++++");
	}
	else if (fetchRequest == nil)
	{
		NSLog(@"%@ %@", [error2 localizedDescription], [error2 localizedFailureReason]);
	}
}

- (void)test_insertPlacesRefinedElement;
{
	//create places refined elements
	CPPlacesRefinedElement *place01 = [[CPPlacesRefinedElement alloc] init];
	place01.title = @"place01";
	place01.subtitle = @"subtitle of place01";
	place01.dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"place01ID",CPPlaceID, nil];
	CPPlacesRefinedElement *place02 = [[CPPlacesRefinedElement alloc] init];
	place02.title = @"place02";
	place02.subtitle = @"subtitle of place02";
	place02.dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"place02ID",CPPlaceID, nil];
	CPPlacesRefinedElement *place03 = [[CPPlacesRefinedElement alloc] init];
	place03.title = @"place03";
	place03.subtitle = @"subtitle of place03";
	place03.dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"place03ID",CPPlaceID, nil];
	CPPlacesRefinedElement *place04 = [[CPPlacesRefinedElement alloc] init];
	place04.title = @"place04";
	place04.subtitle = @"subtitle of place04";
	place04.dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"place04ID",CPPlaceID, nil];
	
	//call the method to insert the elements.
	STAssertTrue([self.insertionHandler insertRefinedElement:place01] == YES,@"CPManagedObjectInsertionHandler method insertRefinedElement failed.");
	STAssertTrue([self.insertionHandler insertRefinedElement:place02] == YES,@"CPManagedObjectInsertionHandler method insertRefinedElement failed.");
	STAssertTrue([self.insertionHandler insertRefinedElement:place03] == YES,@"CPManagedObjectInsertionHandler method insertRefinedElement failed.");
	STAssertTrue([self.insertionHandler insertRefinedElement:place04] == YES,@"CPManagedObjectInsertionHandler method insertRefinedElement failed.");
	
//	int count = 2;
//	NSLog([@"place" stringByAppendingFormat:@"%.2d",count]);
	
	
	NSError *error = nil;
	//check if the elements are inserted into the core data correctly.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES],nil];
	
	NSError *error2 = nil;
	NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error2];
	if ([fetchedObjects count] > 0 && !error)
	{
		int count = 1;
		for (id element in fetchedObjects) 
		{
			Place *place;
			if ([element isKindOfClass:[Place class]])
			{
				place = (Place *)element;
				STAssertTrue(([place.title isEqualToString:[@"place" stringByAppendingFormat:@"%.2d",count]]),@"Title of place element is incorrect.");
				STAssertTrue(([place.subtitle isEqualToString:[@"subtitle of place" stringByAppendingFormat:@"%.2d",count]]),@"Subtitle of place element is incorrect");
				STAssertTrue(([place.placeID isEqualToString:[@"place" stringByAppendingFormat:@"%.2dID",count]]),@"PlaceID of place element is incorrect");
				STAssertTrue(([place.hasFavoritePhoto boolValue] == NO),@"bool value of whether the place has a favorite photo is incorrect.");
				count = count + 1;
			}
		}
		
		
		//display the items.
		NSLog(@"++++++");
		NSLog(@"The fetched objects list:");
		NSLog(@" ");
		for (id element in fetchedObjects) {
			if ([element isKindOfClass:[Place class]]) {
				Place *place = (Place *)element;
				NSLog(@"Place has title:%@, subtitle:%@, and placeID:%@",place.title, place.subtitle, place.placeID);
			}
		}
		NSLog(@" ");
		NSLog(@"end of the list:");
		NSLog(@"++++++");
	}
	else
	{
//		NSLog(@"%@ %@", [error2 localizedDescription], [error2 localizedFailureReason]);
		STFail(@"%@ %@", [error2 localizedDescription], [error2 localizedFailureReason]);
	}
}

- (void)test_insertPlacesRefinedElement_nilData;
{
	STAssertFalse([self.insertionHandler insertRefinedElement:nil], @"nil insertion should return a nil");
}

- (void)test_insertPlacesRefinedElement_corruptedData;
{
	//test different situations.
}

- (void)test_insertPhotosRefinedElement;
{
	//create photos refined element.
	CPPhotosRefinedElement *place01 = [[CPPhotosRefinedElement alloc] init];
	place01.title = @"place01";
	place01.subtitle = @"subtitle of place01";
	place01.dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"place01ID",CPPlaceID, nil];
//	place01.comparable = 
	
	//call the method to insert the elements.
	
	//check if the elements are inserted into the Core Data.
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
