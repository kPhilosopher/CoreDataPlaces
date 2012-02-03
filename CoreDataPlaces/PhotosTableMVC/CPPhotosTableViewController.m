//
//  CPPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewController.h"
#import "CPPhotosRefinedElement.h"
#import "CPPhotosDataIndexer.h"
#import "CPPhotosTableViewHandler.h"
#import "CPFlickrDataHandler.h"
#import "CPPlacesRefinedElement.h"
#import "Place.h"


@interface CPPhotosTableViewController ()
{
@private
	NSArray *CP_listOfPhotos;
	NSMutableArray *CP_indexedListOfPhotos;
	Place *CP_currentPlace;
//	id <PictureListTableViewControllerDelegate> CP_iPadScrollableImageViewControllerDelegate;
}
@end

#pragma mark -

@implementation CPPhotosTableViewController

NSString *PictureListViewAccessibilityLabel = @"Picture list";
NSString *PictureListBackBarButtonAccessibilityLabel = @"Back";

#pragma mark - Synthesize

@synthesize listOfPhotos = CP_listOfPhotos;
@synthesize indexedListOfPhotos = CP_indexedListOfPhotos;
@synthesize currentPlace = CP_currentPlace;
//@synthesize iPadScrollableImageViewControllerDelegate = CP_iPadScrollableImageViewControllerDelegate;

#pragma mark - Initialization
//TODO: change the initializers to not include with****
- (id)initWithStyle:(UITableViewStyle)style withDataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate withTableViewHandler:(id<CPTableViewDelegate>)tableViewHandlingDelegate withPlaceIDString:(NSString *)placeID;
{
	self = [super initWithStyle:style withDataIndexer:dataIndexDelegate withTableViewHandler:tableViewHandlingDelegate];
    if (self)
	{
		if (placeID)
		{
//			self.dataIndexDelegate = [[[PictureListDataIndexer alloc] init] autorelease];
//			self.listOfPictures_theModel = pictureList;
			
			
//			start downloading the list of photos in another thread.
			//!!!!change this so that the handler is given by the initializer
			CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
			self.listOfPhotos = [flickrDataHandler photoListWithPlaceIDString:placeID];
			[flickrDataHandler release];
			self.view.accessibilityLabel = PictureListViewAccessibilityLabel;
			self.navigationItem.backBarButtonItem.accessibilityLabel = PictureListBackBarButtonAccessibilityLabel;
		}
    }
    return self;
}

#pragma mark - Factory method

+ (id)photosTableViewControllerWithRefinedElement:(CPPlacesRefinedElement *)refinedElement withManageObjectContext:(NSManagedObjectContext *)managedContext;
{
	CPPhotosTableViewController *photosTableViewController;
	CPPlacesRefinedElement *placesRefinedElement;
	if ([refinedElement isKindOfClass:[CPPlacesRefinedElement class]]) 
	{
		placesRefinedElement = (CPPlacesRefinedElement *)refinedElement;
		NSString *placeID = [placesRefinedElement.dictionary objectForKey:@"place_id"];
		//TODO: check if a place with placeID exists.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedContext];
		fetchRequest.fetchBatchSize = 1;
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"placeID like %@",placeID];
//		NSSortDescriptor *sortDescriptor = nil;
//		NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
		[fetchRequest setSortDescriptors:nil];
//		[sortDescriptors release];
		
		Place *chosenPlace;
		
		NSError *error = nil;
		NSUInteger returnedObjectCount = [managedContext countForFetchRequest:fetchRequest error:&error];
		if ((returnedObjectCount == 0) && !error)
		{
			chosenPlace = (Place *)[NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:managedContext];
	//		Place *chosenPlace = [[Place alloc] initWithEntity:@"Place" insertIntoManagedObjectContext:managedContext];
			chosenPlace.title = placesRefinedElement.title;
			chosenPlace.subtitle = placesRefinedElement.subtitle;
			chosenPlace.placeID = placeID;
			chosenPlace.hasFavoritePhoto = [NSNumber numberWithBool:NO];
			
			NSError *error = nil;
			
			NSLog(@"about to save: inserted %d registered %d deleted %d", managedContext.insertedObjects.count, managedContext.registeredObjects.count, managedContext.deletedObjects.count);
			if (![managedContext save:&error])
			{
				//handle the error.
				NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
			}
			NSLog(@"after save: inserted %d registered %d deleted %d", managedContext.insertedObjects.count, managedContext.registeredObjects.count, managedContext.deletedObjects.count);
		}
		else if (error)
		{
			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
		}
		else
		{
			NSError *error = nil;
			NSArray *fetchRequestOutput = [managedContext executeFetchRequest:fetchRequest error:&error];
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
				chosenPlace = [fetchRequestOutput lastObject];
			}
		}
			
		CPPhotosRefinedElement *refinedElementForDataIndexer = [[CPPhotosRefinedElement alloc] init];
		CPPhotosDataIndexer *dataIndexerDelegate = [[CPPhotosDataIndexer alloc] initWithRefinedElement:refinedElementForDataIndexer];
		[refinedElementForDataIndexer release];
		CPPhotosTableViewHandler *tableViewHandlerDelegate = [[CPPhotosTableViewHandler alloc] init];
		photosTableViewController = [[[CPPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain withDataIndexer:dataIndexerDelegate withTableViewHandler:tableViewHandlerDelegate withPlaceIDString:chosenPlace.placeID] autorelease];
		photosTableViewController.title = chosenPlace.title;
		photosTableViewController.currentPlace = chosenPlace;
		photosTableViewController.managedObjectContext = managedContext;
		[tableViewHandlerDelegate release];
		[dataIndexerDelegate release];
	}
	return photosTableViewController;
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_listOfPhotos release];
	[CP_indexedListOfPhotos release];
	[super dealloc];
}

#pragma mark - Methods to override the IndexedTableViewController

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array
{
	self.indexedListOfPhotos = array;
}

- (NSMutableArray *)fetchTheElementSections
{
	return self.indexedListOfPhotos;
}

- (NSArray *)fetchTheRawData
{
	return self.listOfPhotos;
}

@end
