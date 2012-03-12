//
//  KIFTestScenario+PlacesAdditions.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Jinwoo Baek. All rights reserved.
//

#import "KIFTestScenario+PlacesAdditions.h"
#import "KIFTestStep.h"
#import "KIFTestStep+PlacesAdditions.h"
#import "CPAppDelegate.h"
#import "CPTabBarController.h"
#import "CPTopPlacesTableViewController.h"
#import "CPMostRecentPhotosTableViewController.h"
#import "CPFavoritesTableViewController.h"
#import "CPCoreDataPhotosTableViewController.h"
#import "CPPhotosTableViewController.h"
#import "CPScrollableImageViewController.h"
#import "Photo+Logic.h"

#import "UIAccessibilityElement-KIFAdditions.h"
#import "UIApplication-KIFAdditions.h"

static NSMutableDictionary *referenceDictionary = nil;
NSString *CPPhotoURLKey = @"photoURL";

enum {
    CPTabBarIndexForTopPlacesTab		= 0,
    CPTabBarIndexForMostRecentPhotosTab	= 1,
    CPTabBarIndexForFavoritesTab        = 2
};

enum {
	CPNavconIndexForTopPlacesOrFavorites = 0,
	CPNavconIndexForPhotos = 1,
	CPNavconIndexForScrollabeImage = 2
};

@implementation KIFTestScenario (PlacesAdditions)

+ (NSMutableDictionary *)referenceDictionary;
{
	if (referenceDictionary == nil) 
		referenceDictionary = [[NSMutableDictionary alloc] init];
	return referenceDictionary;
}

#pragma mark - Tapping tab bar item

+ (id)scenarioToTapTopRatedTabBarItem;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Scenario of tapping the Top Rated tab bar item."];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Rated"]];
	return scenario;
}

+ (id)scenarioToTapMostRecentTabBarItem;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Scenario of tapping the Most Recent tab bar item."];	
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Most Recent"]];
	return scenario;
}

+ (id)scenarioToTapFavoritesTabBarItem;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Scenario of tapping the Favorites bar item."];	
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorites"]];
	return scenario;
}

#pragma mark - View the table views

+ (id)scenarioToViewTopPlacesTableView;
{
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapTopRatedTabBarItem];
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Top Rated tab bar item is functional"];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToViewMostRecentPhotosTableView;
{
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapMostRecentTabBarItem];
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Most Recent tab bar item is functional"];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToViewFavoritePlacesTableView;
{
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapFavoritesTabBarItem];
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Most Recent tab bar item is functional"];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.5 description:@"show that there is no items populated."]];
	return scenario;
}

#pragma mark - Tapping row in table view

+ (id)scenarioToTapTopRowPlaceInTopPlacesTab;
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesPhotosList"];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel atIndexPath:path]];
	return scenario;
}

+ (id)scenarioToTapTopRowPhotoInTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesScrollableImage"];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	return scenario;
}

+ (id)scenarioToTapTopRowOfSecondSectionInPhotoInTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesScrollableImage"];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path]];
	NSIndexPath *path2 = [NSIndexPath indexPathForRow:1 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path2]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	return scenario;
}

+ (id)scenarioToTapTopRowPlaceInFavoritesTab;
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapTopRowPlaceInFavoritesTab"];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel atIndexPath:path]];
	return scenario;
}

+ (id)scenarioToTapTopRowPhotoInFavoritesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapTopRowPhotoInFavoritesTab"];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.4 description:@"waiting for photo list to download"]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToViewFavoritesPhotoList;
{
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToViewTopPlacesTableView];
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewFavoritesPhotoList"];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel]];
	return scenario;
}

+ (UINavigationController *)navigationControllerWithIndexAtTabBar:(int)indexAtTabBar;
{
	UINavigationController *navigationController = nil;
	CPTabBarController *tabBarController = nil;
	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	if ([windowID isKindOfClass:[UIWindow class]])
	{
		UIWindow *window = (UIWindow *)windowID;
		UIViewController *theRootController =  window.rootViewController;
		if ([theRootController isKindOfClass:[CPTabBarController class]])
			tabBarController = (CPTabBarController *)theRootController;
		navigationController = [tabBarController.viewControllers objectAtIndex:indexAtTabBar];
	}
	return navigationController;
}

+ (id)scenarioToTapTopRowPhotoInMostRecentsTabAndCheckPhotoURL;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapTopRowPhotoInMostRecentsTabAndCheckPhotoURL"];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	
	UINavigationController *navigationController = [KIFTestScenario navigationControllerWithIndexAtTabBar:CPTabBarIndexForMostRecentPhotosTab];
	
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the photoURL" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPScrollableImageViewController *scrollabeImageVC = [navigationController.viewControllers objectAtIndex:1];
			NSString *photoURL = [scrollabeImageVC.currentPhoto.photoURL copy];
			NSString *photoURLToCompare = [[KIFTestScenario referenceDictionary] objectForKey:CPPhotoURLKey];
			NSAssert([photoURL isEqualToString:photoURLToCompare],@"The photoURL isn't the same.");
			[[KIFTestScenario referenceDictionary] release];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.5 description:@"see the image."]];
	return scenario;
}

+ (id)scenarioToTapSecondRowPhotoInMostRecentsTabAndSetPhotoURL;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapSecondRowPhotoInMostRecentsTabAndSetPhotoURL"];
	NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	
	UINavigationController *navigationController = [KIFTestScenario navigationControllerWithIndexAtTabBar:CPTabBarIndexForMostRecentPhotosTab];
	
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the photoURL" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPScrollableImageViewController *scrollabeImageVC = [navigationController.viewControllers objectAtIndex:1];
			NSString *photoURL = [scrollabeImageVC.currentPhoto.photoURL copy];
			[[KIFTestScenario referenceDictionary] setObject:photoURL forKey:CPPhotoURLKey];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.5 description:@"see the image."]];
	return scenario;
}

#pragma mark - Going back in the navigation stack

+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToGoBackToPhotosTableViewForTopPlacesTab];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Places"]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar:(int)indexOfTabBar;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar"];
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSString *backButtonKey = @"BackButtonTitle";
	[dictionary setObject:@"" forKey:backButtonKey];
	
	UINavigationController *navigationController = [KIFTestScenario navigationControllerWithIndexAtTabBar:indexOfTabBar];
	
	//extract the place title to put in place
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title for accessbility label of back button" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPPhotosTableViewController *pictureList = [navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotos];
			NSString *titleString = [pictureList.title copy];
			[dictionary setObject:titleString forKey:backButtonKey];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	
	[scenario addStep:[KIFTestStep stepToTapViewWithStringAtKey:backButtonKey ofReferenceDictionary:dictionary]];
	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
		[dictionary release];
		return KIFTestStepResultSuccess;
	}]];
	return scenario;
}

+ (id)scenarioToGoBackToPhotosTableViewForTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
		
	KIFTestScenario *importedScenario = [KIFTestScenario CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar:CPTabBarIndexForTopPlacesTab];
	[scenario addStepsFromArray:importedScenario.steps];
//	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//	NSString *backButtonKey = @"BackButtonTitle";
//	[dictionary setObject:@"" forKey:backButtonKey];
//	
//	UINavigationController *navigationController = [KIFTestScenario navigationControllerWithIndexAtTabBar:CPTabBarIndexForTopPlacesTab];
//	
//	//extract the place title to put in place
//	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title for accessbility label of back button" executionBlock:^(KIFTestStep *step, NSError **error){
//		if ([navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotos])
//		{
//			CPPhotosTableViewController *pictureList = [navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotos];
//			NSString *titleString = [pictureList.title copy];
//			[dictionary setObject:titleString forKey:backButtonKey];
//			return KIFTestStepResultSuccess;
//		}
//		return KIFTestStepResultFailure;
//	}]];
//	
//	[scenario addStep:[KIFTestStep stepToTapViewWithStringAtKey:backButtonKey ofReferenceDictionary:dictionary]];
//	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
//		[dictionary release];
//		return KIFTestStepResultSuccess;
//	}]];
	
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToGoBackToPlacesTableViewForFavoritesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToGoBackToPhotosTableViewForFavoritesTab];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorites"]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToGoBackToPhotosTableViewForFavoritesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
		
	KIFTestScenario *importedScenario = [KIFTestScenario CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar:CPTabBarIndexForFavoritesTab];
	[scenario addStepsFromArray:importedScenario.steps];
//	//extract the place title to put in place
//	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//	NSString *backButtonKey = @"BackButtonTitle";
//	[dictionary setObject:@" " forKey:backButtonKey];
//	
//	UINavigationController *navigationController = [KIFTestScenario navigationControllerWithIndexAtTabBar:CPTabBarIndexForFavoritesTab];
//	
//	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title for accessbility label of back button" executionBlock:^(KIFTestStep *step, NSError **error){
//		if ([navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotos])
//		{
//			CPPhotosTableViewController *pictureList = [navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotos];
//			NSString *titleString = [pictureList.title copy];
//			[dictionary setObject:titleString forKey:backButtonKey];
//			return KIFTestStepResultSuccess;
//		}
//		return KIFTestStepResultFailure;
//	}]];
//	
//	[scenario addStep:[KIFTestStep stepToTapViewWithStringAtKey:backButtonKey ofReferenceDictionary:dictionary]];
//	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
//		[dictionary release];
//		return KIFTestStepResultSuccess;
//	}]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToGoBackToPhotosTableViewForMostRecentsTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to photos table view for most recents tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Most Recents"]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel]];
	return scenario;
}

#pragma mark - Favorite switch

+ (id)scenarioToTapFavoritesSwitchOn;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapFavoritesSwitchOn"];
	[scenario addStep:[KIFTestStep stepToSetOn:YES forSwitchWithAccessibilityLabel:CPFavoriteSwitchAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapFavoritesSwitchOff;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapFavoritesSwitchOff"];
	[scenario addStep:[KIFTestStep stepToSetOn:NO forSwitchWithAccessibilityLabel:CPFavoriteSwitchAccessibilityLabel]];
	return scenario;
}

@end
