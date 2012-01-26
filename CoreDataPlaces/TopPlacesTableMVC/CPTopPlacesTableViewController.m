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
		[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
		self.title = @"Top Places";
		self.view.accessibilityLabel = TopPlacesViewAccessibilityLabel;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(CP_refreshTheTopPlacesList)];
		self.flickrDataSource = theFlickrDataSource;
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

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[[self fetchTheElementSections] objectAtIndex:section] count] > 0)
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

//TODO: refactor this method
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.tableViewHandler ]
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) 
//        cell = 
//		[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//	
//	cell.detailTextLabel.text = @"";
//	cell.textLabel.text = @"";
//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//	
//	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
//	NSString *contentString = [refinedElement.dictionary objectForKey:@"_content"];
//	cell.textLabel.text = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
//	
//	if ([contentString enumerateStringToDetermineTheExistanceOfCharacterInSet:[NSString characterSetWithComma]])
//	{
//		int startingIndexOfSubTitle = [contentString rangeOfCharacterFromSet:[NSString characterSetWithComma]].location + 1;
//		NSString *subTitle = [contentString substringFromIndex:startingIndexOfSubTitle +1];
//		cell.detailTextLabel.text = [subTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//	}
//	return cell;
}

#pragma mark - Table view delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSDictionary *dictionaryToAddToMostRecentList = refinedElement.dictionary;
	[self.flickrDataSource addToTheMostRecentPlacesCollectionsTheFollowingDictionary:dictionaryToAddToMostRecentList];
	[self.delegateToUpdateMostRecentPlaces reIndexTheTableViewData];
	
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	
//	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
//	NSString *placeId = [refinedElement.dictionary objectForKey:@"place_id"];
//	
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//	
//	NSArray *photoList = [self.flickrDataSource photoListWithFlickrPlaceID:placeId];
//	
//	if ([photoList count] > 0)
//	{
//		PictureListTableViewController *pltvc = [[PictureListTableViewController alloc] initWithStyle:UITableViewStylePlain withPictureList:photoList];
//		pltvc.delegate = self.delegateToTransfer;
//		
//		NSString *contentString = [refinedElement.dictionary objectForKey:@"_content"];
//		pltvc.title = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
//		
//		[self.navigationController pushViewController:pltvc animated:YES];
//		[pltvc release];
//	}
//	
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
