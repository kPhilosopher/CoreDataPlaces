//
//  CPPhotosTableViewHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosTableViewHandler-Internal.h"
#import "CPPhotosRefinedElement.h"
#import "CPScrollableImageViewController.h"
#import "CPPhotosTableViewController.h"


@implementation CPPhotosTableViewHandler

#pragma mark - Table view data source handler method

- (UITableViewCell *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController cellForRowAtIndexPath:(NSIndexPath *)indexPath cell:(UITableViewCell *)cell;
{
	cell = [super indexedTableViewController:indexedTableViewController cellForRowAtIndexPath:indexPath cell:cell];
	id element = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	
	if ([element conformsToProtocol:@protocol(CPRefinedElementInterfacing)]) {
		id<CPRefinedElementInterfacing> elementWithInterface = (id<CPRefinedElementInterfacing>)element;
		cell.textLabel.text = elementWithInterface.title;
		cell.detailTextLabel.text = elementWithInterface.subtitle;
	}
	return cell;
}

//TODO: refactor this method.
- (NSString *)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController titleForHeaderInSection:(NSInteger)section;
{
	NSString *returningString = nil;
	if ([[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] count] > 0)
	{
//		NSString *elapsedHours = @"";
		//TODO: create an interface to return a string.
		//after checking key-value coding to see if:
		CPRefinedElement *refinedElement = [[[indexedTableViewController fetchTheElementSections] objectAtIndex:section] objectAtIndex:0];
		if ([refinedElement.comparable intValue] == 0) 
		{
			returningString = @"Right Now";
		}
        else
			returningString = [[NSString stringWithFormat:@"%d",[refinedElement.comparable intValue]] stringByAppendingString:@" Hour(s) Ago"];
    }
    return returningString;
}

#pragma mark - Table view delegate handler method

- (void)indexedTableViewController:(CPIndexedTableViewController *)indexedTableViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	CPRefinedElement *refinedElement = [indexedTableViewController refinedElementInTheElementSectionsWithTheIndexPath:indexPath];
	CPPhotosRefinedElement *photosRefinedElement = nil;
	if ([refinedElement isKindOfClass:[CPPhotosRefinedElement class]])
	{
		CPPhotosTableViewController *photosTableViewController = nil;
		if ([indexedTableViewController isKindOfClass:[CPPhotosTableViewController class]]) {
			
			photosTableViewController = (CPPhotosTableViewController *)indexedTableViewController;
			photosRefinedElement = (CPPhotosRefinedElement *)refinedElement;
			photosRefinedElement.itsPlace = photosTableViewController.currentPlace;
			CPScrollableImageViewController *scrollableImageViewController = [[CPScrollableImageViewController alloc] initWithNibName:@"CPScrollableImageViewController-iPhone" bundle:nil managedObjectContext:indexedTableViewController.managedObjectContext];
			//TODO: just need to pass the managedobject and the url.
			scrollableImageViewController.photosRefinedElement = photosRefinedElement;
			scrollableImageViewController.title = photosRefinedElement.title;
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
	}
}

#pragma mark - Readability method

- (BOOL)RD_currentDeviceIsiPodOriPhoneWithImageController:(UIViewController *)imageController;
{
	return imageController.view.window == nil;
}

@end
