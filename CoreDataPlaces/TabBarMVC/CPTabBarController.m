//
//  CPTabBarController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTabBarController-Internal.h"
#import "CPTopPlacesTableViewController.h"
#import "CPFavoritesTableViewController.h"
#import "CPFlickrDataHandler.h"
#import "CPPlacesDataIndexer.h"


@interface CPTabBarController()
{
@private
	UINavigationController *CP_topPlacesNavigationViewController;
	UINavigationController *CP_mostRecentPlacesNavigationViewController;
	UINavigationController *CP_favoritesNavigationViewController;
	CPTopPlacesTableViewController *CP_topPlacesTableViewController;
	CPFavoritesTableViewController *CP_favoritesTableViewController;
	NSManagedObjectContext *CP_managedObjectContext;
	//	id <PictureListTableViewControllerDelegate> CP_delegateToTransfer;
	//	CPMostRecentPlacesTableViewController *CP_mostRecentPlacesTableViewController;
}

@property (retain) UINavigationController *topPlacesNavigationViewController;
@property (retain) UINavigationController *mostRecentPlacesNavigationViewController;
@property (retain) UINavigationController *favoritesNavigationViewController;
@property (retain) CPTopPlacesTableViewController *topPlacesTableViewController;
//@property (retain) CPMostRecentPlacesTableViewController *mostRecentPlacesTableViewController;
@property (retain) CPFavoritesTableViewController *favoritesTableViewController;

@end

#pragma mark -

@implementation CPTabBarController

NSString *CPTabBarViewAccessibilityLabel = @"Tab bar";

#pragma mark - Synthesize

@synthesize topPlacesNavigationViewController = CP_topPlacesNavigationViewController;
@synthesize mostRecentPlacesNavigationViewController = CP_mostRecentPlacesNavigationViewController;
@synthesize favoritesNavigationViewController = CP_favoritesNavigationViewController;
@synthesize topPlacesTableViewController = CP_topPlacesTableViewController;
//@synthesize mostRecentPlacesTableViewController = CP_mostRecentPlacesTableViewController;
@synthesize favoritesTableViewController = CP_favoritesTableViewController;
//@synthesize delegateToTransfer = CP_delegateToTransfer;
@synthesize managedObjectContext = CP_managedObjectContext;

#pragma mark - Initalization

- (id)initWithDelegate:(id)delegate withManagedObjectContext:(NSManagedObjectContext *)managedContext;
{
	self = [self init];
	if (self) {
		//	self.delegateToTransfer = delegate;
		self.managedObjectContext = managedContext;
		[self CP_setup];
	}
	return self;
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		self.view.accessibilityLabel = CPTabBarViewAccessibilityLabel;
    }
    return self;
}

#pragma mark - View lifecycle

-(void)dealloc
{
	[CP_topPlacesTableViewController release];
//	[CP_mostRecentPlacesTableViewController release];
	[CP_favoritesTableViewController release];
	[CP_topPlacesNavigationViewController release];
	[CP_mostRecentPlacesNavigationViewController release];
	[CP_favoritesNavigationViewController release];
	[super dealloc];
}

#pragma mark - Setup sequence

-(void)CP_setup;
{
	[self RD_allocInitTheNavigationViewControllers];
	[self RD_setupTheCustomTableViewControllers];
	[self RD_setTabBarItemToSystemItems];
	[self RD_addTheNavigationControllersToThisTabBarController];
}

#pragma mark - Readability method

-(void)RD_allocInitTheNavigationViewControllers;
{
	self.topPlacesNavigationViewController = [[[UINavigationController alloc] init] autorelease];
	self.mostRecentPlacesNavigationViewController = [[[UINavigationController alloc] init] autorelease];
	self.favoritesNavigationViewController = [[[UINavigationController alloc] init] autorelease];
	
}
-(void)RD_setupTheCustomTableViewControllers;
{
	[self RD_allocInitThePlaceTableViewControllersWithTheSameFlickrDataSource];
//	self.topPlacesTableViewController.delegateToUpdateMostRecentPlaces = self.mostRecentPlacesTableViewController;
	[self RD_setDelegateToTransferForTableViewControllersForiPad];
	[self RD_pushViewControllersToNavigationViewControllers];
}
- (void)RD_allocInitThePlaceTableViewControllersWithTheSameFlickrDataSource;
{
//	CPFlickrDataHandler *flickrDataHandler = [[CPFlickrDataHandler alloc] init];
//	CPFlickrDataSource *flickrDataSource = [[CPFlickrDataSource alloc] initWithFlickrDataHandler:flickrDataHandler];
//	[flickrDataHandler release];
//	CPTopPlacesTableViewHandler *tableViewHandlerDelegate = [[CPTopPlacesTableViewHandler alloc] init];
//	CPPlacesDataIndexer *dataIndexerDelegate = [[CPPlacesDataIndexer alloc] init];
//	
//	self.topPlacesTableViewController = [[CPTopPlacesTableViewController alloc] initWithStyle:UITableViewStylePlain withTheFlickrDataSource:flickrDataSource withDataIndexer:dataIndexerDelegate withTableViewHandler:tableViewHandlerDelegate];
//	
//	[flickrDataSource release]; 
//	[tableViewHandlerDelegate release];
//	[dataIndexerDelegate release];
	self.topPlacesTableViewController = [CPTopPlacesTableViewController topPlacesTableViewController];
	self.topPlacesTableViewController.managedObjectContext = self.managedObjectContext;
	self.favoritesTableViewController = [[CPFavoritesTableViewController alloc] 
										 initWithStyle:UITableViewStylePlain 
										 managedObjectContext:self.managedObjectContext 
											customSettingsDictionary:nil];
	
	
//	PlacesDataIndexer *placesDataIndexerForTopPlaces = [[PlacesDataIndexer alloc] init];
//	PlacesDataIndexer *placesDataIndexerForMostRecentPlaces = [[PlacesDataIndexer alloc] init];
//	CPFlickrDataSource *theFlickrDataSource = [[CPFlickrDataSource alloc] initWithFlickrDataHandler:flickrDataHandler];
	
	
//	self.topPlacesTableViewController = 
//	[[[TopPlacesTableViewController alloc] initWithStyle:UITableViewStylePlain withTheFlickrDataSource:theFlickrDataSource withDataIndexer:placesDataIndexerForTopPlaces] autorelease];
//	self.mostRecentPlacesTableViewController = 
//	[[[MostRecentTableViewController alloc] initWithStyle:UITableViewStylePlain withTheFlickrDataSource:theFlickrDataSource withDataIndexer:placesDataIndexerForMostRecentPlaces] autorelease];
//	
//	[theFlickrDataSource release];
//	[placesDataIndexerForMostRecentPlaces release];
//	[placesDataIndexerForTopPlaces release];
}
- (void)RD_setDelegateToTransferForTableViewControllersForiPad;
{ 
//	self.topPlacesTableViewController.delegateToTransfer = self.delegateToTransfer;
//	self.mostRecentPlacesTableViewController.delegateToTransfer = self.delegateToTransfer;
}
-(void)RD_pushViewControllersToNavigationViewControllers;
{
	[self.topPlacesNavigationViewController pushViewController:self.topPlacesTableViewController animated:YES];
//	[self.mostRecentPlacesNavigationViewController pushViewController:self.mostRecentPlacesTableViewController animated:YES];
	[self.favoritesNavigationViewController pushViewController:self.favoritesTableViewController animated:YES];
}
-(void)RD_setTabBarItemToSystemItems;
{
	self.topPlacesNavigationViewController.tabBarItem = 
	[[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1] autorelease];
	self.mostRecentPlacesNavigationViewController.tabBarItem = 
	[[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:2] autorelease];
	self.favoritesNavigationViewController.tabBarItem = 
	[[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3] autorelease];
}
- (void)RD_addTheNavigationControllersToThisTabBarController;
{
	self.viewControllers =
	[NSArray arrayWithObjects: self.topPlacesNavigationViewController, self.mostRecentPlacesNavigationViewController, self.favoritesNavigationViewController, nil];
}

@end
