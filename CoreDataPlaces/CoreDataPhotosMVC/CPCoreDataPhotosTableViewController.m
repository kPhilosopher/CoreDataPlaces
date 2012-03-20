//
//  CPCoreDataPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPCoreDataPhotosTableViewController.h"
#import "CPPhotosDataIndexer.h"
#import "CPCoreDataPhotosTableViewHandler.h"
#import "CPMostRecentPhotosRefinary.h"
#import "CPRefinedElement.h"
#import "CPIndexAssistant.h"
#import "Photo+Logic.h"
#import "Place.h"
#import "NSDate+Additions.h"


@interface CPCoreDataPhotosTableViewController()
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

NSString *CPFavoritePhotosTableViewAccessibilityLabel = @"Favorite photos table";
NSString *CPMostRecentPhotosTableViewAccessibilityLabel = @"Most recent photos table";

const int CPMaximumHoursForMostRecentPhoto = 48;

@implementation CPCoreDataPhotosTableViewController

#pragma mark - Synthesize

@synthesize currentPlace = CP_currentPlace;
@synthesize fetchRequest = CP_fetchRequest;
@synthesize propertyToMonitor = CP_propertyToMonitor;

#pragma mark - Factory method

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
	
	CPCoreDataPhotosTableViewController *mostRecentPhotosTableViewController = [[CPCoreDataPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext title:@"Most Recents" fetchRequest:fetchRequest];
	
	mostRecentPhotosTableViewController.tableView.accessibilityLabel = CPMostRecentPhotosTableViewAccessibilityLabel;
	mostRecentPhotosTableViewController.propertyToMonitor = @"timeOfLastView";
	
	return [mostRecentPhotosTableViewController autorelease];
}

+ (id)coreDataPhotosTableViewControllerWithPlace:(Place *)chosenPlace manageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPCoreDataPhotosRefinary *refinary = [[[CPCoreDataPhotosRefinary alloc] init] autorelease];
	CPPhotosDataIndexer *dataIndexer = [[[CPPhotosDataIndexer alloc] init] autorelease];
	CPCoreDataPhotosTableViewHandler *tableViewHandler = [[[CPCoreDataPhotosTableViewHandler alloc] init] autorelease];
	CPRefinedElement *refinedElementType = [[[CPRefinedElement alloc] init] autorelease];
	CPIndexAssistant *indexAssistant = [[[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType] autorelease];

	NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:managedObjectContext];
	fetchRequest.predicate = [NSPredicate
								   predicateWithFormat:@"(isFavorite == %@) AND (itsPlace.placeID like %@)", [NSNumber numberWithBool:YES], chosenPlace.placeID];
	fetchRequest.fetchBatchSize = 20;

	CPCoreDataPhotosTableViewController *coreDataPhotosTableViewController = [[CPCoreDataPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext fetchRequest:fetchRequest place:chosenPlace];

	coreDataPhotosTableViewController.tableView.accessibilityLabel = CPFavoritePhotosTableViewAccessibilityLabel;
	coreDataPhotosTableViewController.propertyToMonitor = @"isFavorite";

	return [coreDataPhotosTableViewController autorelease];
}

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext fetchRequest:(NSFetchRequest *)fetchRequest place:(Place *)place;
{
	self = [self initWithStyle:style indexAssitant:indexAssistant managedObjectContext:managedObjectContext title:place.title fetchRequest:fetchRequest];
    if (self)
	{
		self.currentPlace = place;
	}
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext title:(NSString *)title fetchRequest:(NSFetchRequest *)fetchRequest;
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
			if ([element isKindOfClass:[Photo class]])
			{
				Photo *photo = (Photo *)element;
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
