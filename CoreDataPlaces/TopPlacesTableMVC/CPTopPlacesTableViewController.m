//
//  CPTopPlacesTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import "CPTopPlacesTableViewController-Internal.h"

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

- (id)initWithStyle:(UITableViewStyle)style withTheFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource withDataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate withTableViewHandler:(id<CPTableViewDelegate>)tableViewHandlingDelegate;
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
		NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
		NSLog([NSString stringWithFormat:@"init of Top places"]);
		NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
	}
    return self;
}

//TODO: put where the convenient method should be.
- (void)CP_refreshTheTopPlacesList;
{
	[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
	[self reIndexTheTableViewData];
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_flickrDataSource release];
	[super dealloc];
}

#pragma mark - Table view data source

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//	return [super sectionIndexTitlesForTableView:tableView];
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	return [super tableView:tableView titleForHeaderInSection:section];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//	return [super tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	return [super tableView:tableView cellForRowAtIndexPath:indexPath];
//}

#pragma mark - Table view delegate method

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
//	NSDictionary *dictionaryToAddToMostRecentList = refinedElement.dictionary;
//	[self.flickrDataSource addToTheMostRecentPlacesCollectionsTheFollowingDictionary:dictionaryToAddToMostRecentList];
//	[self.delegateToUpdateMostRecentPlaces reIndexTheTableViewData];
//	
//	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
//}

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

//#pragma mark - DataReloadForTableViewControllerProtocol implementation
//
//- (void)reIndexTheTableViewData
//{
//	[self setTheElementSectionsToTheFollowingArray:
//	 [self.dataIndexDelegate indexedSectionsOfTheRawElementsArray:[self fetchTheRawData]]];
//	[self.tableView reloadData];
//}

@end
