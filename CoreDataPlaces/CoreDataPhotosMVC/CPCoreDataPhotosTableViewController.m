//
//  CPCoreDataPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPCoreDataPhotosTableViewController-Internal.h"
#import "CPCoreDataPhotosRefinary.h"
#import "CPPhotosDataIndexer.h"
#import "CPCoreDataPhotosTableViewHandler.h"
#import "CPRefinedElement.h"
#import "CPIndexAssistant.h"
#import "Photo+Logic.h"
#import "Place.h"
#import "CPScrollableImageViewController.h"
#import "CPAppDelegate.h"


@interface CPCoreDataPhotosTableViewController()
{
	@private
	NSArray *CP_listOfRawElements;
	NSMutableArray *CP_refinedElementSections;
	NSFetchRequest *CP_fetchRequest;
	Place *CP_currentPlace;
	BOOL CP_reindex;
}
@end

@implementation CPCoreDataPhotosTableViewController

NSString *CPFavoritePhotosTableViewAccessibilityLabel = @"Favorite photos table";

#pragma mark - Synthesize

@synthesize currentPlace = CP_currentPlace;
@synthesize fetchRequest = CP_fetchRequest;
@synthesize listOfRawElements = CP_listOfRawElements;
@synthesize refinedElementSections = CP_refinedElementSections;


#pragma mark - Factory method

+ (id)coreDataPhotosTableViewControllerWithPlace:(Place *)chosenPlace manageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPCoreDataPhotosRefinary *refinary = [[CPCoreDataPhotosRefinary alloc] init];
	CPPhotosDataIndexer *dataIndexer = [[CPPhotosDataIndexer alloc] init];
	CPCoreDataPhotosTableViewHandler *tableViewHandler = [[CPCoreDataPhotosTableViewHandler alloc] init];
	CPRefinedElement *refinedElementType = [[CPRefinedElement alloc] init];
	CPIndexAssistant *indexAssistant = [[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType];
	[refinary release]; refinary = nil;
	[dataIndexer release]; dataIndexer = nil;
	[tableViewHandler release]; tableViewHandler = nil;
	[refinedElementType release]; refinedElementType = nil;
	CPCoreDataPhotosTableViewController *coreDataPhotosTableViewController = [[CPCoreDataPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext place:chosenPlace];
	[indexAssistant release]; indexAssistant = nil;
	return [coreDataPhotosTableViewController autorelease];
}

#pragma mark - Initialization

//TODO: fix the location of this method
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
				if ([photo.changedValuesForCurrentEvent objectForKey:@"isFavorite"])
				{
					CP_reindex = YES;
					CPAppDelegate *appDelegate = (CPAppDelegate *)[[UIApplication sharedApplication] delegate];
					if ([appDelegate window].bounds.size.width > 500)//iPad
					{
						[self CP_fetchListThenIndexData];
					}
				}
			}
		}
	}
}

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext place:(Place *)place;
{
	self = [super initWithStyle:style indexAssitant:indexAssistant managedObjectContext:managedObjectContext];
    if (self)
	{
		self.currentPlace = place;
		self.title = place.title;
		CP_reindex = YES;
		self.tableView.accessibilityLabel = CPFavoritePhotosTableViewAccessibilityLabel;
		
		//TODO: make it so that the fetchrequest is made from a different object and given to this view controller.
		self.fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
		self.fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
		self.fetchRequest.predicate = [NSPredicate
									   predicateWithFormat:@"(isFavorite == %@) AND (itsPlace.placeID like %@)", [NSNumber numberWithBool:YES], place.placeID];
		self.fetchRequest.fetchBatchSize = 20;
		
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
	[CP_listOfRawElements release];
	[CP_refinedElementSections release];
	[CP_currentPlace release];
	[CP_fetchRequest release];
	[super dealloc];
}

- (void)CP_fetchListThenIndexData;
{
	if (CP_reindex) 
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
	}
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	[self CP_fetchListThenIndexData];
}

#pragma mark - CPTableViewControllerDataMutating protocol method

- (void)setTheElementSections:(NSMutableArray *)array;
{
	self.refinedElementSections = array;
}

- (NSMutableArray *)theElementSections;
{
	return CP_refinedElementSections;
}

- (NSArray *)theRawData;
{
	return CP_listOfRawElements;
}

@end
