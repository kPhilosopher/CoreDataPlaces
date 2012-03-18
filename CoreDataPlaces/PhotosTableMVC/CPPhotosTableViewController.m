//
//  CPPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewController-Internal.h"
#import "CPConstants.h"
#import "CPPhotosRefinary.h"
#import "CPPhotosDataIndexer.h"
#import "CPPhotosTableViewHandler.h"
#import "CPPhotosRefinedElement.h"
#import "CPIndexAssistant.h"
#import "CPPlacesRefinedElement.h"
#import "CPFlickrDataHandler.h"
#import "Place.h"
#import "CPNotificationManager.h"


@interface CPPhotosTableViewController ()
{
@private
	NSArray *CP_listOfPhotos;
	NSMutableArray *CP_indexedListOfPhotos;
	CPPlacesRefinedElement *CP_placeRefinedElement;
}
@end

#pragma mark -

@implementation CPPhotosTableViewController

NSString *CPPhotosListViewAccessibilityLabel = @"Picture list table";

#pragma mark - Synthesize

@synthesize listOfPhotos = CP_listOfPhotos;
@synthesize indexedListOfPhotos = CP_indexedListOfPhotos;
@synthesize placeRefinedElement = CP_placeRefinedElement;

#pragma mark - Factory method

+ (id)photosTableViewControllerWithRefinedElement:(CPPlacesRefinedElement *)refinedElement manageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPPhotosRefinary *refinary = [[CPPhotosRefinary alloc] init];
	CPPhotosDataIndexer *dataIndexer = [[CPPhotosDataIndexer alloc] init];
	CPPhotosTableViewHandler *tableViewHandler = [[CPPhotosTableViewHandler alloc] init];
	CPPhotosRefinedElement *refinedElementType = [[CPPhotosRefinedElement alloc] init];
	CPIndexAssistant *indexAssitant = [[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType];
	[refinary release]; refinary = nil;
	[dataIndexer release]; dataIndexer = nil;
	[tableViewHandler release]; tableViewHandler = nil;
	[refinedElementType release]; refinedElementType = nil;
	CPPhotosTableViewController *photosTableViewController = [[CPPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssitant managedObjectContext:managedObjectContext placeRefinedElement:refinedElement];
	[indexAssitant release]; indexAssitant = nil;
	return [photosTableViewController autorelease];
}

//TODO: refactor to be in a insertion handler for coredata objects.
+ (Place *)placeWithPlaceRefinedElement:(CPPlacesRefinedElement *)refinedElement managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	Place *currentPlace = nil;
	NSString *placeID = refinedElement.placeID;
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"placeID like %@",placeID];
	[fetchRequest setSortDescriptors:nil];
	
	NSError *error = nil;
	NSUInteger returnedObjectCount = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
	if ((returnedObjectCount == 0) && !error)
	{
		currentPlace = (Place *)[NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:managedObjectContext];
		currentPlace.title = refinedElement.title;
		currentPlace.subtitle = refinedElement.subtitle;
		currentPlace.category = [refinedElement.title substringToIndex:1];
		currentPlace.placeID = placeID;
		currentPlace.hasFavoritePhoto = [NSNumber numberWithBool:NO];
		
//		NSError *error = nil;
		
		//Hal's approach to finding the source of error.
		
//		NSLog(@"about to save: inserted %d registered %d deleted %d", managedObjectContext.insertedObjects.count, managedObjectContext.registeredObjects.count, managedObjectContext.deletedObjects.count);
//		if (![managedObjectContext save:&error])
//		{
//			//handle the error.
//			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
//		}
//		NSLog(@"after save: inserted %d registered %d deleted %d", managedObjectContext.insertedObjects.count, managedObjectContext.registeredObjects.count, managedObjectContext.deletedObjects.count);
	}
	else if (error)
	{
		NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
	}
	else
	{
		NSError *error = nil;
		NSArray *fetchRequestOutput = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
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
	[fetchRequest release];
	return currentPlace;
}

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext placeRefinedElement:(CPPlacesRefinedElement *)placeRefinedElement;
{
	self = [super initWithStyle:style indexAssitant:indexAssistant managedObjectContext:managedObjectContext];
    if (self)
	{
		self.placeRefinedElement = placeRefinedElement;
		self.title = self.placeRefinedElement.title;
		self.view.accessibilityLabel = CPPhotosListViewAccessibilityLabel;
	}
	return self;
}

#pragma mark - View lifecycle

- (void)dealloc;
{
	[CP_listOfPhotos release];
	[CP_indexedListOfPhotos release];
	[CP_placeRefinedElement release];
	[super dealloc];
}


#pragma mark - Convenience method

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	if (!self.listOfPhotos)
	{
		[self CP_setupPhotosListWithPlaceID:self.placeRefinedElement.placeID];
	}
}

- (void)CP_setupPhotosListWithPlaceID:(NSString *)placeID;
{
	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
	//TODO: make a class that contains all the constant strings that is used in more than one place.
	//TODO: find a better place to put this redundant code.
	UIView *theLabel = [[UIView alloc] init];
	theLabel.accessibilityLabel = CPActivityIndicatorMarkerForKIF;
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.color = [UIColor blueColor];
	activityIndicator.hidesWhenStopped = YES;
	activityIndicator.center = CGPointMake(self.navigationController.view.bounds.size.width/2, self.navigationController.view.bounds.size.height/2);
	theLabel.frame = activityIndicator.frame;
	activityIndicator.center = CGPointMake(theLabel.bounds.size.width/2, theLabel.bounds.size.height/2);
	activityIndicator.accessibilityLabel = @"Activity indicator";
	activityIndicator.hidesWhenStopped = YES;
	[self.navigationController.view addSubview:theLabel];
	[theLabel addSubview:activityIndicator];
	[activityIndicator startAnimating];
	dispatch_queue_t photosDownloadQueue = dispatch_queue_create("Flickr photos downloader", NULL);
	dispatch_async(photosDownloadQueue, ^{
		id undeterminedListOfPhotos = [flickrDataHandler flickrPhotoListWithPlaceID:self.placeRefinedElement.placeID];
		[flickrDataHandler release];
		dispatch_async(dispatch_get_main_queue(), ^{
			[activityIndicator stopAnimating];
			if ([undeterminedListOfPhotos isKindOfClass:[NSArray class]]) 
			{
				self.listOfPhotos = (NSArray *)undeterminedListOfPhotos;
				[self indexTheTableViewData];
			}
			else
			{
				[[NSNotificationCenter defaultCenter] postNotificationName:CPNetworkErrorOccuredNotification object:self];
			}
			[activityIndicator removeFromSuperview];
			[activityIndicator release];
			[theLabel removeFromSuperview];
			[theLabel release];
		});
	});
	dispatch_release(photosDownloadQueue);
}



#pragma mark - Methods to override the IndexedTableViewController

- (void)setTheElementSections:(NSMutableArray *)array;
{
	self.indexedListOfPhotos = array;
}

- (NSMutableArray *)theElementSections;
{
	return self.indexedListOfPhotos;
}

- (NSArray *)theRawData;
{
	return self.listOfPhotos;
}

@end
