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
#import "CPAppDelegate.h"
#import "CPImageCacheHandler.h"
#import "CPNotificationManager.h"
#import "CPFlickrDataHandler.h"
#import "UIActivityIndicatorView+Additions.h"
#import "NSManagedObjectContext+Additions.h"
#import "CPManagedObjectInsertionHandler.h"


static CPScrollableImageViewController *sharedScrollableImageController = nil;

@interface CPScrollableImageViewController ()
{
@private
	UIImage *CP_image;
	UIImageView *CP_imageView;
	UIScrollView *CP_scrollView;
	UISwitch *CP_switchForFavorite;
	Photo *CP_currentPhoto;
	NSManagedObjectContext *CP_managedObjectContext;
	UIPopoverController *CP_popoverController;
	UIActivityIndicatorView *CP_activityIndicator;
}
@end

#pragma mark -

@implementation CPScrollableImageViewController

const float CPMinimumZoomScale = 0.8;
const float CPMaximumZoomScale = 1.2;

#pragma mark - Synthesize

@synthesize image = CP_image;
@synthesize imageView = CP_imageView;
@synthesize scrollView = CP_scrollView;
@synthesize switchForFavorite = CP_switchForFavorite;
@synthesize currentPhoto = CP_currentPhoto;
@synthesize managedObjectContext = CP_managedObjectContext;
@synthesize popoverController = CP_popoverController;
@synthesize activityIndicator = CP_activityIndicator;

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
	}
	return self;
}

#pragma mark - Singleton

+ (CPScrollableImageViewController *)sharedInstance;
{
	if (sharedScrollableImageController == nil)
	{
		CPAppDelegate *appDelegate = (CPAppDelegate *)[[UIApplication sharedApplication] delegate];
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
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

- (void)dealloc;
{
	[CP_image release];
	[CP_imageView release];
	[CP_scrollView release];
	[CP_switchForFavorite release];
	[CP_currentPhoto release];
	[CP_popoverController release];
	[CP_managedObjectContext release];
	[CP_activityIndicator release];
	[super dealloc];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	self.title = self.currentPhoto.title;
	[self CP_newPhotoSequence];
}

- (void)viewWillDisappear:(BOOL)animated;
{
	[UIActivityIndicatorView removeKIFAndActivityIndicatorView:self.activityIndicator];
	self.activityIndicator = nil;
	[super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.scrollView.delegate = self;
	self.scrollView.minimumZoomScale = CPMinimumZoomScale;
	self.scrollView.maximumZoomScale = CPMaximumZoomScale;
	self.scrollView.accessibilityLabel = CPScrollableImageViewAccessibilityLabel;
	self.switchForFavorite.accessibilityLabel = CPFavoriteSwitchAccessibilityLabel;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
	CP_imageView = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeRight) || 
			(interfaceOrientation == UIInterfaceOrientationLandscapeLeft));
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
	[self CP_adjustToChangeInViewSize];
}

#pragma mark - Instance method

- (void)setupNewPhotoWithPhotoRefinedElement:(CPPhotosRefinedElement *)photoRefinedElement place:(Place *)place;
{
	CPManagedObjectInsertionHandler *managedObjectInsertionHandler = [[CPManagedObjectInsertionHandler alloc] initWithManagedObjectContext:self.managedObjectContext];
	Photo *photo = [managedObjectInsertionHandler photoWithPhotoRefinedElement:photoRefinedElement itsPlace:place];
	[self setNewCurrentPhoto:photo];
}

- (void)setNewCurrentPhoto:(Photo *)newPhoto;
{
	self.currentPhoto = newPhoto;
	self.image = nil;
	[self.imageView removeFromSuperview]; // clear view immediately for user feedback, done again in async block above
	self.imageView = nil;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		if (self.popoverController.popoverVisible)
			[self.popoverController dismissPopoverAnimated:YES];
		[self CP_newPhotoSequence];
	}
}

- (IBAction)toggleFavoriteSwitch:(UISwitch *)sender;
{
	if (self.image) 
	{
		CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
		if (sender.on == YES)
			[imageCacheHandler cacheImage:self.currentPhoto.photoURL UIImage:self.image];
		else
			[imageCacheHandler deleteCacheImage:self.currentPhoto.photoURL];
		[imageCacheHandler release];imageCacheHandler = nil;
		
		self.currentPhoto.isFavorite = [NSNumber numberWithBool:sender.on];
		[self.managedObjectContext processPendingChangesThenSave];
	}
	else if (sender.on)
		sender.on = !sender.on;
}

#pragma mark - Internal method

- (void)CP_newPhotoSequence;
{
	NSString *photoURL = self.currentPhoto.photoURL;
	if (self.image == nil && (photoURL != nil))
	{
		if (self.activityIndicator == nil) 
		{
			self.activityIndicator = [UIActivityIndicatorView activityIndicatorOnKIFTestableViewWithNavigationController:self.navigationController];
			[self.activityIndicator startAnimating];
		}
		
		BOOL currentPhotoIsAFavorite = [self.currentPhoto.isFavorite boolValue];
		
		dispatch_queue_t imageDownloadQueue = dispatch_queue_create("Flickr image downloader", NULL);
		dispatch_async(imageDownloadQueue, ^{
			
			UIImage *imageData = [CPScrollableImageViewController CP_imageDownloadWithPhotoURL:photoURL currentPhotoIsAFavorite:currentPhotoIsAFavorite];
			
			dispatch_async(dispatch_get_main_queue(), ^{
				
				if (imageData)
					[self CP_setupTheViewHierarchyWithNewImage:imageData];
				else
					[[NSNotificationCenter defaultCenter] postNotificationName:CPNetworkErrorOccuredNotification object:self];
				
				[self.activityIndicator stopAnimating];
				UIView *KIFView = self.activityIndicator.superview;
				[self.activityIndicator removeFromSuperview];
				[KIFView removeFromSuperview];
				self.activityIndicator = nil;
				
			});
		});
		dispatch_release(imageDownloadQueue);
	}	
}

+ (UIImage *)CP_imageDownloadWithPhotoURL:(NSString *)photoURL currentPhotoIsAFavorite:(BOOL)currentPhotoIsAFavorite;
{
	UIImage *imageData = nil;
	if (currentPhotoIsAFavorite) 
	{
		CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
		imageData = [imageCacheHandler getCachedImage:photoURL];
		[imageCacheHandler release];imageCacheHandler = nil;
	}
	else
	{
		CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
		imageData = [UIImage imageWithData:[flickrDataHandler flickrImageDataWithURLString:photoURL]];
		[flickrDataHandler release];flickrDataHandler = nil;
	}
	return imageData;
}

- (void)CP_setupTheViewHierarchyWithNewImage:(UIImage *)newImage;
{
	[self.imageView removeFromSuperview]; // Make sure that any in-flight additions before us are cleared
	self.switchForFavorite.on = [self.currentPhoto.isFavorite boolValue];
	self.image = newImage;
	self.imageView = [[[UIImageView alloc] initWithImage:self.image] autorelease];
	self.scrollView.contentSize = self.imageView.bounds.size;
	[self.scrollView addSubview:self.imageView];
	if (self.image != nil)
	{
//		int r = arc4random() % 50;
//		self.queuedPhoto.timeOfLastView = [NSDate dateWithTimeIntervalSinceNow:(-(r*3600))];
		self.currentPhoto.timeOfLastView = [NSDate date];
		[self.managedObjectContext processPendingChangesThenSave];
	}
	self.title = self.currentPhoto.title;
	[self CP_adjustToChangeInViewSize];
}

- (void)CP_adjustToChangeInViewSize;
{
	self.activityIndicator.superview.center = CGPointMake(self.navigationController.view.bounds.size.width/2, self.navigationController.view.bounds.size.height/2);
	[self CP_setTheZoomScales];
	[self.scrollView zoomToRect:[self CP_getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
}

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
	CGFloat imageRatio = self.imageView.bounds.size.height / self.imageView.bounds.size.width;
	CGFloat screenRatio = screenRect.size.height / screenRect.size.width;
	
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
