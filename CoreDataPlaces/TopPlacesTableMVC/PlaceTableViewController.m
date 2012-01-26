//
//  PlaceTableViewController.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/2/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "PlaceTableViewController.h"
#import "PlaceTableViewController-Internal.h"

#define NUMBER_OF_SECTIONS 1

@implementation PlaceTableViewController
@synthesize flickrDataSource = _flickrDataSource;
@synthesize delegateToTransfer = _delegateToTransfer;

NSString *alertTitle = @"Cannot Obtain Data";
NSString *alertMessage = @"We couldn't get the data from Flickr";
NSString *PlacesTableViewAccessibilityLabel = @"Places table view";

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style withTheFlickrDataSource:(PLFlickrDataSource *)theFlickrDataSource withTheDataIndexer:(DataIndexer *)dataIndexer;
{
    self = [super initWithStyle:style];
    if (self)
	{
		self.dataIndexer = dataIndexer;
		self.flickrDataSource = theFlickrDataSource;
		[self.flickrDataSource addObserver:self forKeyPath:@"alertViewSwitch" options:NSKeyValueObservingOptionNew context:NULL];
	}
    return self;
}

#pragma mark - View lifecycle

//- (void)loadView;
//{
//	[super loadView];
//	self.tableView.accessibilityLabel = PlacesTableViewAccessibilityLabel;
//}

- (void)dealloc
{
	[_flickrDataSource release];
	[super dealloc];
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
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
        cell = 
		[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	
	cell.detailTextLabel.text = @"";
	cell.textLabel.text = @"";
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSString *contentString = [refinedElement.dictionary objectForKey:@"_content"];
	cell.textLabel.text = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
	
	if ([contentString enumerateStringToDetermineTheExistanceOfCharacterInSet:[NSString characterSetWithComma]])
	{
		int startingIndexOfSubTitle = [contentString rangeOfCharacterFromSet:[NSString characterSetWithComma]].location + 1;
		NSString *subTitle = [contentString substringFromIndex:startingIndexOfSubTitle +1];
		cell.detailTextLabel.text = [subTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	return cell;
}

#pragma mark - Table view delegate

//TODO: refactor this method.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSString *placeId = [refinedElement.dictionary objectForKey:@"place_id"];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	NSArray *photoList = [self.flickrDataSource photoListWithFlickrPlaceID:placeId];
	
	if ([photoList count] > 0)
	{
		PictureListTableViewController *pltvc = [[PictureListTableViewController alloc] initWithStyle:UITableViewStylePlain withPictureList:photoList];
		pltvc.delegate = self.delegateToTransfer;
		
		NSString *contentString = [refinedElement.dictionary objectForKey:@"_content"];
		pltvc.title = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
		
		[self.navigationController pushViewController:pltvc animated:YES];
		[pltvc release];
	}
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

#pragma mark - DataReloadForTableViewControllerProtocol implementation

- (void)reIndexTheTableViewData
{
	[self setTheElementSectionsToTheFollowingArray:
	 [self.dataIndexer returnTheIndexedSectionsOfTheGiven:[self fetchTheRawData]]];
	[self.tableView reloadData];
}

#pragma mark - Helper method

- (NSCharacterSet *)characterSetWithComma;
{
	return [NSCharacterSet characterSetWithCharactersInString:@","];
}


@end
