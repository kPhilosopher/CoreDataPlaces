//
//  CPCoreDataTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPCoreDataTableViewController.h"
#import "CPPhotosDataIndexer.h"
#import "CPCoreDataPhotosTableViewHandler.h"
#import "CPMostRecentPhotosRefinary.h"
#import "CPFavoritePhotosRefinary.h"
#import "CPRefinedElement.h"
#import "CPIndexAssistant.h"
#import "Photo+Logic.h"
#import "Place.h"
#import "NSDate+Additions.h"
#import "CPFavoritePlacesRefinary.h"
#import "CPPlacesDataIndexer.h"
#import "CPFavoritePlacesTableViewHandler.h"
#import "CPPlacesRefinedElement.h"


@interface CPCoreDataTableViewController()
{
@private
	NSFetchRequest *CP_fetchRequest;
	Place *CP_currentPlace;
	BOOL CP_reindex;
	NSString *CP_propertyToMonitor;
}

#pragma mark - Property

@property (retain) NSFetchRequest *fetchRequest;
@property (retain) NSString *propertyToMonitor;

@end

#pragma mark -

NSString *CPFavoritePhotosTableViewAccessibilityLabel = @"Favorite photos table";
NSString *CPMostRecentPhotosTableViewAccessibilityLabel = @"Most recent photos table";
NSString *CPFavoritePlacesTableViewAccessibilityLabel = @"Favorite places table";

const int CPMaximumHoursForMostRecentPhoto = 48;

@implementation CPCoreDataTableViewController

#pragma mark - Synthesize

@synthesize currentPlace = CP_currentPlace;
@synthesize fetchRequest = CP_fetchRequest;
@synthesize propertyToMonitor = CP_propertyToMonitor;

#pragma mark - Factory method

+ (id)favoritePlacesTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPFavoritePlacesRefinary *refinary = [[[CPFavoritePlacesRefinary alloc] init] autorelease];
	CPPlacesDataIndexer *dataIndexer = [[[CPPlacesDataIndexer alloc] init] autorelease];
	CPFavoritePlacesTableViewHandler *tableViewHandler = [[[CPFavoritePlacesTableViewHandler alloc] init] autorelease];
	CPPlacesRefinedElement *refinedElementType = [[[CPPlacesRefinedElement alloc] init] autorelease];
	CPIndexAssistant *indexAssistant = [[[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType] autorelease];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"hasFavoritePhoto == %@",[NSNumber numberWithBool:YES]];
	fetchRequest.fetchBatchSize = 20;
	
	CPCoreDataTableViewController *favoritePlacesTableViewController = [[CPCoreDataTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext fetchRequest:fetchRequest title:@"Favorite Photos"];
	
	favoritePlacesTableViewController.tableView.accessibilityLabel = CPFavoritePlacesTableViewAccessibilityLabel;
	favoritePlacesTableViewController.propertyToMonitor = @"hasFavoritePhoto";
	
	return [favoritePlacesTableViewController autorelease];
}

+ (id)mostRecentPhotosTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPMostRecentPhotosRefinary *refinary = [[[CPMostRecentPhotosRefinary alloc] init] autorelease];
	CPPhotosDataIndexer *dataIndexer = [[[CPPhotosDataIndexer alloc] init] autorelease];
	CPCoreDataPhotosTableViewHandler *tableViewHandler = [[[CPCoreDataPhotosTableViewHandler alloc] init] autorelease];
	CPRefinedElement *refinedElementType = [[[CPRefinedElement alloc] init] autorelease];
	CPIndexAssistant *indexAssistant = [[[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType] autorelease];
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:managedObjectContext];
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"timeOfLastView >= %@",[NSDate dateOfTimeIntervalBetweenNowAndHoursAgo:CPMaximumHoursForMostRecentPhoto]];
	fetchRequest.fetchBatchSize = 20;
	
	CPCoreDataTableViewController *mostRecentPhotosTableViewController = [[CPCoreDataTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext fetchRequest:fetchRequest title:@"Most Recents"];
	
	mostRecentPhotosTableViewController.tableView.accessibilityLabel = CPMostRecentPhotosTableViewAccessibilityLabel;
	mostRecentPhotosTableViewController.propertyToMonitor = @"timeOfLastView";
	
	return [mostRecentPhotosTableViewController autorelease];
}

+ (id)coreDataPhotosTableViewControllerWithPlace:(Place *)chosenPlace manageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPFavoritePhotosRefinary *refinary = [[[CPFavoritePhotosRefinary alloc] init] autorelease];
	CPPhotosDataIndexer *dataIndexer = [[[CPPhotosDataIndexer alloc] init] autorelease];
	CPCoreDataPhotosTableViewHandler *tableViewHandler = [[[CPCoreDataPhotosTableViewHandler alloc] init] autorelease];
	CPRefinedElement *refinedElementType = [[[CPRefinedElement alloc] init] autorelease];
	CPIndexAssistant *indexAssistant = [[[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType] autorelease];
	
	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:managedObjectContext];
	fetchRequest.predicate = [NSPredicate
							  predicateWithFormat:@"(isFavorite == %@) AND (itsPlace.placeID like %@)", [NSNumber numberWithBool:YES], chosenPlace.placeID];
	fetchRequest.fetchBatchSize = 20;
	
	CPCoreDataTableViewController *coreDataPhotosTableViewController = [[CPCoreDataTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext fetchRequest:fetchRequest place:chosenPlace];
	
	coreDataPhotosTableViewController.tableView.accessibilityLabel = CPFavoritePhotosTableViewAccessibilityLabel;
	coreDataPhotosTableViewController.propertyToMonitor = @"isFavorite";
	
	return [coreDataPhotosTableViewController autorelease];
}

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext fetchRequest:(NSFetchRequest *)fetchRequest place:(Place *)place;
{
	self = [self initWithStyle:style indexAssitant:indexAssistant managedObjectContext:managedObjectContext fetchRequest:fetchRequest title:place.title];
    if (self)
	{
		self.currentPlace = place;
	}
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext fetchRequest:(NSFetchRequest *)fetchRequest title:(NSString *)title;
{
	self = [super initWithStyle:style indexAssitant:indexAssistant managedObjectContext:managedObjectContext];
    if (self)
	{
		self.title = title;
		CP_reindex = YES;
		self.fetchRequest = fetchRequest;
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(CP_checkTheChangeInManagedObjectContext:)
													 name:NSManagedObjectContextObjectsDidChangeNotification
												   object:self.managedObjectContext];
	}
    return self;
}

#pragma mark - View lifecycle

- (void)dealloc;
{
	[CP_currentPlace release];
	[CP_fetchRequest release];
	[CP_propertyToMonitor release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	if (CP_reindex) 
	{
		[self CP_fetchRawElementsThenIndex];
	}
}

#pragma mark - Internal method

- (void)CP_fetchRawElementsThenIndex;
{
	NSError *error = nil;
	
	NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:self.fetchRequest error:&error] mutableCopy];
	if (mutableFetchResults == nil)
	{
		// Handle the error.
	}
	self.listOfRawElements = mutableFetchResults;
	[mutableFetchResults release]; mutableFetchResults = nil;
	[self indexTheTableViewData];
	CP_reindex = NO;
}

- (void)CP_checkTheChangeInManagedObjectContext:(NSNotification *)notification;
{
	if ([[notification.userInfo objectForKey:NSUpdatedObjectsKey] isKindOfClass:[NSSet class]])
	{
		NSSet *setOfUpdatedObjects = (NSSet *)[notification.userInfo objectForKey:NSUpdatedObjectsKey];
		for (id element in setOfUpdatedObjects) 
		{
			if ([element isKindOfClass:[NSManagedObject class]])
			{
				NSManagedObject *photo = (NSManagedObject *)element;
				if ([photo.changedValuesForCurrentEvent objectForKey:self.propertyToMonitor])
				{
					if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
						[self CP_fetchRawElementsThenIndex];
					else
						CP_reindex = YES;
				}
			}
		}
	}
}

@end
