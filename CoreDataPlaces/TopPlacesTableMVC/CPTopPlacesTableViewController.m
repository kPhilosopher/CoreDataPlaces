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
#import "CPNotificationManager.h"


@interface CPTopPlacesTableViewController ()
{
@private
	NSArray *CP_listOfPlaces;
	NSMutableArray *CP_indexedListOfPlaces;
//	id<CPTableViewControllerDataReloading> CP_delegateToUpdateMostRecentPlaces;
//	CPFlickrDataSource *CP_flickrDataSource;
//	id<PictureListTableViewControllerDelegate> CP_delegateToTransfer;
}

//extern NSString *CPAlertTitle;
//extern NSString *CPAlertMessage;

@end

#pragma mark -

@implementation CPTopPlacesTableViewController

NSString *CPTopPlacesTableViewAccessibilityLabel = @"Top places table";
//NSString *CPAlertTitle = @"Cannot Obtain Data";
//NSString *CPAlertMessage = @"We couldn't get the data from Flickr";

#pragma mark - Synthesize

//@synthesize delegateToUpdateMostRecentPlaces = _delegateToUpdateMostRecentPlaces;
//@synthesize flickrDataSource = CP_flickrDataSource;
@synthesize listOfPlaces = CP_listOfPlaces;
@synthesize indexedListOfPlaces = CP_indexedListOfPlaces;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style dataIndexHandler:(id<CPDataIndexHandling>)dataIndexHandler tableViewHandler:(id<CPTableViewHandling>)tableViewHandler theFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource;
{
	self = [super initWithStyle:style dataIndexHandler:dataIndexHandler tableViewHandler:tableViewHandler];
    if (self)
	{
		self.title = @"Top Places";
		self.tableView.accessibilityLabel = CPTopPlacesTableViewAccessibilityLabel;
		
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(CP_refreshTheTopPlacesList)] autorelease];
		
//		[self CP_setupTopPlacesList];
//		self.flickrDataSource = theFlickrDataSource;
//		[self.flickrDataSource addObserver:self forKeyPath:@"alertViewSwitch" options:NSKeyValueObservingOptionNew context:NULL];
//		[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
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
	[CP_listOfPlaces release];
	[CP_indexedListOfPlaces release];
//	[CP_flickrDataSource release];
	[super dealloc];
}

#pragma mark - Convenience method

- (void)CP_refreshTheTopPlacesList;
{
	[self CP_setupTopPlacesList];
//	[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
	[self indexTheTableViewData];
}

//- (void)CP_setupTopPlacesList;
//{
//	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
//	
//	id undeterminedListOfPlaces = [flickrDataHandler flickrTopPlaces];
//	if ([undeterminedListOfPlaces isKindOfClass:[NSArray class]]) 
//	{
//		self.listOfPlaces = (NSArray *)undeterminedListOfPlaces;
//		[self indexTheTableViewData];
//	}
//	//	else
//	//			{
//	//				[[NSNotificationCenter defaultCenter] postNotificationName:CPNetworkErrorOccuredNotification object:self];
//	//			}
//	[flickrDataHandler release];
//}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	[self CP_setupTopPlacesList];
}

- (void)CP_setupTopPlacesList;
{
	//TODO: find a better place to put this redundant code.
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.color = [UIColor blueColor];
	activityIndicator.hidesWhenStopped = YES;
	activityIndicator.frame = CGRectMake((self.view.bounds.size.width - activityIndicator.bounds.size.width)/2, (self.view.bounds.size.height - activityIndicator.bounds.size.height)/2, activityIndicator.bounds.size.width, activityIndicator.bounds.size.height);
	[self.view addSubview:activityIndicator];
	[activityIndicator startAnimating];
	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
	dispatch_queue_t placesDownloadQueue = dispatch_queue_create("Flickr places downloader", NULL);
	dispatch_async(placesDownloadQueue, ^{
		id undeterminedListOfPlaces = [flickrDataHandler flickrTopPlaces];
		[flickrDataHandler release];
		dispatch_async(dispatch_get_main_queue(), ^{
			[activityIndicator stopAnimating];
			[activityIndicator removeFromSuperview];
			[activityIndicator release];
			if ([undeterminedListOfPlaces isKindOfClass:[NSArray class]]) 
			{
				self.listOfPlaces = (NSArray *)undeterminedListOfPlaces;
				[self indexTheTableViewData];
			}
			else
			{
				[[NSNotificationCenter defaultCenter] postNotificationName:CPNetworkErrorOccuredNotification object:self];
			}
//			NSString *string = [[self.listOfPlaces lastObject] description];
//			NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
//			NSLog(@"%@",@"list of Places");
//			NSLog(@"%@",[NSString stringWithFormat:@"%@",string]);
//			NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
		});
	});
	dispatch_release(placesDownloadQueue);
}

#pragma mark - KVO observer implementation

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//	if ([[change objectForKey:NSKeyValueChangeNewKey] isEqualToString:CPAlertSwitchOn])
//	{
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CPAlertTitle message:CPAlertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];	
//		[alert show];
//		[alert release];
//		[object setValue:CPAlertSwitchOff forKey:keyPath];
//	}
}

#pragma mark - CPTableViewControllerDataMutating protocol method

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array
{
//	self.flickrDataSource.theElementSectionsOfFlickrTopPlaces = array;
	self.indexedListOfPlaces = array;
}

- (NSMutableArray *)fetchTheElementSections
{
//	return self.flickrDataSource.theElementSectionsOfFlickrTopPlaces;
	return self.indexedListOfPlaces;
}

- (NSArray *)fetchTheRawData
{
//	return self.flickrDataSource.flickrTopPlaces;
	return self.listOfPlaces;
}

@end
