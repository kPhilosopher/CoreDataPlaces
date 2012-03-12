//
//  KIFTestScenario+PlacesAdditions.m
//  Places_09
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


//#define INDEX_IN_TAB_BAR_FOR_TOP_PLACES 0
//#define INDEX_IN_TAB_BAR_FOR_MOST_RECENT_PLACES 1
//
//#define INDEX_IN_NAVCON_FOR_PLACES 0
//#define INDEX_IN_NAVCON_FOR_PICTURE_LIST 1
//#define INDEX_IN_NAVCON_FOR_SCROLLABLE_IMAGE 2

//#import "KIFTestController.h"

//static NSString *referenceString = nil;
static NSMutableDictionary *referenceDictionary = nil;

//const int CPTabBarIndexForTopPlacesTab = 0;
//const int CPTabBarIndexForMostRecentPhotosTab = 1;
//const int CPTabBarIndexForFavoritesTab = 2;

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

+ (NSMutableDictionary *)initializeReferenceDictionary;
{
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
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToViewMostRecentPhotosTableView;
{
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapMostRecentTabBarItem];
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Most Recent tab bar item is functional"];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToViewFavoritePlacesTableView;
{
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapFavoritesTabBarItem];
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Most Recent tab bar item is functional"];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.5 description:@"show that there is no items populated."]];
	return scenario;
}


+ (id)scenarioToTapTopRowPlaceInTopPlacesTab;
{
//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToViewTopPlacesTableView];
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesPhotosList"];
//	[scenario addStepsFromArray:preliminaryScenario.steps];
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

+ (id)scenarioToGoBackToPhotosTableViewForTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
	//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Rated"]];
	//TODO: figure out why this would create an error.
	//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapTopRatedTabBarItem];
	//	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	//extract the place title to put in place
	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	CPTabBarController *tabBarController;
	UINavigationController *navcon;
	//	NSString **referenceString;
	//TODO: add a step that would release the dictionary.
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSString *backButtonKey = @"BackButtonTitle";
	[dictionary setObject:@" " forKey:backButtonKey];
	if ([windowID isKindOfClass:[UIWindow class]])
	{
		UIWindow *window = (UIWindow *)windowID;
		
		UIViewController *theRootController =  window.rootViewController;
		if ([theRootController isKindOfClass:[CPTabBarController class]])
		{
			tabBarController = (CPTabBarController *)theRootController;
		}
		navcon = [tabBarController.viewControllers objectAtIndex:CPTabBarIndexForTopPlacesTab];
	}
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPPhotosTableViewController *pictureList = [navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos];
			NSString *titleString = [pictureList.title copy];
			[dictionary setObject:titleString forKey:backButtonKey];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	
	//	[scenario addStep:[KIFTestStep stepToTapViewWithStringReference:&referenceString]];
	[scenario addStep:[KIFTestStep stepToTapViewWithStringAtKey:backButtonKey ofReferenceDictionary:dictionary]];
	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
		[dictionary release];
		return KIFTestStepResultSuccess;
	}]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapTopRowOfSecondSectionInPhotoInTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesScrollableImage"];
	//	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:@"Activity indicator"]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path]];
	NSIndexPath *path2 = [NSIndexPath indexPathForRow:1 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path2]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	return scenario;
}

+ (id)scenarioToTapFavoritesSwitchOn;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapFavoritesSwitch"];
	[scenario addStep:[KIFTestStep stepToSetOn:YES forSwitchWithAccessibilityLabel:CPFavoriteSwitchAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:1 description:@"waiting for switch to toggle"]];
	return scenario;
}

+ (id)scenarioToTapFavoritesSwitchOff;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapFavoritesSwitch"];
	[scenario addStep:[KIFTestStep stepToSetOn:NO forSwitchWithAccessibilityLabel:CPFavoriteSwitchAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:1 description:@"waiting for switch to toggle"]];
	return scenario;
}

+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Rated"]];
	//TODO: figure out why this would create an error.
//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapTopRatedTabBarItem];
//	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	//extract the place title to put in place
	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	CPTabBarController *tabBarController;
	UINavigationController *navcon;
//	NSString **referenceString;
	//TODO: add a step that would release the dictionary.
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSString *backButtonKey = @"BackButtonTitle";
	[dictionary setObject:@" " forKey:backButtonKey];
	if ([windowID isKindOfClass:[UIWindow class]])
	{
		UIWindow *window = (UIWindow *)windowID;
		
		UIViewController *theRootController =  window.rootViewController;
		if ([theRootController isKindOfClass:[CPTabBarController class]])
		{
			tabBarController = (CPTabBarController *)theRootController;
		}
		navcon = [tabBarController.viewControllers objectAtIndex:CPTabBarIndexForTopPlacesTab];
	}
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPPhotosTableViewController *pictureList = [navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos];
			NSString *titleString = [pictureList.title copy];
			[dictionary setObject:titleString forKey:backButtonKey];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	
//	[scenario addStep:[KIFTestStep stepToTapViewWithStringReference:&referenceString]];
	[scenario addStep:[KIFTestStep stepToTapViewWithStringAtKey:backButtonKey ofReferenceDictionary:dictionary]];
	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
		[dictionary release];
		return KIFTestStepResultSuccess;
	}]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Places"]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToGoBackToPlacesTableViewForFavoritesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
	//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Rated"]];
	//TODO: figure out why this would create an error.
	//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapTopRatedTabBarItem];
	//	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	//extract the place title to put in place
	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	CPTabBarController *tabBarController;
	UINavigationController *navcon;
	//	NSString **referenceString;
	//TODO: add a step that would release the dictionary.
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSString *backButtonKey = @"BackButtonTitle";
	[dictionary setObject:@" " forKey:backButtonKey];
	if ([windowID isKindOfClass:[UIWindow class]])
	{
		UIWindow *window = (UIWindow *)windowID;
		
		UIViewController *theRootController =  window.rootViewController;
		if ([theRootController isKindOfClass:[CPTabBarController class]])
		{
			tabBarController = (CPTabBarController *)theRootController;
		}
		navcon = [tabBarController.viewControllers objectAtIndex:CPTabBarIndexForFavoritesTab];
	}
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPPhotosTableViewController *pictureList = [navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos];
			NSString *titleString = [pictureList.title copy];
			[dictionary setObject:titleString forKey:backButtonKey];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	
	//	[scenario addStep:[KIFTestStep stepToTapViewWithStringReference:&referenceString]];
	[scenario addStep:[KIFTestStep stepToTapViewWithStringAtKey:backButtonKey ofReferenceDictionary:dictionary]];
	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
		[dictionary release];
		return KIFTestStepResultSuccess;
	}]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorites"]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToGoBackToPhotosTableViewForFavoritesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
	//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Rated"]];
	//TODO: figure out why this would create an error.
	//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapTopRatedTabBarItem];
	//	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	//extract the place title to put in place
	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	CPTabBarController *tabBarController;
	UINavigationController *navcon;
	//	NSString **referenceString;
	//TODO: add a step that would release the dictionary.
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSString *backButtonKey = @"BackButtonTitle";
	[dictionary setObject:@" " forKey:backButtonKey];
	if ([windowID isKindOfClass:[UIWindow class]])
	{
		UIWindow *window = (UIWindow *)windowID;
		
		UIViewController *theRootController =  window.rootViewController;
		if ([theRootController isKindOfClass:[CPTabBarController class]])
		{
			tabBarController = (CPTabBarController *)theRootController;
		}
		navcon = [tabBarController.viewControllers objectAtIndex:CPTabBarIndexForFavoritesTab];
	}
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPPhotosTableViewController *pictureList = [navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos];
			NSString *titleString = [pictureList.title copy];
			[dictionary setObject:titleString forKey:backButtonKey];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	
	//	[scenario addStep:[KIFTestStep stepToTapViewWithStringReference:&referenceString]];
	[scenario addStep:[KIFTestStep stepToTapViewWithStringAtKey:backButtonKey ofReferenceDictionary:dictionary]];
	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
		[dictionary release];
		return KIFTestStepResultSuccess;
	}]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPFavoritePhotosTableViewAccessibilityLabel]];
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
	//TODO: see if I can tap into the app and make sure the indexes are populated, rather than waiting an arbitrary amount of time.
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



+ (id)scenarioToTapSecondRowPhotoInMostRecentsTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapTopRowPhotoInFavoritesTab"];
	//TODO: see if I can tap into the app and make sure the indexes are populated, rather than waiting an arbitrary amount of time.
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.3 description:@"waiting for photo list to download"]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	CPTabBarController *tabBarController;
	UINavigationController *navcon;
	//	NSString **referenceString;
	//TODO: add a step that would release the dictionary.
//	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSMutableDictionary *dictionary = [KIFTestScenario initializeReferenceDictionary];
	NSString *photoURLKey = @"photoURL";
	[dictionary setObject:@" " forKey:photoURLKey];
	if ([windowID isKindOfClass:[UIWindow class]])
	{
		UIWindow *window = (UIWindow *)windowID;
		
		UIViewController *theRootController =  window.rootViewController;
		if ([theRootController isKindOfClass:[CPTabBarController class]])
		{
			tabBarController = (CPTabBarController *)theRootController;
		}
		navcon = [tabBarController.viewControllers objectAtIndex:CPTabBarIndexForMostRecentPhotosTab];
	}
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the photoURL" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPScrollableImageViewController *scrollabeImageVC = [navcon.viewControllers objectAtIndex:1];
			NSString *photoURL = [scrollabeImageVC.currentPhoto.photoURL copy];
			[dictionary setObject:photoURL forKey:photoURLKey];
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	return scenario;
}

+ (id)scenarioToGoBackToPhotosTableViewForMostRecentsTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to photos table view for most recents tab"];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Most Recents"]];
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapTopRowPhotoInMostRecentsTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapTopRowPhotoInFavoritesTab"];
	//TODO: see if I can tap into the app and make sure the indexes are populated, rather than waiting an arbitrary amount of time.
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.3 description:@"waiting for photo list to download"]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPMostRecentPhotosTableViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPScrollableImageViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:CPActivityIndicatorMarkerForKIF]];
	//TODO: compare the image information.
	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
	CPTabBarController *tabBarController;
	UINavigationController *navcon;
	//	NSString **referenceString;
	//TODO: add a step that would release the dictionary.
//	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	NSMutableDictionary *dictionary = referenceDictionary;
	NSString *photoURLKey = @"photoURL";
	[dictionary setObject:@" " forKey:photoURLKey];
	if ([windowID isKindOfClass:[UIWindow class]])
	{
		UIWindow *window = (UIWindow *)windowID;
		
		UIViewController *theRootController =  window.rootViewController;
		if ([theRootController isKindOfClass:[CPTabBarController class]])
		{
			tabBarController = (CPTabBarController *)theRootController;
		}
		navcon = [tabBarController.viewControllers objectAtIndex:CPTabBarIndexForMostRecentPhotosTab];
	}
	[scenario addStep:[KIFTestStep stepWithDescription:@"get the photoURL" executionBlock:^(KIFTestStep *step, NSError **error){
		if ([navcon.viewControllers objectAtIndex:CPNavconIndexForPhotos])
		{
			CPScrollableImageViewController *scrollabeImageVC = [navcon.viewControllers objectAtIndex:1];
			NSString *photoURL = [scrollabeImageVC.currentPhoto.photoURL copy];
			NSString *photoURLToCompare = [dictionary objectForKey:photoURLKey];
			NSAssert([photoURL isEqualToString:photoURLToCompare],@"The photoURL isn't the same.");
			
			[referenceDictionary release];
			referenceDictionary = nil;
			return KIFTestStepResultSuccess;
		}
		return KIFTestStepResultFailure;
	}]];
	return scenario;
}

@end

