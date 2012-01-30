//
//  CPPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//

#import "CPPhotosTableViewHandler.h"

@implementation CPPhotosTableViewHandler

#pragma mark - Table view data source handler method

//- (NSInteger)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController numberOfRowsInSection:(NSInteger)section;
//{
//	return [super indexedTableViewController:indexedTableViewController numberOfRowsInSection:section];
//}

//TODO: refactor this method.
- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	UITableViewCell *cell = [super indexedTableViewController:indexedTableViewController cellForRowAtIndexPath:indexPath];
	cell.detailTextLabel.text = @"";
	cell.textLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	NSDictionary *cellDictionary = refinedElement.dictionary;
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
	return cell;
}

//- (NSInteger)numberOfSectionsInIndexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController;
//{
//	return [super numberOfSectionsInIndexedTableViewController:indexedTableViewController];
//}

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
//		NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
//		NSLog([NSString stringWithFormat:@"comparable value: %f and returning string %@",[refinedElement.comparable doubleValue], returningString]);
//		NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
		return returningString;
    }
    return nil;
}

#pragma mark - Table view delegate handler method

//TODO: put this where the readability method goes.
- (BOOL)RD_currentDeviceIsiPodOriPhoneWithImageController:(UIViewController *)imageController
{
	return imageController.view.window == nil;
}

//TODO: refactor this method. Also, stop the flow into the image controller if the data given from the FlickrFetcher is not valid.
- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	//	CPRefinedElement *refinedElement = [self refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	//	UIImage *image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithFlickrInfo:refinedElement.dictionary format:FlickrFetcherPhotoFormatLarge]];
	
	//	ScrollableImageViewController *imageController = [self.delegate scrollableImageViewControllerForRequestor:self];
	//	if ([self RD_currentDeviceIsiPodOriPhoneWithImageController:imageController]) 
	//	{
	//		imageController = [[[ScrollableImageViewController alloc] init] autorelease];
	//		imageController.title = @"Photo";
	//		[self.navigationController pushViewController:imageController animated:YES];
	//	}
	//	[imageController initiateTheImageSetupWithGiven:image];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
