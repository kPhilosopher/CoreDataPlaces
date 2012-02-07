//
//  CPTopPlacesTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTopPlacesTableViewController-Internal.h"
#import "CPPlacesDataIndexer.h"
#import "CPTopPlacesTableViewHandler.h"
#import "CPFlickrDataSource.h"
#import "CPFlickrDataHandler.h"
#import "CPPlacesRefinedElement.h"


@interface CPTopPlacesTableViewController ()
{
@private
//	id<CPTableViewControllerDataReloading> CP_delegateToUpdateMostRecentPlaces;
	CPFlickrDataSource *CP_flickrDataSource;
//	id<PictureListTableViewControllerDelegate> CP_delegateToTransfer;
}

extern NSString *CPAlertTitle;
extern NSString *CPAlertMessage;

@end

#pragma mark -

@implementation CPTopPlacesTableViewController

NSString *CPTopPlacesViewAccessibilityLabel = @"Top places table";
NSString *CPAlertTitle = @"Cannot Obtain Data";
NSString *CPAlertMessage = @"We couldn't get the data from Flickr";

#pragma mark - Synthesize

//@synthesize delegateToUpdateMostRecentPlaces = _delegateToUpdateMostRecentPlaces;
@synthesize flickrDataSource = CP_flickrDataSource;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler theFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource;
{
	self = [super initWithStyle:style dataIndexHandler:dataIndexHandler tableViewHandler:tableViewHandler];
    if (self)
	{
		self.title = @"Top Places";
		self.view.accessibilityLabel = CPTopPlacesViewAccessibilityLabel;
		
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(CP_refreshTheTopPlacesList)] autorelease];
		
		self.flickrDataSource = theFlickrDataSource;
		[self.flickrDataSource addObserver:self forKeyPath:@"alertViewSwitch" options:NSKeyValueObservingOptionNew context:NULL];
		[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
	}
    return self;
}

#pragma mark - Factory method

+ (id)topPlacesTableViewController;
{
	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
	CPFlickrDataSource *flickrDataSource = [[CPFlickrDataSource alloc] initWithFlickrDataHandler:flickrDataHandler];
	
	[flickrDataHandler release];
	
	CPTopPlacesTableViewHandler *tableViewHandler = [[CPTopPlacesTableViewHandler alloc] init];
	CPPlacesRefinedElement *placesRefinedElement = [[CPPlacesRefinedElement alloc] init];
	CPPlacesDataIndexer *dataIndexHandler = [[CPPlacesDataIndexer alloc] initWithRefinedElement:placesRefinedElement];
	[placesRefinedElement release]; placesRefinedElement = nil;
	
	CPTopPlacesTableViewController *topPlacesTableViewController = [[CPTopPlacesTableViewController alloc] initWithStyle:UITableViewStylePlain dataIndexHandler:dataIndexHandler tableViewHandler:tableViewHandler theFlickrDataSource:flickrDataSource];
	
	[flickrDataSource release];
	[tableViewHandler release];
	[dataIndexHandler release];
	
	return [topPlacesTableViewController autorelease];
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_flickrDataSource release];
	[super dealloc];
}

#pragma mark - Convenience method

- (void)CP_refreshTheTopPlacesList;
{
	[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
	[self indexTheTableViewData];
}

#pragma mark - KVO observer implementation

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([[change objectForKey:NSKeyValueChangeNewKey] isEqualToString:CPAlertSwitchOn])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CPAlertTitle message:CPAlertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];	
		[alert show];
		[alert release];
		[object setValue:CPAlertSwitchOff forKey:keyPath];
	}
}

#pragma mark - CPTableViewControllerDataMutating protocol method

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array
{
	self.flickrDataSource.theElementSectionsOfFlickrTopPlaces = array;
}

- (NSMutableArray *)fetchTheElementSections
{
	return self.flickrDataSource.theElementSectionsOfFlickrTopPlaces;
}

- (NSArray *)fetchTheRawData
{
	return self.flickrDataSource.flickrTopPlaces;
}

@end
