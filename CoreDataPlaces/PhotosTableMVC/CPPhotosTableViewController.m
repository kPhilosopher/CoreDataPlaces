//
//  CPPhotosTableViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//

#import "CPPhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "CPPhotosRefinedElement.h"
#import "CPPhotosDataIndexer.h"
#import "CPPhotosTableViewHandler.h"
#import "CPFlickrDataHandler.h"
#import "CPPlacesRefinedElement.h"

@interface CPPhotosTableViewController ()
{
@private
	NSArray *CP_listOfPhotos;
	NSMutableArray *CP_indexedListOfPhotos;
//	id <PictureListTableViewControllerDelegate> CP_iPadScrollableImageViewControllerDelegate;
}
@end

@implementation CPPhotosTableViewController

NSString *PictureListViewAccessibilityLabel = @"Picture list";
NSString *PictureListBackBarButtonAccessibilityLabel = @"Back";

#pragma mark - Synthesize

@synthesize listOfPhotos = CP_listOfPhotos;
@synthesize indexedListOfPhotos = CP_indexedListOfPhotos;
//@synthesize iPadScrollableImageViewControllerDelegate = CP_iPadScrollableImageViewControllerDelegate;

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewStyle)style withDataIndexer:(id<CPDataIndexDelegate>)dataIndexDelegate withTableViewHandler:(id<CPTableViewDelegate>)tableViewHandlingDelegate withPlaceIDString:(NSString *)placeID;
{
	self = [super initWithStyle:style withDataIndexer:dataIndexDelegate withTableViewHandler:tableViewHandlingDelegate];
    if (self)
	{
		if (placeID)
		{
//			self.dataIndexDelegate = [[[PictureListDataIndexer alloc] init] autorelease];
//			self.listOfPictures_theModel = pictureList;
			
			
//			start downloading the list of photos in another thread.
			CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
			self.listOfPhotos = [flickrDataHandler photoListWithPlaceIDString:placeID];
			self.view.accessibilityLabel = PictureListViewAccessibilityLabel;
			self.navigationItem.backBarButtonItem.accessibilityLabel = PictureListBackBarButtonAccessibilityLabel;
		}
    }
    return self;
}

#pragma mark - Factory method

+ (id)photosTableViewControllerWithRefinedElement:(CPPlacesRefinedElement *)refinedElement;
{
	NSString *placeID = [refinedElement.dictionary objectForKey:@"place_id"];
	CPPhotosRefinedElement *refinedElementForDataIndexer = [[CPPhotosRefinedElement alloc] init];
	CPPhotosDataIndexer *dataIndexerDelegate = [[CPPhotosDataIndexer alloc] initWithRefinedElement:refinedElementForDataIndexer];
	[refinedElementForDataIndexer release];
	CPPhotosTableViewHandler *tableViewHandlerDelegate = [[CPPhotosTableViewHandler alloc] init];
	CPPhotosTableViewController *photosTableViewController = [[CPPhotosTableViewController alloc] initWithStyle:UITableViewStylePlain withDataIndexer:dataIndexerDelegate withTableViewHandler:tableViewHandlerDelegate withPlaceIDString:placeID];
	photosTableViewController.title = [refinedElement.dictionary objectForKey:@"_content"];
	[tableViewHandlerDelegate release];
	[dataIndexerDelegate release];
	return [photosTableViewController autorelease];
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_listOfPhotos release];
	[CP_indexedListOfPhotos release];
	[super dealloc];
}

#pragma mark - Methods to override the IndexedTableViewController

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array
{
	self.indexedListOfPhotos = array;
}

- (NSMutableArray *)fetchTheElementSections
{
	return self.indexedListOfPhotos;
}

- (NSArray *)fetchTheRawData
{
	return self.listOfPhotos;
}

@end
