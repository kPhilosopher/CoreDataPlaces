//
//  CPManagedObjectInsertionHandlerTests.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/5/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>


@class CPManagedObjectInsertionHandler;

@interface CPManagedObjectInsertionHandlerTests : SenTestCase

#pragma mark --Core Data

@property (readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain) CPManagedObjectInsertionHandler *insertionHandler;

#pragma mark --Core Data

- (NSURL *)applicationDocumentsDirectory;

@end
