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
#import "UIActivityIndicatorView+NavigationController.h"

//TODO: change this when the extern string constants' location is changed.
//#import "CPPhotosTableViewController.h"


@interface CPTopPlacesTableViewController ()
{
@private
	NSArray *CP_listOfPlaces;
	NSMutableArray *CP_indexedListOfPlaces;
	UIActivityIndicatorView *CP_activityIndicator;
}

@end

#pragma mark -

@implementation CPTopPlacesTableViewController

NSString *CPTopPlacesTableViewAccessibilityLabel = @"Top places table";

#pragma mark - Synthesize

@synthesize listOfPlaces = CP_listOfPlaces;
@synthesize indexedListOfPlaces = CP_indexedListOfPlaces;
@synthesize activityIndicator = CP_activityIndicator;

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
	[CP_activityIndicator release];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{	
	self.activityIndicator.superview.center = CGPointMake(self.navigationController.view.bounds.size.width/2, self.navigationController.view.bounds.size.height/2);
}

#pragma mark - Convenience method

//TODO: refactor
- (void)CP_setupTopPlacesList;
{
	if (self.activityIndicator == nil) 
	{
		self.activityIndicator = [UIActivityIndicatorView activityIndicatorOnKIFTestableViewWithNavigationController:self.navigationController];
		[self.activityIndicator startAnimating];
	}
	
	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
	dispatch_queue_t placesDownloadQueue = dispatch_queue_create("Flickr places downloader", NULL);
	dispatch_async(placesDownloadQueue, ^{
		id undeterminedListOfPlaces = [flickrDataHandler flickrTopPlaces];
		[flickrDataHandler release];
		dispatch_async(dispatch_get_main_queue(), ^{
			if ([undeterminedListOfPlaces isKindOfClass:[NSArray class]]) 
			{
				self.listOfPlaces = (NSArray *)undeterminedListOfPlaces;
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
