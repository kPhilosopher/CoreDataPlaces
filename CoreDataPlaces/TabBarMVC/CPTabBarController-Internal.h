//
//  CPTabBarController-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//

#import "CPTabBarController.h"
#import "CPTopPlacesTableViewController.h"

@interface CPTabBarController ()
//{
//@private
//	UINavigationController *CP_topPlacesNavigationViewController;
//	UINavigationController *CP_mostRecentPlacesNavigationViewController;
//	UINavigationController *CP_favoritePlacesNavigationViewController;
////	CPTopPlacesTableViewController *CP_topPlacesTableViewController;
////	CPMostRecentPlacesTableViewController *CP_mostRecentPlacesTableViewController;
////	id <PictureListTableViewControllerDelegate> CP_delegateToTransfer;
//}

#pragma mark - Private method

- (void)CP_setup;

#pragma mark - Readability method

- (void)RD_allocInitTheNavigationViewControllers;
- (void)RD_setupTheCustomTableViewControllers;
- (void)RD_pushViewControllersToNavigationViewControllers;
- (void)RD_setTabBarItemToSystemItems;
- (void)RD_releaseViewControllersThatArePushedIntoTheViewControllerHierarchy;
- (void)RD_setDelegateToTransferForTableViewControllersForiPad;
- (void)RD_allocInitThePlaceTableViewControllersWithTheSameFlickrDataSource;
- (void)RD_addTheNavigationControllersToThisTabBarController;

@end
