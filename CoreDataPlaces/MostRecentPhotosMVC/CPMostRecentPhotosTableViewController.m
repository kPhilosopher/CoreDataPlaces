//
//  CPMostRecentPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosTableViewController-Internal.h"
#import "Photo+Logic.h"
#import "CPMostRecentPhotosRefinary.h"
#import "CPMostRecentPhotosDataIndexer.h"
#import "CPMostRecentPhotosTableViewHandler.h"
#import "CPRefinedElement.h"
#import "CPIndexAssistant.h"
#import "CPScrollableImageViewController.h"
#import "CPAppDelegate.h"


@interface CPMostRecentPhotosTableViewController()
{
	@private

	NSArray *CP_listOfRawElements;
	NSMutableArray *CP_refinedElementSections;
	BOOL CP_reindex;
	NSFetchRequest *CP_fetchRequest;
}
@end

#pragma mark -

NSString *CPMostRecentPhotosTableViewAccessibilityLabel = @"Most recent photos table";

const int CPMaximumHoursForMostRecentPhoto = 48;

@implementation CPMostRecentPhotosTableViewController

#pragma mark - Synthesize

@synthesize listOfRawElements = CP_listOfRawElements;
@synthesize refinedElementSections = CP_refinedElementSections;
@synthesize fetchRequest = CP_fetchRequest;

#pragma mark - Factory method

+ (id)mostRecentPhotosTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPMostRecentPhotosRefinary *refinary = [[CPMostRecentPhotosRefinary alloc] init];
	CPMostRecentPhotosDataIndexer *dataIndexer = [[CPMostRecentPhotosDataIndexer alloc] init];
	CPMostRecentPhotosTableViewHandler *tableViewHandler = [[CPMostRecentPhotosTableViewHandler alloc] init];
	CPRefinedElement *refinedElementType = [[CPRefinedElement alloc] init];
	CPIndexAssistant *indexAssistant = [[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType];
	[refinary release]; refinary = nil;
	[dataIndexer release]; dataIndexer = nil;
	[tableViewHandler release]; tableViewHandler = nil;
	[refinedElementType release]; refinedElementType = nil;
	CPMostRecentPhotosTableViewController *mostRecentPhotosTableViewController = [[CPMostRecentPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext];
	[indexAssistant release]; indexAssistant = nil;
	return [mostRecentPhotosTableViewController autorelease];
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
				if ([photo.changedValuesForCurrentEvent objectForKey:@"timeOfLastView"])
				{
					CP_reindex = YES;
					CPAppDelegate *appDelegate = (CPAppDelegate *)[[UIApplication sharedApplication] delegate];
					if ([appDelegate window].bounds.size.width > 500)//iPad
					{
						[self viewWillAppear:YES];
					}
				}
			}
		}
	}
}

//TODO: fix the location of this method
- (NSDate *)CP_dateOfTimeIntervalBetweenNowAndHoursAgo:(int)hour;
{
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setHour:-hour];
	NSCalendar *gregorian = [[[NSCalendar alloc]
							  initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	return [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
}

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	self = [super initWithStyle:style indexAssitant:indexAssistant managedObjectContext:managedObjectContext];
    if (self)
	{
		self.title = @"Most Recents";
		CP_reindex = YES;
		self.tableView.accessibilityLabel = CPMostRecentPhotosTableViewAccessibilityLabel;
		
		//TODO: make it so that the fetchrequest is made from a different object and given to this view controller.
		self.fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
		self.fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
		self.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"timeOfLastView >= %@",[self CP_dateOfTimeIntervalBetweenNowAndHoursAgo:CPMaximumHoursForMostRecentPhoto]];//changed
		self.fetchRequest.fetchBatchSize = 20;
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(CP_checkTheChangeInManagedObjectContext:)
													 name:NSManagedObjectContextObjectsDidChangeNotification
												   object:self.managedObjectContext];
	}
    return self;
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_listOfRawElements release];
	[CP_refinedElementSections release];
	[CP_fetchRequest release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
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
		CP_reindex = NO;
	}
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
