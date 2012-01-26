//
//  TopPlacesTableViewController.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/19/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "TopPlacesTableViewController-Internal.h"

@implementation TopPlacesTableViewController
@synthesize delegateToUpdateMostRecentPlaces = _delegateToUpdateMostRecentPlaces;

NSString *TopPlacesViewAccessibilityLabel = @"Top places table";

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style withTheFlickrDataSource:(PLFlickrDataSource *)theFlickrDataSource withTheDataIndexer:(DataIndexer *)dataIndexer;
{
    self = [super initWithStyle:style withTheFlickrDataSource:theFlickrDataSource withTheDataIndexer:dataIndexer];
    if (self) 
	{
		[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
		self.title = @"Top Places";
		self.view.accessibilityLabel = TopPlacesViewAccessibilityLabel;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refreshTheTopPlacesList)];
	}
    return self;
}

- (void)refreshTheTopPlacesList;
{
	[self.flickrDataSource setupFlickrTopPlacesWithFlickrFetcher];
	[self reIndexTheTableViewData];
}

#pragma mark - Methods to override the IndexedTableViewController

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSDictionary *dictionaryToAddToMostRecentList = refinedElement.dictionary;
	[self.flickrDataSource addToTheMostRecentPlacesCollectionsTheFollowingDictionary:dictionaryToAddToMostRecentList];
	[self.delegateToUpdateMostRecentPlaces reIndexTheTableViewData];
	[super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
