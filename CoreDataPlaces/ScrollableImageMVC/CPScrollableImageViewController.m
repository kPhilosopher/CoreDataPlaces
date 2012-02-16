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
		//TODO: add a navigation item button to act as a switch for favorites.
	}
	return self;
}

#pragma mark - Singleton

+ (CPScrollableImageViewController *)sharedInstance;
{
	if (sharedScrollableImageController == nil)
	{
		CPAppDelegate *appDelegate = (CPAppDelegate *)[[UIApplication sharedApplication] delegate];
		if ([appDelegate window].bounds.size.width > 490)//iPad
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

- (void)viewDidAppear:(BOOL)animated;
{
	[super viewDidAppear:animated];
	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
	NSLog(@"%@",[NSString stringWithFormat:@"viewDidAppear"]);
	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
}

- (void)viewDidDisappear:(BOOL)animated;
{
	[super viewDidDisappear:animated];
	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
	NSLog(@"%@",[NSString stringWithFormat:@"viewDidDisappear"]);
	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
}

//TODO: download the image in here with multi-threading.
- (void)viewWillAppear:(BOOL)animated;
{
	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
	NSLog(@"%@",[NSString stringWithFormat:@"viewWillAppear"]);
	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
	[super viewWillAppear:animated];
	if (self.imageView == nil && (self.currentPhoto.photoURL != nil)) 
	{
		self.image = [UIImage imageWithData:[FlickrFetcher imageDataForPhotoWithURLString:self.currentPhoto.photoURL]];
		self.imageView = [[[UIImageView alloc] initWithImage:self.image] autorelease];
		self.scrollView.contentSize = self.imageView.bounds.size;
		[self.scrollView addSubview:self.imageView];
		if (self.image != nil)
		{
//			self.currentPhoto.timeOfLastView = [NSDate dateWithTimeIntervalSinceNow:(-(50*3600))];
			self.currentPhoto.timeOfLastView = [NSDate date];
			[self.currentPhoto setTheTimeLapse];
//			[self.currentPhoto setupTimeLapseSinceLastView];
			NSError *error = nil;
			if (![self.managedObjectContext save:&error])
			{
				//handle the error.
				NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
			}
		}
	}
	[self.scrollView zoomToRect:[self getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
}

- (void)setNewCurrentPhoto:(Photo *)newPhoto;
{
	self.currentPhoto = newPhoto;
	
}

- (void)viewDidLoad
{
	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
	NSLog(@"%@",[NSString stringWithFormat:@"viewDidLoad"]);
	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
    [super viewDidLoad];
	self.scrollView.delegate = self;
	self.scrollView.minimumZoomScale = 0.2;
	self.scrollView.maximumZoomScale = 4;
	self.scrollView.accessibilityLabel = ScrollableImageViewAccessibilityLabel;
	self.switchForFavorite.on = [self.currentPhoto.isFavorite boolValue];
}

- (void)viewDidUnload
{
	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
	NSLog(@"%@",[NSString stringWithFormat:@"viewDidUnload"]);
	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
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
	
	NSError *error = nil;
	NSUInteger returnedObjectCount = [self.managedObjectContext countForFetchRequest:fetchRequest error:&error];
	if ((returnedObjectCount == 0) && !error)
	{
		self.currentPhoto = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
		self.currentPhoto.photoURL = photoURL;
		self.currentPhoto.title = photosRefinedElement.title;
		self.currentPhoto.subtitle = photosRefinedElement.subtitle;
		self.currentPhoto.isFavorite = [NSNumber numberWithBool:NO];
		self.currentPhoto.itsPlace = photosRefinedElement.itsPlace;
		//TODO: fix the way the hour changes show.
//		NSString *dateUpload = [photosRefinedElement.dictionary objectForKey:@"dateupload"];
//		NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateUpload intValue]];
//		self.currentPhoto.timeLapseSinceUpload = date;
//		NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//		[dateComponents setHour:[photosRefinedElement.comparable intValue]];
//		NSCalendar *gregorian = [[NSCalendar alloc]
//								 initWithCalendarIdentifier:NSGregorianCalendar];
//		NSDate *date = [gregorian dateFromComponents:dateComponents];
//		self.currentPhoto.timeLapseSinceUpload = date;
//		self.currentPhoto.timeLapseSinceUpload = [NSString stringWithFormat:@"%d",[photosRefinedElement.comparable intValue]];
//		self.currentPhoto.timeLapseSinceUpload = [NSNumber numberWithInt:[photosRefinedElement.comparable intValue]];
//		NSError *error = nil;
		NSString *secondsSinceUpload = [photosRefinedElement.dictionary objectForKey:@"dateupload"];
		NSDate *uploadDate = [NSDate dateWithTimeIntervalSince1970:[secondsSinceUpload intValue]];
		
		self.currentPhoto.timeOfUpload = uploadDate;
//		[self.currentPhoto setupTimeLapseSinceUpload];
//		@try
//		{
//			[self.managedObjectContext save:&error];
//		}
//		@catch(NSException* ex)
//		{
//			NSLog(@"%@",@"debugging!!!");
//			NSLog(@"%@",[ex debugDescription]);
//		}
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
			self.currentPhoto = [fetchRequestOutput lastObject];
		}
	}
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

- (IBAction)toggleFavoriteSwitch:(UISwitch *)sender;
{
	self.currentPhoto.isFavorite = [NSNumber numberWithBool:sender.on];
	NSError *error = nil;
	if (![self.managedObjectContext save:&error])
	{
		//handle the error.
		NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
	}
}

#pragma mark - Split View Delegate Methods

- (void)splitViewController:(UISplitViewController*)svc popoverController:(UIPopoverController*)pc willPresentViewController:(UIViewController *)aViewController
{
}

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc
{
	barButtonItem.title = aViewController.title;
	self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)button
{
	self.navigationItem.rightBarButtonItem = nil;
}

@end
