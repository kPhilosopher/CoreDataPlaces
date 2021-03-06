//
//  CPTabBarController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPTabBarController.h"
#import "CPTopPlacesTableViewController.h"
#import "CPCoreDataTableViewController.h"


@interface CPTabBarController()
{
@private
	UINavigationController *CP_topPlacesNavigationViewController;
	UINavigationController *CP_mostRecentPlacesNavigationViewController;
	UINavigationController *CP_favoritesNavigationViewController;
	CPTopPlacesTableViewController *CP_topPlacesTableViewController;
	CPCoreDataTableViewController *CP_mostRecentPhotosTableViewController;
	CPCoreDataTableViewController *CP_favoritesTableViewController;
	NSManagedObjectContext *CP_managedObjectContext;
}

#pragma mark - Property

@property (retain) UINavigationController *topPlacesNavigationViewController;
@property (retain) UINavigationController *mostRecentPlacesNavigationViewController;
@property (retain) UINavigationController *favoritesNavigationViewController;
@property (retain) CPTopPlacesTableViewController *topPlacesTableViewController;
@property (retain) CPCoreDataTableViewController *mostRecentPhotosTableViewController;
@property (retain) CPCoreDataTableViewController *favoritesTableViewController;

@end

#pragma mark -

@implementation CPTabBarController

NSString *CPTabBarViewAccessibilityLabel = @"Tab bar";

#pragma mark - Synthesize

@synthesize topPlacesNavigationViewController = CP_topPlacesNavigationViewController;
@synthesize mostRecentPlacesNavigationViewController = CP_mostRecentPlacesNavigationViewController;
@synthesize favoritesNavigationViewController = CP_favoritesNavigationViewController;
@synthesize topPlacesTableViewController = CP_topPlacesTableViewController;
@synthesize mostRecentPhotosTableViewController = CP_mostRecentPhotosTableViewController;
@synthesize favoritesTableViewController = CP_favoritesTableViewController;
@synthesize managedObjectContext = CP_managedObjectContext;

#pragma mark - Initalization

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
	self = [self init];
	if (self) {
		self.title = @"Lists";
		self.view.accessibilityLabel = CPTabBarViewAccessibilityLabel;
		self.managedObjectContext = managedObjectContext;
		[self CP_setup];
	}
	return self;
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_topPlacesTableViewController release];
	[CP_mostRecentPhotosTableViewController release];
	[CP_favoritesTableViewController release];
	[CP_topPlacesNavigationViewController release];
	[CP_mostRecentPlacesNavigationViewController release];
	[CP_favoritesNavigationViewController release];
	[super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
{
    return ((toInterfaceOrientation == UIInterfaceOrientationPortrait) || 
			(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) || 
			(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft));
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
	[self RD_pushViewControllersToNavigationViewControllers];
}
- (void)RD_allocInitThePlaceTableViewControllersWithTheSameFlickrDataSource;
{
	self.topPlacesTableViewController = [CPTopPlacesTableViewController topPlacesTableViewControllerWithManagedObjectContext:self.managedObjectContext];
	self.mostRecentPhotosTableViewController = [CPCoreDataTableViewController mostRecentPhotosTableViewControllerWithManageObjectContext:self.managedObjectContext];
	self.favoritesTableViewController = [CPCoreDataTableViewController favoritePlacesTableViewControllerWithManageObjectContext:self.managedObjectContext];
}
-(void)RD_pushViewControllersToNavigationViewControllers;
{
	[self.topPlacesNavigationViewController pushViewController:self.topPlacesTableViewController animated:YES];
	[self.mostRecentPlacesNavigationViewController pushViewController:self.mostRecentPhotosTableViewController animated:YES];
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
