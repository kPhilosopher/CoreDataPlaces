//
//  CPTopPlacesTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTopPlacesTableViewController.h"
#import "CPTopPlacesTableViewHandler.h"
#import "CPPlacesRefinedElement.h"
#import "CPPlacesDataIndexer.h"
#import "CPPlacesRefinary.h"
#import "CPFlickrDataHandler.h"
#import "CPNotificationManager.h"
#import "CPIndexAssistant.h"
#import "UIActivityIndicatorView+Additions.h"


@interface CPTopPlacesTableViewController ()
{
@private
	UIActivityIndicatorView *CP_activityIndicator;
}

#pragma mark - Property

@property (retain) UIActivityIndicatorView *activityIndicator;

@end

#pragma mark -

NSString *CPTopPlacesTableViewAccessibilityLabel = @"Top places table";

@implementation CPTopPlacesTableViewController

#pragma mark - Synthesize

@synthesize activityIndicator = CP_activityIndicator;

#pragma mark - Factory method

+ (id)topPlacesTableViewControllerWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{	
	CPPlacesRefinary *refinary = [[[CPPlacesRefinary alloc] init] autorelease];
	CPPlacesDataIndexer *dataIndexer = [[[CPPlacesDataIndexer alloc] init] autorelease];
	CPTopPlacesTableViewHandler *tableViewHandler = [[[CPTopPlacesTableViewHandler alloc] init] autorelease];
	CPPlacesRefinedElement *refinedElementType = [[[CPPlacesRefinedElement alloc] init] autorelease];
	CPIndexAssistant *indexAssistant = [[[CPIndexAssistant alloc] initWithRefinary:refinary dataIndexer:dataIndexer tableViewHandler:tableViewHandler refinedElementType:refinedElementType] autorelease];
	
	CPTopPlacesTableViewController *topPlacesTableViewController = [[CPTopPlacesTableViewController alloc] initWithStyle:UITableViewStylePlain indexAssitant:indexAssistant managedObjectContext:managedObjectContext];
	
	return [topPlacesTableViewController autorelease];
}

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

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_activityIndicator release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	if (!self.listOfRawElements)
	{
		[self CP_setupTopPlacesList];
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

#pragma mark - Convenience method

- (void)CP_setupTopPlacesList;
{
	if (self.activityIndicator == nil) 
	{
		self.activityIndicator = [UIActivityIndicatorView activityIndicatorOnKIFTestableViewWithView:self.navigationController.view];
		[self.activityIndicator startAnimating];
	}
	
	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
	dispatch_queue_t placesDownloadQueue = dispatch_queue_create("Flickr places downloader", NULL);
	dispatch_async(placesDownloadQueue, ^{
		
		id undeterminedListOfPlaces = [flickrDataHandler flickrTopPlaces];
		[flickrDataHandler release];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			
			[self.activityIndicator removeKIFAndActivityIndicatorView];
			self.activityIndicator = nil;
			
			if ([undeterminedListOfPlaces isKindOfClass:[NSArray class]]) 
			{
				self.listOfRawElements = (NSArray *)undeterminedListOfPlaces;
				[self indexTheTableViewData];
			}
			else
				[[NSNotificationCenter defaultCenter] postNotificationName:CPNetworkErrorOccuredNotification object:self];
		});
	});
	dispatch_release(placesDownloadQueue);
}

@end
