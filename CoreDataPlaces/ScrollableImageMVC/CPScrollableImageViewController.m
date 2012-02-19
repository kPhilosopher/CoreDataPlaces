//
//  CPScrollableImageViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPScrollableImageViewController.h"
#import "Photo+Logic.h"
#import "CPPhotosRefinedElement.h"
#import "FlickrFetcher.h"
#import "CPAppDelegate.h"
#import "CPImageCacheHandler.h"


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
}

#pragma mark - Property

@property (retain) UIImage *image;
@property (retain) UIImageView *imageView;

@end

#pragma mark -

@implementation CPScrollableImageViewController

#pragma mark - Synthesize

@synthesize imageDictionary = CP_imageDictionary;
@synthesize image = CP_image;
@synthesize imageView = CP_imageView;
@synthesize scrollView = CP_scrollView;
@synthesize switchForFavorite = CP_switchForFavorite;
@synthesize currentPhoto = CP_currentPhoto;
@synthesize photosRefinedElement = CP_photosRefinedElement;
@synthesize managedObjectContext = CP_managedObjectContext;

NSString *ScrollableImageViewAccessibilityLabel = @"Scrollable image";
NSString *ScrollableImageBackBarButtonAccessibilityLabel = @"Back";

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) 
	{
		self.managedObjectContext = managedObjectContext;
		
		
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
	[super dealloc];
}

- (CGRect)getTheRectSizeThatWillUtilizeTheScreenSpace
{
	CGRect theRectToReturn = CGRectMake(0, 0, 0, 0);
//	CGRect screenRect = self.view.bounds;
	CGRect screenRect = self.scrollView.bounds;
	//TODO: check if setting screenRect to self.scrollView.bounds is a better idea.
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

- (void)newPhotoSequence;
{
	NSString *photoURL = self.currentPhoto.photoURL;
	if (self.image == nil && (photoURL != nil)) //TODO: change the self.image to something more relevant.
	{
		dispatch_queue_t downloadQueue = dispatch_queue_create("Flickr downloader", NULL);
		dispatch_async(downloadQueue, ^
		{
			UIImage *imageData = nil;
			if ([self.currentPhoto.isFavorite isEqualToNumber:[NSNumber numberWithBool:YES]]) 
			{
				//TODO: download the image in here with multi-threading.
				CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
				//			self.image = [imageCacheHandler getCachedImage:self.currentPhoto.photoURL];
				imageData = [imageCacheHandler getCachedImage:photoURL];
				[imageCacheHandler release];imageCacheHandler = nil;
			}
			else
			{
				//			self.image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithURLString:self.currentPhoto.photoURL]];
				imageData = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithURLString:photoURL]];
			}
			dispatch_async(dispatch_get_main_queue(), ^
			{
				self.image = imageData;
				self.imageView = [[[UIImageView alloc] initWithImage:self.image] autorelease];
				self.scrollView.contentSize = self.imageView.bounds.size;
				[self.scrollView addSubview:self.imageView];
				if (self.image != nil)
				{
					//			int r = arc4random() % 50;
					//			self.currentPhoto.timeOfLastView = [NSDate dateWithTimeIntervalSinceNow:(-(r*3600))];
					self.currentPhoto.timeOfLastView = [NSDate date];
					[self.currentPhoto setTheTimeLapse];
					NSError *error = nil;
					if (![self.managedObjectContext save:&error])
					{
						//handle the error.
						NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
					}
				}
				[self.scrollView zoomToRect:[self getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
			});
		});
	}
	
	
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	[self newPhotoSequence];
//	if (self.image == nil && (self.currentPhoto.photoURL != nil)) //TODO: change the self.image to something more relevant.
//	{
//		
//		if (self.currentPhoto.isFavorite == [NSNumber numberWithBool:YES]) 
//		{
//			//TODO: download the image in here with multi-threading.
//			CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
//			self.image = [imageCacheHandler getCachedImage:self.currentPhoto.photoURL];
//			[imageCacheHandler release];imageCacheHandler = nil;
//		}
//		else
//		{
//			self.image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithURLString:self.currentPhoto.photoURL]];
//		}
//		self.imageView = [[[UIImageView alloc] initWithImage:self.image] autorelease];
//		self.scrollView.contentSize = self.imageView.bounds.size;
//		[self.scrollView addSubview:self.imageView];
//		if (self.image != nil)
//		{
////			int r = arc4random() % 50;
////			self.currentPhoto.timeOfLastView = [NSDate dateWithTimeIntervalSinceNow:(-(r*3600))];
//			self.currentPhoto.timeOfLastView = [NSDate date];
//			[self.currentPhoto setTheTimeLapse];
//			NSError *error = nil;
//			if (![self.managedObjectContext save:&error])
//			{
//				//handle the error.
//				NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
//			}
//		}
//	}
//	[self.scrollView zoomToRect:[self getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
}


- (void)setNewCurrentPhoto:(Photo *)newPhoto;
{
	self.currentPhoto = newPhoto;
	self.switchForFavorite.on = [self.currentPhoto.isFavorite boolValue];
	[self.imageView removeFromSuperview];
	self.imageView = nil;
	self.image = nil;
	//TODO: convenicen method for this if statement.
	CPAppDelegate *appDelegate = (CPAppDelegate *)[[UIApplication sharedApplication] delegate];
	if ([appDelegate window].bounds.size.width > 500)//iPad
	{
//		[self viewWillAppear:YES];
		[self newPhotoSequence];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.scrollView.delegate = self;
	self.scrollView.minimumZoomScale = 0.2;
	self.scrollView.maximumZoomScale = 4;
	self.scrollView.accessibilityLabel = ScrollableImageViewAccessibilityLabel;
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
	//TODO: allow it to autorotate.
	//when autorotate, the self.view.bounds in the following method does is not the view configured after the rotation.
//	[self.scrollView zoomToRect:[self getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeLeft));
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
	[self.scrollView zoomToRect:[self getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
}

- (IBAction)toggleFavoriteSwitch:(UISwitch *)sender;
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

#pragma mark - Split View Delegate Methods

- (void)splitViewController:(UISplitViewController *)svc popoverController:(UIPopoverController *)pc willPresentViewController:(UIViewController *)aViewController;
{
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
	barButtonItem.title = aViewController.title;
	self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)button
{
	self.navigationItem.rightBarButtonItem = nil;
}

@end
