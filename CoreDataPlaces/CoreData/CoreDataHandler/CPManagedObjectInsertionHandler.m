//
//  CPManagedObjectInsertionHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/5/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPManagedObjectInsertionHandler.h"
#import "CPConstants.h"
#import "CPPlacesRefinedElement.h"
#import "CPPhotosRefinedElement.h"
#import "Place.h"
#import "Photo.h"


@interface CPManagedObjectInsertionHandler ()
{
@private
    NSManagedObjectContext *CP_managedObjectContext;
}
@end

#pragma mark -

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
		insertedPlace.placeID = [placesRefinedElement.rawElement objectForKey:CPPlaceID];
		insertedPlace.hasFavoritePhoto = [NSNumber numberWithBool:NO];
		verdict = YES;
		
		NSError *error = nil;
		if (![self.managedObjectContext save:&error])
		{
			//handle the error.
			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
		}
	}
	return verdict;
}

- (Photo *)photoWithPhotoRefinedElement:(CPPhotosRefinedElement *)photoRefinedElement itsPlace:(Place *)itsPlace;
{
	Photo *photoToDisplay = nil;
	//first check if the photo already exists.
	if ([photoRefinedElement.rawElement isKindOfClass:[NSDictionary class]]) 
	{
		NSDictionary *dictionary = (NSDictionary *)photoRefinedElement.rawElement;
		NSString *photoURL = photoRefinedElement.largePhotoURL;
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"photoURL like %@",photoURL];
		NSSortDescriptor *sortDescriptor = nil;
		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[fetchRequest setSortDescriptors:sortDescriptors];
		[sortDescriptors release];
		
		
		NSError *error = nil;
		NSUInteger returnedObjectCount = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
		if ((returnedObjectCount == 0) && !error)
		{
			photoToDisplay = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
			photoToDisplay.photoURL = photoURL;
			photoToDisplay.title = photoRefinedElement.title;
			photoToDisplay.subtitle = photoRefinedElement.subtitle;
			photoToDisplay.itsPlace = itsPlace;
			photoToDisplay.isFavorite = [NSNumber numberWithBool:NO];
			NSString *secondsBetween1970AndUpload = [dictionary objectForKey:@"dateupload"];
			NSDate *uploadDate = [NSDate dateWithTimeIntervalSince1970:[secondsBetween1970AndUpload intValue]];
			photoToDisplay.timeOfUpload = uploadDate;
			
			if (![self.managedObjectContext save:&error])
			{
				//handle the error.
				NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
			}
		}
		else if (error)
		{
			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
		}
		else
		{
			NSError *error = nil;
			NSArray *fetchRequestOutput = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
			if (!fetchRequestOutput)
			{
				NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
			}
			else if ([fetchRequestOutput count] > 1)
			{
				NSLog(@"placeID is not a key anymore");
			}
			else
			{
				photoToDisplay = [fetchRequestOutput lastObject];
			}
		}
		[fetchRequest release];fetchRequest = nil;
	}
	return photoToDisplay;
}

- (Place *)placeWithPlaceRefinedElement:(CPPlacesRefinedElement *)refinedElement;
{
	Place *currentPlace = nil;
	NSString *placeID = refinedElement.placeID;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"placeID like %@",placeID];
	[fetchRequest setSortDescriptors:nil];
	
	NSError *error = nil;
	NSUInteger returnedObjectCount = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
	if ((returnedObjectCount == 0) && !error)
	{
		currentPlace = (Place *)[NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.managedObjectContext];
		currentPlace.title = refinedElement.title;
		currentPlace.subtitle = refinedElement.subtitle;
		currentPlace.category = [refinedElement.title substringToIndex:1];
		currentPlace.placeID = placeID;
		currentPlace.hasFavoritePhoto = [NSNumber numberWithBool:NO];
	}
	else if (error)
	{
		NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
	}
	else
	{
		NSError *error = nil;
		NSArray *fetchRequestOutput = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
		if (!fetchRequestOutput)
		{
			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
		}
		else if ([fetchRequestOutput count] > 1)
		{
			NSLog(@"placeID is not a key anymore");
		}
		else
		{
			currentPlace = [fetchRequestOutput lastObject];
		}
	}
	[fetchRequest release]; fetchRequest = nil;
	return currentPlace;
}

@end
