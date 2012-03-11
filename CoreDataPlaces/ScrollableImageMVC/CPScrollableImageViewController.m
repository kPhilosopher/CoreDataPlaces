//
//  CPScrollableImageViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPScrollableImageViewController-Internal.h"
#import "Photo+Logic.h"
#import "CPPhotosRefinedElement.h"
#import "FlickrFetcher.h"
#import "CPAppDelegate.h"
#import "CPImageCacheHandler.h"
#import "CPNotificationManager.h"
#import "CPFlickrDataHandler.h"

//TODO: change this when the extern string constants' location is changed.
#import "CPPhotosTableViewController.h"

static CPScrollableImageViewController *sharedScrollableImageController = nil;

@interface CPScrollableImageViewController ()
{
@private
	NSDictionary *CP_imageDictionary;
	UIImage *CP_image;
	UIImageView *CP_imageView;
	UIScrollView *CP_scrollView;
	UISwitch *CP_switchForFavorite;
	Photo *CP_currentPhoto;
	CPPhotosRefinedElement *CP_photosRefinedElement;
	NSManagedObjectContext *CP_managedObjectContext;
	Photo *CP_queuedPhoto;
	UIPopoverController *CP_popoverController;
}

#pragma mark - Property

@property (retain) UIImage *image;
@property (retain) UIImageView *imageView;
@property (retain) UIPopoverController *popoverController;
@property (retain) Photo *queuedPhoto;

@end

#pragma mark -

@implementation CPScrollableImageViewController

const float CPMinimumZoomScale = 0.8;
const float CPMaximumZoomScale = 1.2;

#pragma mark - Synthesize

@synthesize imageDictionary = CP_imageDictionary;
@synthesize image = CP_image;
@synthesize imageView = CP_imageView;
@synthesize scrollView = CP_scrollView;
@synthesize switchForFavorite = CP_switchForFavorite;
@synthesize currentPhoto = CP_currentPhoto;
@synthesize queuedPhoto = CP_queuedPhoto;
@synthesize photosRefinedElement = CP_photosRefinedElement;
@synthesize managedObjectContext = CP_managedObjectContext;
@synthesize popoverController = CP_popoverController;

NSString *CPScrollableImageViewAccessibilityLabel = @"Scrollable image";
NSString *CPFavoriteSwitchAccessibilityLabel = @"Favorite";

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) 
	{
		self.managedObjectContext = managedObjectContext;
		self.view.backgroundColor = [UIColor blackColor];
		
		//		self.view.accessibilityLabel = ScrollableImageViewAccessibilityLabel;
		//		self.navigationItem.backBarButtonItem.accessibilityLabel = ScrollableImageBackBarButtonAccessibilityLabel;
		//		self.navigationItem.backBarButtonItem.title = @"whatwhat";
	}
	return self;
}

#pragma mark - Singleton

+ (CPScrollableImageViewController *)sharedInstance;
{
	if (sharedScrollableImageController == nil)
	{
		CPAppDelegate *appDelegate = (CPAppDelegate *)[[UIApplication sharedApplication] delegate];
		if ([appDelegate window].bounds.size.width > 500)//iPad
		{
			sharedScrollableImageController	= [[super allocWithZone:NULL] initWithNibName:@"CPScrollableImageViewController-iPad" bundle:nil managedObjectContext:appDelegate.managedObjectContext];
		}
		else //iPhone
		{
			sharedScrollableImageController	= [[super allocWithZone:NULL] initWithNibName:@"CPScrollableImageViewController-iPhone" bundle:nil managedObjectContext:appDelegate.managedObjectContext];
		}
	}
    return sharedScrollableImageController;
}


+ (id)allocWithZone:(NSZone *)zone;
{
    return [[self sharedInstance] retain];
}

- (id)copyWithZone:(NSZone *)zone;
{
    return self;
}

- (id)retain;
{
    return self;
}

- (NSUInteger)retainCount;
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release;
{
    //do nothing
}

- (id)autorelease;
{
    return self;
}

#pragma mark - View lifecycle

-(void)dealloc
{
	[CP_image release];
	[CP_imageView release];
	[CP_scrollView release];
	[CP_switchForFavorite release];
	[CP_imageDictionary release];
	[CP_popoverController release];
	[super dealloc];
}

- (void)newPhotoSequence;
{
	NSString *photoURL = self.queuedPhoto.photoURL;
	if (self.image == nil && (photoURL != nil)) //TODO: change the self.image to something more relevant.
	{
		UIView *theLabel = [[UIView alloc] init];
		theLabel.accessibilityLabel = CPActivityIndicatorMarkerForKIF;
		UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.color = [UIColor blueColor];
		activityIndicator.hidesWhenStopped = YES;
		activityIndicator.center = CGPointMake(self.navigationController.view.bounds.size.width/2, self.navigationController.view.bounds.size.height/2);
		theLabel.frame = activityIndicator.frame;
		activityIndicator.center = CGPointMake(theLabel.bounds.size.width/2, theLabel.bounds.size.height/2);
		activityIndicator.accessibilityLabel = @"Activity indicator";
		activityIndicator.hidesWhenStopped = YES;
		[self.navigationController.view addSubview:theLabel];
		[theLabel addSubview:activityIndicator];
		[activityIndicator startAnimating];
		dispatch_queue_t imageDownloadQueue = dispatch_queue_create("Flickr image downloader", NULL);
		dispatch_async(imageDownloadQueue, ^
		{
			UIImage *imageData = nil;
			if ([self.queuedPhoto.isFavorite isEqualToNumber:[NSNumber numberWithBool:YES]]) 
			{
				//TODO: download the image in here with multi-threading.
				CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
				//			self.image = [imageCacheHandler getCachedImage:self.currentPhoto.photoURL];
				imageData = [imageCacheHandler getCachedImage:photoURL];
				[imageCacheHandler release];imageCacheHandler = nil;
			}
			else
			{
//				self.image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithURLString:self.currentPhoto.photoURL]];
				CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
				imageData = [UIImage imageWithData:[flickrDataHandler flickrImageDataWithURLString:photoURL]];
				[flickrDataHandler release];flickrDataHandler = nil;
			}
			dispatch_async(dispatch_get_main_queue(), ^
			{
				[activityIndicator stopAnimating];
				[self.imageView removeFromSuperview]; // Make sure that any in-flight additions before us are cleared
				if (imageData)
				{
//					self.currentPhoto = self.queuedPhoto;
//					self.queuedPhoto = nil;
					self.image = imageData;
					self.imageView = [[[UIImageView alloc] initWithImage:self.image] autorelease];
					self.scrollView.contentSize = self.imageView.bounds.size;
					self.switchForFavorite.on = [self.queuedPhoto.isFavorite boolValue];
					[self.scrollView addSubview:self.imageView];
					if (self.image != nil)
					{
						//			int r = arc4random() % 50;
						//			self.queuedPhoto.timeOfLastView = [NSDate dateWithTimeIntervalSinceNow:(-(r*3600))];
						self.queuedPhoto.timeOfLastView = [NSDate date];
						[self.managedObjectContext processPendingChanges];
//						[self.queuedPhoto setTheTimeLapse];
						NSError *error = nil;
						if (![self.managedObjectContext save:&error])
						{
							//handle the error.
							NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
						}
					}
					self.currentPhoto = self.queuedPhoto;
					self.queuedPhoto = nil;
					//call to set the scrollScale.
					[self CP_setTheZoomScales];
					[self.scrollView zoomToRect:[self CP_getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
				}
				else
				{
					[[NSNotificationCenter defaultCenter] postNotificationName:CPNetworkErrorOccuredNotification object:self];
				}
				[activityIndicator removeFromSuperview];
				[activityIndicator release];
				[theLabel removeFromSuperview];
				[theLabel release];
			});
		});
		dispatch_release(imageDownloadQueue);
	}	
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	[self newPhotoSequence];
}

- (void)setNewCurrentPhoto:(Photo *)newPhoto;
{
	self.queuedPhoto = newPhoto;
	self.currentPhoto = nil;
	self.image = nil;
	[self.imageView removeFromSuperview]; // clear view immediately for user feedback, done again in async block above
	self.imageView = nil;
	//TODO: convenience method for this if statement.
	if (self.view.window != nil)
	{
		if (self.popoverController.popoverVisible)
		{
			[self.popoverController dismissPopoverAnimated:YES];
		}
		
//		[self viewWillAppear:YES];
		[self newPhotoSequence];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.scrollView.delegate = self;
	//TODO: make the zoomScales be variable to the size of the imageView and iPhone or iPad.
	self.scrollView.minimumZoomScale = CPMinimumZoomScale;
	self.scrollView.maximumZoomScale = CPMaximumZoomScale;
	//TODO: change the contant name.
	self.scrollView.accessibilityLabel = CPScrollableImageViewAccessibilityLabel;
	self.switchForFavorite.accessibilityLabel = CPFavoriteSwitchAccessibilityLabel;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	CP_scrollView = nil;
	CP_switchForFavorite = nil;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.imageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	
}

- (void)setPhotosRefinedElement:(CPPhotosRefinedElement *)photosRefinedElement;
{
	//first check if the photo already exists.
	NSString *photoURL = [FlickrFetcher urlStringForPhotoWithFlickrInfo:photosRefinedElement.dictionary format:FlickrFetcherPhotoFormatLarge];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	fetchRequest.entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
	fetchRequest.fetchBatchSize = 1;
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"photoURL like %@",photoURL];
	NSSortDescriptor *sortDescriptor = nil;
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	
	Photo *photoToDisplay = nil;
	NSError *error = nil;
	NSUInteger returnedObjectCount = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
	if ((returnedObjectCount == 0) && !error)
	{
		photoToDisplay = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
		photoToDisplay.photoURL = photoURL;
		photoToDisplay.title = photosRefinedElement.title;
		photoToDisplay.subtitle = photosRefinedElement.subtitle;
		photoToDisplay.isFavorite = [NSNumber numberWithBool:NO];
		photoToDisplay.itsPlace = photosRefinedElement.itsPlace;
		//TODO: fix the way the hour changes show.
		NSString *secondsSinceUpload = [photosRefinedElement.dictionary objectForKey:@"dateupload"];
		NSDate *uploadDate = [NSDate dateWithTimeIntervalSince1970:[secondsSinceUpload intValue]];
		
		photoToDisplay.timeOfUpload = uploadDate;
		if (![self.managedObjectContext save:&error])
		{
			//handle the error.
			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
		}
	}
	else if (error)
	{
		NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
	}
	else
	{
		NSError *error = nil;
		NSArray *fetchRequestOutput = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
		if (!fetchRequestOutput)
		{
			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
		}
		else if ([fetchRequestOutput count] > 1)
		{
			NSLog(@"placeID is not a key anymore");
		}
		else
		{
			photoToDisplay = [fetchRequestOutput lastObject];
		}
	}
	
	[self setNewCurrentPhoto:photoToDisplay];
	
	[fetchRequest release];fetchRequest = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeLeft));
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
	[self.scrollView zoomToRect:[self CP_getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
}

- (IBAction)toggleFavoriteSwitch:(UISwitch *)sender;
{
	if (self.image) 
	{
		CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
		if (sender.on == YES) 
		{
			[imageCacheHandler cacheImage:self.currentPhoto.photoURL UIImage:self.image];
		}
		else if (sender.on == NO && [self.currentPhoto.isFavorite isEqualToNumber:[NSNumber numberWithBool:YES]])
		{
			//delete the cache.
			[imageCacheHandler deleteCacheImage:self.currentPhoto.photoURL];
		}
		[imageCacheHandler release];imageCacheHandler = nil;
		
		self.currentPhoto.isFavorite = [NSNumber numberWithBool:sender.on];
		
		NSError *error = nil;
		if (![self.managedObjectContext save:&error])
		{
			//handle the error.
			NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
		}
	}
	else if (sender.on)
	{
		sender.on = !sender.on;
	}
}

#pragma mark - Helper method

- (CGRect)CP_getTheRectSizeThatWillUtilizeTheScreenSpace
{
	CGRect theRectToReturn = CGRectMake(0, 0, 0, 0);
	CGRect screenRect = self.scrollView.bounds;
	CGFloat imageRatio = self.imageView.bounds.size.height / self.imageView.bounds.size.width;
	CGFloat screenRatio = screenRect.size.height / screenRect.size.width;
	if (imageRatio > screenRatio)
	{
		theRectToReturn.size.height = screenRatio * self.imageView.bounds.size.width;
		theRectToReturn.size.width = self.imageView.bounds.size.width;
	}
	else
	{
		theRectToReturn.size.width = self.imageView.bounds.size.height / screenRatio;
		theRectToReturn.size.height = self.imageView.bounds.size.height;
	}
	return theRectToReturn;
}

- (void)CP_setTheZoomScales;
{
	CGFloat minimumZoomScale = 0.0;
	CGFloat maximumZoomScale = 0.0;
	CGRect screenRect = self.scrollView.bounds;
	CGFloat screenRatio = screenRect.size.height / screenRect.size.width;
	CGFloat imageRatio = self.imageView.bounds.size.height / self.imageView.bounds.size.width;
	
	if (imageRatio > screenRatio)
	{
		minimumZoomScale = screenRect.size.height/self.imageView.bounds.size.height;
		maximumZoomScale = (screenRect.size.width*CPMaximumZoomScale)/self.imageView.bounds.size.width;
	}
	else
	{
		minimumZoomScale = screenRect.size.width/self.imageView.bounds.size.width;
		maximumZoomScale = (screenRect.size.height*CPMaximumZoomScale)/self.imageView.bounds.size.height;
	}
	self.scrollView.maximumZoomScale = maximumZoomScale;
	self.scrollView.minimumZoomScale = minimumZoomScale;
}

#pragma mark - Split View Delegate Methods

- (void)splitViewController:(UISplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController;
{
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
	self.popoverController = pc;
	barButtonItem.title = aViewController.title;
	self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)button
{
	self.navigationItem.rightBarButtonItem = nil;
	self.popoverController = nil;
}

@end
