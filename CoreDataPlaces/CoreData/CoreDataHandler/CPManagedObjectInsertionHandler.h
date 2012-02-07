//
//  CPManagedObjectInsertionHandler.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/5/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CPRefinedElement;

@interface CPManagedObjectInsertionHandler : NSObject

#pragma mark - Property

@property (retain) NSManagedObjectContext *managedObjectContext;

#pragma mark - Initialization

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Instance method
//TODO: change the interface to this and change the tests as well.
//- (NSManagedObject *)managedObjectFromRefinedElement:(CPRefinedElement *)refinedElement;
- (BOOL)insertRefinedElement:(CPRefinedElement *)refinedElement;

@end
