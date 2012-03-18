//
//  CPPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewController-Internal.h"
#import "CPPhotosRefinary.h"
#import "CPPhotosDataIndexer.h"
#import "CPPhotosTableViewHandler.h"
#import "CPPhotosRefinedElement.h"
#import "CPIndexAssistant.h"
#import "CPPlacesRefinedElement.h"
#import "CPFlickrDataHandler.h"
#import "Place.h"
#import "CPNotificationManager.h"
#import "UIActivityIndicatorView+NavigationController.h"


@interface CPPhotosTableViewController ()
{
@private
	NSArray *CP_listOfPhotos;
	NSMutableArray *CP_indexedListOfPhotos;
	CPPlacesRefinedElement *CP_placeRefinedElement;
	UIActivityIndicatorView *CP_activityIndicator;
}
@end

#pragma mark -

@implementation CPPhotosTableViewController

NSString *CPPhotosListViewAccessibilityLabel = @"Picture list table";

#pragma mark - Synthesize

@synthesize listOfPhotos = CP_listOfPhotos;
@synthesize indexedListOfPhotos = CP_indexedListOfPhotos;
@synthesize placeRefinedElement = CP_placeRefinedElement;
@synthesize activityIndicator = CP_activityIndicator;

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
	[CP_activityIndicator release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	if (!self.listOfPhotos)
	{
		[self CP_setupPhotosListWithPlaceID:self.placeRefinedElement.placeID];
	}
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{	
	self.activityIndicator.superview.center = CGPointMake(self.navigationController.view.bounds.size.width/2, self.navigationController.view.bounds.size.height/2);
}

#pragma mark - Internal method

- (void)CP_setupPhotosListWithPlaceID:(NSString *)placeID;
{
	if (self.activityIndicator == nil) 
	{
		self.activityIndicator = [UIActivityIndicatorView activityIndicatorOnKIFTestableViewWithNavigationController:self.navigationController];
		[self.activityIndicator startAnimating];
	}
	
	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
	dispatch_queue_t photosDownloadQueue = dispatch_queue_create("Flickr photos downloader", NULL);
	dispatch_async(photosDownloadQueue, ^{
		id undeterminedListOfPhotos = [flickrDataHandler flickrPhotoListWithPlaceID:self.placeRefinedElement.placeID];
		[flickrDataHandler release];
		dispatch_async(dispatch_get_main_queue(), ^{
			if ([undeterminedListOfPhotos isKindOfClass:[NSArray class]]) 
			{
				self.listOfPhotos = (NSArray *)undeterminedListOfPhotos;
				[self indexTheTableViewData];
			}
			else
			{
				[[NSNotificationCenter defaultCenter] postNotificationName:CPNetworkErrorOccuredNotification object:self];
			}
			
			[self.activityIndicator stopAnimating];
			[self.activityIndicator removeFromSuperview];
			UIView *KIFView = self.activityIndicator.superview;
			[KIFView removeFromSuperview];
			self.activityIndicator = nil;
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
