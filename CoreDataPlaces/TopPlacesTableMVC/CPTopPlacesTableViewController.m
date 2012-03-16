//
//  CPTopPlacesTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTopPlacesTableViewController-Internal.h"
#import "CPTopPlacesTableViewHandler.h"
#import "CPPlacesRefinedElement.h"
#import "CPPlacesDataIndexer.h"
#import "CPPlacesRefinary.h"
#import "CPFlickrDataHandler.h"
#import "CPNotificationManager.h"
#import "CPIndexAssistant.h"

//TODO: change this when the extern string constants' location is changed.
//#import "CPPhotosTableViewController.h"


@interface CPTopPlacesTableViewController ()
{
@private
	NSArray *CP_listOfPlaces;
	NSMutableArray *CP_indexedListOfPlaces;
}

@end

#pragma mark -

@implementation CPTopPlacesTableViewController

NSString *CPTopPlacesTableViewAccessibilityLabel = @"Top places table";

#pragma mark - Synthesize

@synthesize listOfPlaces = CP_listOfPlaces;
@synthesize indexedListOfPlaces = CP_indexedListOfPlaces;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style indexAssitant:(CPIndexAssistant *)indexAssistant managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	self = [super initWithStyle:style indexAssitant:indexAssistant managedObjectContext:managedObjectContext];
    if (self)
	{
		self.title = @"Top Places";
		self.tableView.accessibilityLabel = CPTopPlacesTableViewAccessibilityLabel;
		
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(CP_setupTopPlacesList)] autorelease];
	}
    return self;
}

#pragma mark - Factory method

+ (id)topPlacesTableViewControllerWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{	
	CPTopPlacesTableViewHandler *tableViewHandler = [[CPTopPlacesTableViewHandler alloc] init];
	CPPlacesRefinedElement *refinedElementType = [[CPPlacesRefinedElement alloc] init];
	CPPlacesDataIndexer *dataIndexer = [[CPPlacesDataIndexer alloc] init];
	CPPlacesRefinary *refinary = [[CPPlacesRefinary alloc] init];
	CPIndexAssistant *indexAssistant = [[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType];
	[refinary release]; refinary = nil;
	[dataIndexer release]; dataIndexer = nil;
	[tableViewHandler release]; tableViewHandler = nil;
	[refinedElementType release]; refinedElementType = nil;
	CPTopPlacesTableViewController *topPlacesTableViewController = [[CPTopPlacesTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext];
	[indexAssistant release]; indexAssistant = nil;
	return [topPlacesTableViewController autorelease];
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_listOfPlaces release];
	[CP_indexedListOfPlaces release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	if (!self.listOfPlaces)
	{
		[self CP_setupTopPlacesList];
	}
	
}

#pragma mark - Convenience method

//- (void)CP_refreshTheTopPlacesList;
//{
//	[self CP_setupTopPlacesList];
//}

//TODO: refactor
- (void)CP_setupTopPlacesList;
{
	//TODO: find a better place to put this redundant code.
	UIView *theLabel = [[UIView alloc] init];
//	theLabel.accessibilityLabel = CPActivityIndicatorMarkerForKIF;
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
	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
	dispatch_queue_t placesDownloadQueue = dispatch_queue_create("Flickr places downloader", NULL);
	dispatch_async(placesDownloadQueue, ^{
		id undeterminedListOfPlaces = [flickrDataHandler flickrTopPlaces];
		[flickrDataHandler release];
		dispatch_async(dispatch_get_main_queue(), ^{
			[activityIndicator stopAnimating];
			if ([undeterminedListOfPlaces isKindOfClass:[NSArray class]]) 
			{
				self.listOfPlaces = (NSArray *)undeterminedListOfPlaces;
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
	dispatch_release(placesDownloadQueue);
}

#pragma mark - CPTableViewControllerDataMutating protocol method

- (void)setTheElementSections:(NSMutableArray *)array
{
	self.indexedListOfPlaces = array;
}

- (NSMutableArray *)theElementSections
{
	return self.indexedListOfPlaces;
}

- (NSArray *)theRawData
{
	return self.listOfPlaces;
}

@end
