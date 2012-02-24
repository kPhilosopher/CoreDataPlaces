//
//  CPManagedObjectInsertionHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/5/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPManagedObjectInsertionHandler.h"
#import "CPPlacesRefinedElement.h"
#import "CPPhotosRefinedElement.h"
#import "Place.h"


@interface CPManagedObjectInsertionHandler ()
{
@private
    NSManagedObjectContext *CP_managedObjectContext;
}
@end

@implementation CPManagedObjectInsertionHandler

#pragma mark - Synthesize

@synthesize managedObjectContext = CP_managedObjectContext;

#pragma mark - Initialization

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	self = [self init];
	if (self) {
		self.managedObjectContext = managedObjectContext;
	}
	return self;
}

#pragma mark - Instance method

- (BOOL)insertRefinedElement:(CPRefinedElement *)refinedElement;
{
	BOOL verdict = NO;
	if ([refinedElement isKindOfClass:[CPPlacesRefinedElement class]]) 
	{
		CPPlacesRefinedElement *placesRefinedElement = (CPPlacesRefinedElement *)refinedElement;
		Place *insertedPlace = (Place *)[NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
		insertedPlace.title = placesRefinedElement.title;
		insertedPlace.subtitle = placesRefinedElement.subtitle;
		insertedPlace.placeID = [placesRefinedElement.dictionary objectForKey:CPPlaceID];
		insertedPlace.hasFavoritePhoto = [NSNumber numberWithBool:NO];
		verdict = YES;
		
		NSError *error = nil;
//		
//		NSLog(@"about to save: inserted %d registered %d deleted %d", self.managedObjectContext.insertedObjects.count, self.managedObjectContext.registeredObjects.count, self.managedObjectContext.deletedObjects.count);
		if (![self.managedObjectContext save:&error])
		{
			//handle the error.
			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
		}
	}
	return verdict;
}

@end
