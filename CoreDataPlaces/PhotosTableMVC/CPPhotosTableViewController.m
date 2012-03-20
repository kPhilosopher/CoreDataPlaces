//
//  CPPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewController.h"
#import "CPPhotosRefinary.h"
#import "CPPhotosDataIndexer.h"
#import "CPPhotosTableViewHandler.h"
#import "CPPhotosRefinedElement.h"
#import "CPIndexAssistant.h"
#import "CPPlacesRefinedElement.h"
#import "CPFlickrDataHandler.h"
#import "Place.h"
#import "CPNotificationManager.h"
#import "UIActivityIndicatorView+Additions.h"


@interface CPPhotosTableViewController ()
{
@private
	CPPlacesRefinedElement *CP_placeRefinedElement;
	UIActivityIndicatorView *CP_activityIndicator;
}

#pragma mark - Property

@property (retain) UIActivityIndicatorView *activityIndicator;

@end

#pragma mark -

@implementation CPPhotosTableViewController

NSString *CPPhotosListViewAccessibilityLabel = @"Picture list table";

#pragma mark - Synthesize

@synthesize placeRefinedElement = CP_placeRefinedElement;
@synthesize activityIndicator = CP_activityIndicator;

#pragma mark - Factory method

+ (id)photosTableViewControllerWithRefinedElement:(CPPlacesRefinedElement *)refinedElement manageObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	CPPhotosRefinary *refinary = [[[CPPhotosRefinary alloc] init] autorelease];
	CPPhotosDataIndexer *dataIndexer = [[[CPPhotosDataIndexer alloc] init] autorelease];
	CPPhotosTableViewHandler *tableViewHandler = [[[CPPhotosTableViewHandler alloc] init] autorelease];
	CPPhotosRefinedElement *refinedElementType = [[[CPPhotosRefinedElement alloc] init] autorelease];
	CPIndexAssistant *indexAssitant = [[[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType] autorelease];
	CPPhotosTableViewController *photosTableViewController = [[CPPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssitant managedObjectContext:managedObjectContext placeRefinedElement:refinedElement];
	return [photosTableViewController autorelease];
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
	[CP_placeRefinedElement release];
	[CP_activityIndicator release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	if (!self.listOfRawElements)
	{
		[self CP_setupPhotosListWithPlaceID:self.placeRefinedElement.placeID];
	}
}

- (void)viewWillDisappear:(BOOL)animated;
{
	[self.activityIndicator removeKIFAndActivityIndicatorView];
	self.activityIndicator = nil;
	[super viewWillDisappear:animated];
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
		self.activityIndicator = [UIActivityIndicatorView activityIndicatorOnKIFTestableViewWithView:self.navigationController.view];
		[self.activityIndicator startAnimating];
	}
	
	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
	dispatch_queue_t photosDownloadQueue = dispatch_queue_create("Flickr photos downloader", NULL);
	dispatch_async(photosDownloadQueue, ^{
		
		id undeterminedListOfPhotos = [flickrDataHandler flickrPhotoListWithPlaceID:self.placeRefinedElement.placeID];
		[flickrDataHandler release];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[self.activityIndicator removeKIFAndActivityIndicatorView];
			self.activityIndicator = nil;
			
			if ([undeterminedListOfPhotos isKindOfClass:[NSArray class]]) 
			{
				self.listOfRawElements = (NSArray *)undeterminedListOfPhotos;
				[self indexTheTableViewData];
			}
			else
				[[NSNotificationCenter defaultCenter] postNotificationName:CPNetworkErrorOccuredNotification object:self];
		});
	});
	dispatch_release(photosDownloadQueue);
}

@end
