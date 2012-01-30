//
//  CPTopPlacesTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import "CPTopPlacesTableViewController-Internal.h"
#import "CPPlacesDataIndexer.h"
#import "CPTopPlacesTableViewHandler.h"

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

@implementation CPTopPlacesTableViewController

NSString *CPTopPlacesViewAccessibilityLabel = @"Top places table";
NSString *CPAlertTitle = @"Cannot Obtain Data";
NSString *CPAlertMessage = @"We couldn't get the data from Flickr";

#pragma mark - Synthesize

//@synthesize delegateToUpdateMostRecentPlaces = _delegateToUpdateMostRecentPlaces;
@synthesize flickrDataSource = CP_flickrDataSource;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style withDataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate withTableViewHandler:(id<CPTableViewDelegate>)tableViewHandlingDelegate withTheFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource;
{
	self = [super initWithStyle:style withDataIndexer:dataIndexDelegate withTableViewHandler:tableViewHandlingDelegate];
    if (self)
	{
		self.title = @"Top Places";
		self.view.accessibilityLabel = CPTopPlacesViewAccessibilityLabel;
		
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(CP_refreshTheTopPlacesList)];
		
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
	
	CPTopPlacesTableViewHandler *tableViewHandlerDelegate = [[CPTopPlacesTableViewHandler alloc] init];
	CPPlacesDataIndexer *dataIndexerDelegate = [[CPPlacesDataIndexer alloc] init];
	
	CPTopPlacesTableViewController *topPlacesTableViewController = [[CPTopPlacesTableViewController alloc] initWithStyle:UITableViewStylePlain withDataIndexer:dataIndexerDelegate withTableViewHandler:tableViewHandlerDelegate withTheFlickrDataSource:flickrDataSource];
	
	[flickrDataSource release]; 
	[tableViewHandlerDelegate release];
	[dataIndexerDelegate release];
	
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
