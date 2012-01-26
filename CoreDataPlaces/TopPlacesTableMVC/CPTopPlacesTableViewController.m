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
	id<CPTableViewControllerDataReloading> CP_delegateToUpdateMostRecentPlaces;
	CPFlickrDataSource *CP_flickrDataSource;
	id <PictureListTableViewControllerDelegate> CP_delegateToTransfer;
}
@end


@implementation CPTopPlacesTableViewController

NSString *CPTopPlacesViewAccessibilityLabel = @"Top places table";

#pragma mark - Synthesize

@synthesize delegateToUpdateMostRecentPlaces = _delegateToUpdateMostRecentPlaces;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style withTheFlickrDataSource:(CPFlickrDataSource *)theFlickrDataSource withDataIndexer:(CPDataIndexer *)dataIndexer withTableViewHandler:(CPTableViewHandler *)tableViewHandler;
{
	self = [super initWithStyle:style withDataIndexer:dataIndexer withTableViewHandler:tableViewHandler];
    if (self)
	{
		self.title = @"Top Places";
		self.view.accessibilityLabel = TopPlacesViewAccessibilityLabel;
		
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(CP_refreshTheTopPlacesList)];
		
		self.flickrDataSource = theFlickrDataSource;
		[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
		[self.flickrDataSource addObserver:self forKeyPath:@"alertViewSwitch" options:NSKeyValueObservingOptionNew context:NULL];
	}
    return self;
}

- (void)CP_refreshTheTopPlacesList;
{
	[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
	[self reIndexTheTableViewData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
//	NSDictionary *dictionaryToAddToMostRecentList = refinedElement.dictionary;
//	[self.flickrDataSource addToTheMostRecentPlacesCollectionsTheFollowingDictionary:dictionaryToAddToMostRecentList];
//	[self.delegateToUpdateMostRecentPlaces reIndexTheTableViewData];
	
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - KVO observer implementation

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([[change objectForKey:NSKeyValueChangeNewKey] isEqualToString:PLAlertSwitchOn])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];	
		[alert show];
		[alert release];
		[object setValue:PLAlertSwitchOff forKey:keyPath];
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
