//
//  CPTabBarController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//

#import "CPTabBarController-Internal.h"
#import "CPFlickrDataHandler.h"
#import "CPPlacesDataIndexer.h"

@interface CPTabBarController()
{
@private
	UINavigationController *CP_topPlacesNavigationViewController;
	UINavigationController *CP_mostRecentPlacesNavigationViewController;
	UINavigationController *CP_favoritePlacesNavigationViewController;
	CPTopPlacesTableViewController *CP_topPlacesTableViewController;
	//	CPMostRecentPlacesTableViewController *CP_mostRecentPlacesTableViewController;
	//	id <PictureListTableViewControllerDelegate> CP_delegateToTransfer;
}

@property (retain) UINavigationController *topPlacesNavigationViewController;
@property (retain) UINavigationController *mostRecentPlacesNavigationViewController;
@property (retain) UINavigationController *favortiePlacesNavigationViewController;
@property (retain) CPTopPlacesTableViewController *topPlacesTableViewController;
//@property (retain) CPMostRecentPlacesTableViewController *mostRecentPlacesTableViewController;

@end

@implementation CPTabBarController

NSString *CPTabBarViewAccessibilityLabel = @"Tab bar";

#pragma mark - Synthesize

@synthesize topPlacesNavigationViewController = CP_topPlacesNavigationViewController;
@synthesize mostRecentPlacesNavigationViewController = CP_mostRecentPlacesNavigationViewController;
@synthesize favortiePlacesNavigationViewController = CP_favoritePlacesNavigationViewController;
@synthesize topPlacesTableViewController = CP_topPlacesTableViewController;
//@synthesize mostRecentPlacesTableViewController = CP_mostRecentPlacesTableViewController;
//@synthesize delegateToTransfer = CP_delegateToTransfer;

#pragma mark - Initalization

- (id)initWithDelegate:(id)delegate
{
//	self.delegateToTransfer = delegate;
	return [self init];
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self CP_setup];
		self.view.accessibilityLabel = CPTabBarViewAccessibilityLabel;
    }
    return self;
}

#pragma mark - View lifecycle

-(void)dealloc
{
	[CP_topPlacesTableViewController release];
//	[CP_mostRecentPlacesTableViewController release];
	[CP_topPlacesNavigationViewController release];
	[CP_mostRecentPlacesNavigationViewController release];
	[super dealloc];
}

#pragma mark - Setup sequence

-(void)CP_setup;
{
	[self RD_allocInitTheNavigationViewControllers];
	[self RD_setupTheCustomTableViewControllers];
	[self RD_setTabBarItemToSystemItems];
	[self RD_addTheNavigationControllersToThisTabBarController];
	[self RD_releaseViewControllersThatArePushedIntoTheViewControllerHierarchy];
}
-(void)RD_allocInitTheNavigationViewControllers;
{
	self.topPlacesNavigationViewController = [[[UINavigationController alloc] init] autorelease];
	self.mostRecentPlacesNavigationViewController = [[[UINavigationController alloc] init] autorelease];
	self.favortiePlacesNavigationViewController = [[[UINavigationController alloc] init] autorelease];
	
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
}
-(void)RD_setTabBarItemToSystemItems;
{
	self.topPlacesNavigationViewController.tabBarItem = 
	[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
	self.mostRecentPlacesNavigationViewController.tabBarItem = 
	[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMostRecent tag:2];
	self.favortiePlacesNavigationViewController.tabBarItem = 
	[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:3];
}
- (void)RD_addTheNavigationControllersToThisTabBarController;
{
	self.viewControllers =
	[NSArray arrayWithObjects: self.topPlacesNavigationViewController, self.mostRecentPlacesNavigationViewController, self.favortiePlacesNavigationViewController, nil];
}
-(void)RD_releaseViewControllersThatArePushedIntoTheViewControllerHierarchy;
{
	[self.topPlacesNavigationViewController release];
	[self.mostRecentPlacesNavigationViewController release];
	[self.topPlacesTableViewController release];
//	[self.mostRecentPlacesTableViewController release];
}

@end
