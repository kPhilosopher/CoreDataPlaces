//
//  CPManagedObjectInsertionHandler.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/5/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Place;
@class Photo;
@class CPRefinedElement;
@class CPPhotosRefinedElement;
@class CPPlacesRefinedElement;

@interface CPManagedObjectInsertionHandler : NSObject

#pragma mark - Property

@property (retain) NSManagedObjectContext *managedObjectContext;

#pragma mark - Initialization

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Instance method

- (BOOL)insertRefinedElement:(CPRefinedElement *)refinedElement;
- (Photo *)photoWithPhotoRefinedElement:(CPPhotosRefinedElement *)photoRefinedElement itsPlace:(Place *)itsPlace;
- (Place *)placeWithPlaceRefinedElement:(CPPlacesRefinedElement *)refinedElement;

@end
