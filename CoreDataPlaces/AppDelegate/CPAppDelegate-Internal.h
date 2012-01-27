//
//  CPAppDelegate-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/22/12.
//

#import "CPAppDelegate.h"

@interface CPAppDelegate ()
//{
//@private
//	CPTabBarController *CP_tabBarController;
////	CPScrollableImageViewController *CP_scrollableImageVC;
//	CPSplitViewController *CP_splitVC;
//}

#pragma mark - Readability method

- (void)RD_setupTheAppDelegateWindow;
- (void)RD_initializeTabBarController;
- (void)RD_setupForScrollableImageViewController;
- (void)RD_determineTheSetupSequenceForDifferingDevices;
- (BOOL)RD_determineIfTheDeviceIsiPadOrNot;
- (void)RD_setupForiPad;
- (void)RD_setupForiPhoneOriPod;
- (void)RD_runKIFIfRunningIntegrationTest;
- (void)RD_setupSplitViewControllerWithNavigationController:(UINavigationController*)navcon;

@end
