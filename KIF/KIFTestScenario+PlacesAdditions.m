//
//  KIFTestScenario+PlacesAdditions.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Jinwoo Baek. All rights reserved.
//

#import "KIFTestScenario+PlacesAdditions-Internal.h"
#import "CPConstants.h"
#import "KIFTestStep.h"
#import "CPAppDelegate.h"
#import "CPTabBarController.h"
#import "CPTopPlacesTableViewController.h"
#import "CPFavoritesTableViewController.h"
#import "CPCoreDataPhotosTableViewController.h"
#import "CPPhotosTableViewController.h"
#import "CPScrollableImageViewController.h"
#import "Photo+Logic.h"


static NSMutableDictionary *referenceDictionary = nil;
NSString *CPPhotoURLKey = @"photoURL";

enum {
    CPTabBarIndexForTopPlacesTab		= 0,
    CPTabBarIndexForMostRecentPhotosTab	= 1,
    CPTabBarIndexForFavoritesTab        = 2
};

enum {
	CPNavconIndexForTopPlacesOrFavorites = 0,
	CPNavconIndexForPhotosList = 1,
	CPNavconIndexForScrollabeImage = 2
};

enum {
	CPMostRecentsNavconIndexForPhotosList = 0,
	CPMostRecentsNavconIndexForScrollableImage = 1
};

@implementation KIFTestScenario (PlacesAdditions)

+ (NSMutableDictionary *)referenceDictionary;
{
	if (referenceDictionary == nil) 
		referenceDictionary = [[NSMutableDictionary alloc] init];
	return referenceDictionary;
}

#pragma mark - View the table views

+ (id)scenarioToViewTopPlacesTableView;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Top Rated tab bar item is functional"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Rated"]];
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToViewMostRecentPhotosTableView;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Most Recent tab bar item is functional"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Most Recent"]];
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToViewFavoritePlacesTableView;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Most Recent tab bar item is functional"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorites"]];
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.3 description:@"show that there is no items populated."]];
	return scenario;
}

#pragma mark - Tapping row in table view

+ (id)scenarioToTapTopRowPlaceInTopPlacesTab;
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesPhotosList"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapTopRowPhotoInTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesScrollableImage"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapSecondPhotoInTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesScrollableImage"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	NSIndexPath *path_01 = [NSIndexPath indexPathForRow:0 inSection:1];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path_01]];
	NSIndexPath *path_02 = [NSIndexPath indexPathForRow:1 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path_02]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapTopRowPlaceInFavoritesTab;
{
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapTopRowPlaceInFavoritesTab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapTopRowPhotoInFavoritesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapTopRowPhotoInFavoritesTab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapSecondRowPhotoInMostRecentsTabAndSetPhotoURLInReferenceDictionary;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapSecondRowPhotoInMostRecentsTabAndSetPhotoURLInReferenceDictionary"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	
	UINavigationController *navigationController = [KIFTestScenario CP_navigationControllerWithIndexAtTabBar:CPTabBarIndexForMostRecentPhotosTab];
	
	[scenario addStep:[KIFTestStep stepWithDescription:@"set the photoURL" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotosList])
		{
			CPScrollableImageViewController *scrollabeImageVC = [navigationController.viewControllers objectAtIndex:CPMostRecentsNavconIndexForScrollableImage];
			NSString *photoURL = [scrollabeImageVC.currentPhoto.photoURL copy];
			[[KIFTestScenario referenceDictionary] setObject:photoURL forKey:CPPhotoURLKey];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.5 description:@"see the image."]];
	return scenario;
}

+ (id)scenarioToTapTopRowPhotoInMostRecentsTabAndCheckPhotoURLAgainstReferenceDictionary;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapTopRowPhotoInMostRecentsTabAndCheckPhotoURLAgainstReferenceDictionary"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	
	UINavigationController *navigationController = [KIFTestScenario CP_navigationControllerWithIndexAtTabBar:CPTabBarIndexForMostRecentPhotosTab];
	
	[scenario addStep:[KIFTestStep stepWithDescription:@"check the photoURL against the photoURL in reference dictionary." executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotosList])
		{
			CPScrollableImageViewController *scrollabeImageVC = [navigationController.viewControllers objectAtIndex:CPMostRecentsNavconIndexForScrollableImage];
			NSString *photoURL = [scrollabeImageVC.currentPhoto.photoURL copy];
			NSString *photoURLToCompare = [[KIFTestScenario referenceDictionary] objectForKey:CPPhotoURLKey];
			NSAssert([photoURL isEqualToString:photoURLToCompare],@"The photoURL isn't the same, which means the most recents algorithm to put the recently viewed photo at the top is broken.");
			[[KIFTestScenario referenceDictionary] release];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.5 description:@"see the image."]];
	return scenario;
}

#pragma mark - Pressing back button in navigation controller 

+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToGoBackToPhotosTableViewForTopPlacesTab];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Places"]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToGoBackToPhotosTableViewForTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to photos table view for top places tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	KIFTestScenario *importedScenario = [KIFTestScenario CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar:CPTabBarIndexForTopPlacesTab];
	[scenario addStepsFromArray:importedScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToGoBackToPlacesTableViewForFavoritesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for favorites tab"];
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToGoBackToPhotosTableViewForFavoritesTab];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToEnsureEmptyTableViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorite Photos"]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToEnsureEmptyTableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToGoBackToPhotosTableViewForFavoritesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to photos table view for favorites tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	KIFTestScenario *importedScenario = [KIFTestScenario CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar:CPTabBarIndexForFavoritesTab];
	[scenario addStepsFromArray:importedScenario.steps];
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
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	[scenario addStep:[KIFTestStep stepToSetOn:YES forSwitchWithAccessibilityLabel:CPFavoriteSwitchAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapFavoritesSwitchOff;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapFavoritesSwitchOff"];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	[scenario addStep:[KIFTestStep stepToSetOn:NO forSwitchWithAccessibilityLabel:CPFavoriteSwitchAccessibilityLabel]];
	return scenario;
}

#pragma mark - Helper method

+ (id)CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar:(int)indexOfTabBar;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar"];
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSString *backButtonKey = [NSString stringWithFormat:@"BackButtonTitle"];
	[dictionary setObject:@"" forKey:backButtonKey];
	
	UINavigationController *navigationController = [KIFTestScenario CP_navigationControllerWithIndexAtTabBar:indexOfTabBar];
	
	//extract the place title to put in place
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title for accessbility label of back button" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotosList])
		{
			CPPhotosTableViewController *pictureList = [navigationController.viewControllers objectAtIndex:CPNavconIndexForPhotosList];
			NSString *titleString = [pictureList.title copy];
			[dictionary setObject:titleString forKey:backButtonKey];
			[titleString release];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabelInReferenceDictionary:dictionary labelKey:backButtonKey]];
	return scenario;
}

+ (UINavigationController *)CP_navigationControllerWithIndexAtTabBar:(int)indexAtTabBar;
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

@end
