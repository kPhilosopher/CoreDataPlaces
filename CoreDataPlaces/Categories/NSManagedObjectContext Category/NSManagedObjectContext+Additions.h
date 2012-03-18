//
//  NSManagedObjectContext+Additions.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/17/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface NSManagedObjectContext (Additions)

#pragma mark - Internal method

- (void)processPendingChangesThenSave;

@end
