//
//  CPPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewController-Internal.h"
#import "CPPhotosRefinedElement.h"
#import "CPPhotosDataIndexer.h"
#import "CPPhotosTableViewHandler.h"
#import "CPFlickrDataHandler.h"
#import "CPPlacesRefinedElement.h"
#import "Place.h"
#import "CPNotificationManager.h"


@interface CPPhotosTableViewController ()
{
@private
	NSArray *CP_listOfPhotos;
	NSMutableArray *CP_indexedListOfPhotos;
	NSString *CP_placeID;
	Place *CP_currentPlace;
//	id <PictureListTableViewControllerDelegate> CP_iPadScrollableImageViewControllerDelegate;
}
@end

#pragma mark -

@implementation CPPhotosTableViewController

NSString *CPPhotosListViewAccessibilityLabel = @"Picture list table";
//NSString *PictureListViewAccessibilityLabel = @"Picture list";
NSString *PictureListBackBarButtonAccessibilityLabel = @"Back";
NSString *CPActivityIndicatorMarkerForKIF = @"Activity indicator for KIF marker";

#pragma mark - Synthesize

@synthesize listOfPhotos = CP_listOfPhotos;
@synthesize indexedListOfPhotos = CP_indexedListOfPhotos;
@synthesize currentPlace = CP_currentPlace;
@synthesize placeID = CP_placeID;
//@synthesize iPadScrollableImageViewControllerDelegate = CP_iPadScrollableImageViewControllerDelegate;

#pragma mark - Factory method

+ (id)photosTableViewControllerWithRefinedElement:(CPPlacesRefinedElement *)refinedElement manageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPPhotosTableViewController *photosTableViewController = nil;
	CPPlacesRefinedElement *placesRefinedElement = nil;
	if ([refinedElement isKindOfClass:[CPPlacesRefinedElement class]]) 
	{
		placesRefinedElement = (CPPlacesRefinedElement *)refinedElement;
		NSString *placeID = [placesRefinedElement.dictionary objectForKey:@"place_id"];
		//TODO: check if this placeID duplication check works. (write a test)
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
		fetchRequest.fetchBatchSize = 1;
		fetchRequest.predicate = [NSPredicate predicateWithFormat:@"placeID like %@",placeID];
		[fetchRequest setSortDescriptors:nil];
		
		Place *chosenPlace = nil;
		
		NSError *error = nil;
		NSUInteger returnedObjectCount = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
		if ((returnedObjectCount == 0) && !error)
		{
			chosenPlace = (Place *)[NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:managedObjectContext];
	//		Place *chosenPlace = [[Place alloc] initWithEntity:@"Place" insertIntoManagedObjectContext:managedObjectContext];
			chosenPlace.title = placesRefinedElement.title;
			chosenPlace.subtitle = placesRefinedElement.subtitle;
			chosenPlace.category = [chosenPlace.title substringToIndex:1];
			chosenPlace.placeID = placeID;
			chosenPlace.hasFavoritePhoto = [NSNumber numberWithBool:NO];
			
			NSError *error = nil;
			
//Hal's approach to finding the source of error.
			
			NSLog(@"about to save: inserted %d registered %d deleted %d", managedObjectContext.insertedObjects.count, managedObjectContext.registeredObjects.count, managedObjectContext.deletedObjects.count);
			if (![managedObjectContext save:&error])
			{
				//handle the error.
				NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
			}
			NSLog(@"after save: inserted %d registered %d deleted %d", managedObjectContext.insertedObjects.count, managedObjectContext.registeredObjects.count, managedObjectContext.deletedObjects.count);
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
				chosenPlace = [fetchRequestOutput lastObject];
			}
		}
		[fetchRequest release];
		CPPhotosRefinedElement *refinedElementForDataIndexer = [[CPPhotosRefinedElement alloc] init];
		CPPhotosDataIndexer *dataIndexHandler = [[CPPhotosDataIndexer alloc] initWithRefinedElement:refinedElementForDataIndexer];
		[refinedElementForDataIndexer release];
		CPPhotosTableViewHandler *tableViewHandler = [[CPPhotosTableViewHandler alloc] init];
		photosTableViewController = [[[CPPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain dataIndexHandler:dataIndexHandler tableViewHandler:tableViewHandler placeIDString:chosenPlace.placeID] autorelease];
		[tableViewHandler release];
		[dataIndexHandler release];
		photosTableViewController.title = chosenPlace.title;
		photosTableViewController.currentPlace = chosenPlace;
		//TODO: change the initialization to pass the managedObjectContext as an argument.
		photosTableViewController.managedObjectContext = managedObjectContext;
	}
	return photosTableViewController;
}

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id)dataIndexHandler tableViewHandler:(id)tableViewHandler placeIDString:(NSString *)placeID;
{
	self = [super initWithStyle:style dataIndexHandler:dataIndexHandler tableViewHandler:tableViewHandler];
    if (self)
	{
		if (placeID)
		{
			self.placeID = placeID;
			self.view.accessibilityLabel = CPPhotosListViewAccessibilityLabel;
		}
	}
	return self;
}

//TODO: change the initializers to not include with****


#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_indexedListOfPhotos release];
	[CP_listOfPhotos release];
	[CP_currentPlace release];
	[super dealloc];
}


#pragma mark - Convenience method

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	if (!self.listOfPhotos)
	{
		[self CP_setupPhotosListWithPlaceID:self.placeID];
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
		id undeterminedListOfPhotos = [flickrDataHandler flickrPhotoListWithPlaceID:self.placeID];
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
