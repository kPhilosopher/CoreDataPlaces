//
//  CPMostRecentPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosTableViewController-Internal.h"
#import "Photo+Logic.h"
#import "CPScrollableImageViewController.h"
#import "CPMostRecentPhotosRefinedElement.h"
//#import "CPMostRecentPhotosDataIndexer.h"
#import "CPMostRecentPhotosTableViewHandler.h"
#import "CPMostRecentPhotosRefinary.h"
#import "CPMostRecentPhotosDataHandler.h"
#import "CPAppDelegate.h"


@interface CPMostRecentPhotosTableViewController()
{
	@private
	id<CPRefining> CP_refinary;
	id<CPDataIndexHandlingTemporary> CP_tempDataIndexer;
	CPMostRecentPhotosRefinedElement *CP_refinedElementType;
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

@synthesize tempDataIndexer = CP_tempDataIndexer;
@synthesize listOfRawElements = CP_listOfRawElements;
@synthesize refinedElementSections = CP_refinedElementSections;
@synthesize refinary = CP_refinary;
@synthesize refinedElementType = CP_refinedElementType;
@synthesize fetchRequest = CP_fetchRequest;

#pragma mark - Factory method

+ (id)mostRecentPhotosTableViewControllerWithManageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPMostRecentPhotosTableViewHandler *tableViewHandler = [[[CPMostRecentPhotosTableViewHandler alloc] init] autorelease];
	CPMostRecentPhotosDataIndexer *dataIndexer = [[CPMostRecentPhotosDataIndexer alloc] init];
	CPMostRecentPhotosRefinary *refinary = [[CPMostRecentPhotosRefinary alloc] init];
	CPMostRecentPhotosRefinedElement *refinedElementType = [[CPMostRecentPhotosRefinedElement alloc] init];
	CPMostRecentPhotosDataHandler *dataHandler = [[[CPMostRecentPhotosDataHandler alloc] initWithRefinedElementType:refinedElementType refinary:refinary dataIndexer:dataIndexer] autorelease];
	[dataIndexer release]; dataIndexer = nil;
	[refinedElementType release]; refinedElementType = nil;
	[refinary release]; refinary = nil;
	return [[[CPMostRecentPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain dataIndexHandler:nil tableViewHandler:tableViewHandler managedObjectContext:managedObjectContext dataHandler:dataHandler] autorelease];
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

- (NSDate *)CP_dateOfTimeIntervalBetweenNowAndHoursAgo:(int)hour;
{
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setHour:-hour];
	NSCalendar *gregorian = [[[NSCalendar alloc]
							  initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	return [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
}

- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler managedObjectContext:(NSManagedObjectContext *)managedObjectContext dataHandler:(CPMostRecentPhotosDataHandler *)dataHandler;
{
	self = [self initWithStyle:style dataIndexHandler:dataIndexHandler tableViewHandler:tableViewHandler];
    if (self) {
		self.refinedElementType = dataHandler.refinedElementType;
		self.refinary = dataHandler.refinary;
		self.tempDataIndexer = dataHandler.dataIndexer;
		self.managedObjectContext = managedObjectContext;
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
	[CP_tempDataIndexer release];
	[CP_refinary release];
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
		if (mutableFetchResults == nil) {
			// Handle the error.
		}
		self.listOfRawElements = mutableFetchResults;
		[mutableFetchResults release]; mutableFetchResults = nil;
		[self indexTheTableViewData];
		CP_reindex = NO;
	}
}

#pragma mark - CPTableViewControllerDataMutating protocol method

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array;
{
	self.refinedElementSections = array;
}

- (NSMutableArray *)fetchTheElementSections;
{
	return CP_refinedElementSections;
}

- (NSArray *)fetchTheRawData;
{
	return CP_listOfRawElements;
}

#pragma mark - DataReloadForTableViewControllerProtocol implementation

- (void)indexTheTableViewData
{
	//TODO:change the condition of the if statement.
	if (self.tempDataIndexer != nil) 
	{
		NSArray *refinedElements = [self.refinary refinedElementsWithGivenRefinedElementType:self.refinedElementType rawElements:[self fetchTheRawData]];
		[self setTheElementSectionsToTheFollowingArray:
		 [self.tempDataIndexer indexedSectionsOfRefinedElements:refinedElements]];
		[self.tableView reloadData];
	}
}

@end
