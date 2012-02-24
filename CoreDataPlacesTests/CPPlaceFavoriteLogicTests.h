//
//  CPPlaceFavoriteLogicTests.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/13/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>

@interface CPPlaceFavoriteLogicTests : SenTestCase

#pragma mark --Core Data

@property (readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark --Core Data

- (NSURL *)applicationDocumentsDirectory;

@end
