//
//  CPPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//

#import "CPPhotosTableViewHandler-Internal.h"
#import "CPPhotosRefinedElement.h"
#import "CPScrollableImageViewController.h"

@implementation CPPhotosTableViewHandler

#pragma mark - Table view data source handler method

//TODO: refactor this method.
- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell;
{
	cell.detailTextLabel.text = @"";
	cell.textLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	
	CPPhotosRefinedElement *photoRefinedElement = nil;
	if ([photoRefinedElement isKindOfClass:[CPPhotosRefinedElement class]]) {
		
		photoRefinedElement = (CPPhotosRefinedElement *)refinedElement;
		
		NSDictionary *cellDictionary = photoRefinedElement.dictionary;
		id temporaryTitleString = [cellDictionary objectForKey:@"title"];
		id temporaryDescriptionDictionary = [cellDictionary objectForKey:@"description"];
		id temporaryDescriptionString = nil;
		if ([temporaryDescriptionDictionary isKindOfClass:[NSDictionary class]]) {
			temporaryDescriptionString = [temporaryDescriptionDictionary objectForKey:@"_content"];
		}
		
		NSString *titleString = nil;
		NSString *subTitleString = nil;
		if ([temporaryTitleString isKindOfClass:[NSString class]])
		{
			titleString = (NSString *)temporaryTitleString;
		}
		if ([temporaryDescriptionString isKindOfClass:[NSString class]]) {
			subTitleString = (NSString *)temporaryDescriptionString;
		}
		
		if ([titleString length] == 0) 
		{
			titleString = subTitleString;		
			if ([subTitleString length] == 0) {
				titleString = @"Unknown";
			}
			subTitleString = @"";
		}
		
		cell.textLabel.text = [titleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if (!([subTitleString length] == 0))
		{
			cell.detailTextLabel.text = [subTitleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		}
		photoRefinedElement.title = cell.textLabel.text;
		photoRefinedElement.title = cell.detailTextLabel.text;
	}
	return cell;
}

//TODO: refactor this method.
- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	if ([[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count] > 0)
	{
		NSString *returningString = @"";
		CPRefinedElement *refinedElement = [[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] objectAtIndex:0];
		if ([refinedElement.comparable intValue] == 0) {
			returningString = @"Right Now";
		}
        else
			returningString = [[NSString stringWithFormat:@"%d",[refinedElement.comparable intValue]] stringByAppendingString:@" Hour(s) Ago"];
		return returningString;
    }
    return nil;
}

#pragma mark - Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	
//	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	
	CPScrollableImageViewController *scrollableImageViewController = [[CPScrollableImageViewController alloc] initWithNibName:@"CPScrollableImageViewController-iPhone" bundle:nil];
//	scrollableImageViewController.title = 
	[indexedTableViewController.navigationController pushViewController:scrollableImageViewController animated:YES];
	[scrollableImageViewController release];
	//	UIImage *image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:refinedElement.dictionary format:FlickrFetcherPhotoFormatLarge]];
	
	//	ScrollableImageViewController *imageController = [self.delegate scrollableImageViewControllerForRequestor:self];
	//	if ([self RD_currentDeviceIsiPodOriPhoneWithImageController:imageController]) 
	//	{
	//		imageController = [[[ScrollableImageViewController alloc] init] autorelease];
	//		imageController.title = @"Photo";
	//		[self.navigationController pushViewController:imageController animated:YES];
	//	}
	//	[imageController initiateTheImageSetupWithGiven:image];
}

#pragma mark - Readability method

- (BOOL)RD_currentDeviceIsiPodOriPhoneWithImageController:(UIViewController *)imageController;
{
	return imageController.view.window == nil;
}

@end
