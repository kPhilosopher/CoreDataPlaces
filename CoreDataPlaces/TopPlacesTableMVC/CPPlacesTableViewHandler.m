//
//  CPPlacesTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/25/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPPlacesTableViewHandler.h"

#pragma mark - Table view data source handler method

@implementation CPPlacesTableViewHandler

- (void)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}

- (NSString *)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	
    if ([[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count] > 0)
        return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
    return nil;
}

- (NSInteger)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}

//TODO: refactor this method
- (UITableViewCell *)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [indexedTableViewController.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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

#pragma mark - Table view delegate handler method

- (void)handleIndexedTableViewController:(IndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	RefinedElement *refinedElement = [self getTheRefinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSString *placeId = [refinedElement.dictionary objectForKey:@"place_id"];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	//this call needs to be done in a block in the photoListController
	NSArray *photoList = [self.flickrDataSource photoListWithFlickrPlaceID:placeId];
	
	if ([photoList count] > 0)
	{
		//change the initializer to accept the refinedElement, not the picture list
		PictureListTableViewController *pltvc = [[PictureListTableViewController alloc] initWithStyle:UITableViewStylePlain withPictureList:photoList];
		pltvc.delegate = self.delegateToTransfer;
		
		NSString *contentString = [refinedElement.dictionary objectForKey:@"_content"];
		pltvc.title = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
		
		[self.navigationController pushViewController:pltvc animated:YES];
		[pltvc release];
	}
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
