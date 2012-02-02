//
//  CPScrollableImageViewController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//

#import "CPScrollableImageViewController.h"

@interface CPScrollableImageViewController ()
{
@private
	NSDictionary *CP_imageDictionary;
	UIImage *CP_image;
	UIImageView *CP_imageView;
	UIScrollView *CP_scrollView;
	UISwitch *CP_switchForFavorite;
}

#pragma mark - Property

@property (nonatomic, retain) UIImage *image;

@end

#pragma mark -

@implementation CPScrollableImageViewController

#pragma mark - Synthesize

@synthesize imageDictionary = CP_imageDictionary;
@synthesize image = CP_image;
@synthesize imageView = CP_imageView;
@synthesize scrollView = CP_scrollView;
@synthesize switchForFavorite = CP_switchForFavorite;

NSString *ScrollableImageViewAccessibilityLabel = @"Scrollable image";
NSString *ScrollableImageBackBarButtonAccessibilityLabel = @"Back";

#pragma mark - Initialization

//TODO: restructure to imageView being a subview not the main view.
//TODO: download the image in here with multi-threading.
//- (id)init
//{
//	self = [super init];
//	if (self)
//	{
//		//		self.view.accessibilityLabel = ScrollableImageViewAccessibilityLabel;
//		//		self.navigationItem.backBarButtonItem.accessibilityLabel = ScrollableImageBackBarButtonAccessibilityLabel;
//		//		self.navigationItem.backBarButtonItem.title = @"whatwhat";
//	}
//	return self;
//}

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
//
//
//#pragma mark - View lifecycle
//
//
//-(CGRect) getTheRectSizeThatWillUtilizeTheScreenSpace
//{
//	CGRect theRectToReturn = CGRectMake(0, 0, 0, 0);
//	CGRect screenRect = self.view.bounds;
//	CGFloat imageRatio = self.imageView.bounds.size.height / self.imageView.bounds.size.width;
//	CGFloat screenRatio = screenRect.size.height / screenRect.size.width;
//	if (imageRatio > screenRatio)
//	{
//		theRectToReturn.size.height = screenRatio * self.imageView.bounds.size.width;
//		theRectToReturn.size.width = self.imageView.bounds.size.width;
//	}
//	else
//	{
//		theRectToReturn.size.width = self.imageView.bounds.size.height / screenRatio;
//		theRectToReturn.size.height = self.imageView.bounds.size.height;
//	}
//	return theRectToReturn;
//}
//
//-(void) initiateTheImageSetupWithGiven:(UIImage *)image
//{
//	self.image = image;
//	//TODO: fix bad design calling loadView directly
//	[self loadView];
//	if ([self.view isKindOfClass:[UIScrollView class]])
//	{
//		UIScrollView *scrollView = (UIScrollView *)self.view;
//		[scrollView zoomToRect:[self getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
//	}
//}
//
//// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//	self.imageView = [[UIImageView alloc] initWithImage:self.image];
//	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
//	scrollView.delegate = self;
//	scrollView.minimumZoomScale = 0.2;
//	scrollView.maximumZoomScale = 4;
//	scrollView.contentSize = self.imageView.bounds.size;
//	self.view = scrollView;
//	self.view.accessibilityLabel = ScrollableImageViewAccessibilityLabel;
//	[scrollView release];
//	[self.view addSubview:self.imageView];
//	//	[super loadView];
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//}
//
////-(void) viewWillAppear:(BOOL)animated
////{
////multi-thread it
////	
////	[self initiateTheImageSetupWithGiven:self.image];
////	[super viewWillAppear:animated];
////	if ([self.view isKindOfClass:[UIScrollView class]])
////	{
////		UIScrollView *scrollView = (UIScrollView *)self.view;
////		[scrollView zoomToRect:[self getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
////	}
////}
//
//
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//    // e.g. self.myOutlet = nil;
//}
//
//
//
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return self.imageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	
}
//
//-(UIImage *) image
//{
//	if (!CP_image) {
//		CP_image = [[UIImage alloc] init];
//	}
//	return CP_image;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	
//	[self loadView];
//	if ([self.view isKindOfClass:[UIScrollView class]])
//	{
//		UIScrollView *scrollView = (UIScrollView *)self.view;
//		[scrollView zoomToRect:[self getTheRectSizeThatWillUtilizeTheScreenSpace] animated:YES];
//	}
//    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || 
//			(interfaceOrientation == UIInterfaceOrientationLandscapeRight) || 
//			(interfaceOrientation == UIInterfaceOrientationLandscapeLeft));
//}

-(void)dealloc
{
	[CP_image release];
	[CP_imageView release];
	[CP_imageDictionary release];
	[super dealloc];
}

@end
