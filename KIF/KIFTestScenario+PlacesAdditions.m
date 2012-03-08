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

+ (void)initializeReferenceDictionary;
{
	referenceDictionary = [[NSMutableDictionary alloc] init];
}

//+ (id)scenarioToGoBackToPictureListFromImage
//{
//    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test scenarioToGoBackToPictureListFromImage"];
////	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToViewTopPlacesTableView];
////	[scenario addStepsFromArray:preliminaryScenario.steps];
//	
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:ScrollableImageViewAccessibilityLabel]];
//	//press the button
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:ScrollableImageBackBarButtonAccessibilityLabel]];
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	return scenario;
//}
//
//+ (id)scenarioToGoBackToMostRecentPlacesTableViewFromPictureList
//{
//	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test"];
////	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToViewTopPlacesTableView];
////	[scenario addStepsFromArray:preliminaryScenario.steps];
//	
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	//press the button
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:PictureListBackBarButtonAccessibilityLabel]];
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:MostRecentPlacesViewAccessibilityLabel]];
//	return scenario;
//}
//
//+ (id)scenarioToGoBackToTopPlacesTableViewFromPictureList
//{
//	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test scenarioToGoBackToTopPlacesTableViewFromPictureList"];
////	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToViewTopPlacesTableView];
////	[scenario addStepsFromArray:preliminaryScenario.steps];
//	
////	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	//press the button
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:PictureListBackBarButtonAccessibilityLabel]];
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:TopPlacesViewAccessibilityLabel]];
//	return scenario;
//}

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

+ (id)scenarioToViewMostRecentPlacesTableView;
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
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:1 description:@"show that there is no items populated."]];
	return scenario;
}








+ (id)scenarioToTapTopRowPlaceInTopPlacesTab;
{
//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToViewTopPlacesTableView];
    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesPhotosList"];
//	[scenario addStepsFromArray:preliminaryScenario.steps];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:@"Activity Indicator"]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel atIndexPath:path]];
	return scenario;
}

+ (id)scenarioToTapTopRowPhotoInTopPlacesTab;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToViewTopPlacesScrollableImage"];
//	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:@"Activity Indicator"]];
	//TODO: see if I can tap into the app and make sure the indexes are populated, rather than waiting an arbitrary amount of time.
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:2 description:@"waiting for photo list to download"]];
	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPPhotosListViewAccessibilityLabel atIndexPath:path]];
	[scenario addStep:[KIFTestStep stepToWaitForAbsenceOfViewWithAccessibilityLabel:@"Activity Indicator"]];
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
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Places"]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel]];
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
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Favorites"]];
	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPFavoritePlacesTableViewAccessibilityLabel]];
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
	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:0.5 description:@"waiting for photo list to download"]];
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

//+ (id)scenarioToTapFirstRowOfEverySectionInTableView;
//{
//	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"scenarioToTapFirstRowOfEverySectionInTableView"];
//	//TODO: get the sectionsArray.
////	NSArray *sectionsArray = nil;
//	[KIFTestScenario initializeReferenceDictionary];
//	NSString *sectionsArrayKey = @"sectionsArray";
////	[referenceDictionary setObject:[NSArray array] forKey:sectionsArrayKey];
//	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//	CPTabBarController *tabBarController = nil;
//	
//////	NSString **referenceString;
//	if ([windowID isKindOfClass:[UIWindow class]])
//	{
//		UIWindow *window = (UIWindow *)windowID;
//		
//		UIViewController *theRootController =  window.rootViewController;
//		if ([theRootController isKindOfClass:[CPTabBarController class]])
//		{
//			tabBarController = (CPTabBarController *)theRootController;
//		}
//		
//	
//		[scenario addStep:[KIFTestStep stepWithDescription:@"Get The Sections Array" executionBlock:^(KIFTestStep *step, NSError **error){
//			UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:CPTopPlacesTableViewAccessibilityLabel];
//			KIFTestCondition(element, error, @"View with label %@ not found", CPTopPlacesTableViewAccessibilityLabel);
//			UITableView *tableView = (UITableView *)[UIAccessibilityElement viewContainingAccessibilityElement:element];
//			
//			KIFTestCondition([tableView isKindOfClass:[UITableView class]], error, @"Specified view is not a UITableView");
//			
//			KIFTestCondition(tableView, error, @"Table view with label %@ not found", CPTopPlacesTableViewAccessibilityLabel);
//			UINavigationController *navcon = [tabBarController.viewControllers objectAtIndex:CPTabBarIndexForTopPlacesTab];
//			if ([[navcon topViewController] isKindOfClass:[CPTopPlacesTableViewController class]])
//			{
//				CPTopPlacesTableViewController *topPlacesTVC = (CPTopPlacesTableViewController *)[navcon topViewController];
//				[referenceDictionary setObject:[topPlacesTVC fetchTheElementSections] forKey:sectionsArrayKey];
//			}
//			return KIFTestStepResultSuccess;
//		}]];
//	}
//
////	NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
////	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel atIndexPath:index]];
//	[scenario addStep:[KIFTestStep stepToTapFirstRowOfEverySectionsInTableViewWithAccessibilityLabel:CPTopPlacesTableViewAccessibilityLabel referenceDictionary:referenceDictionary sectionsArrayKey:sectionsArrayKey]];
//
//	return scenario;
//}

//+ (id)scenarioToViewMostRecentPlacesPictureList;
//{
//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToViewMostRecentPlacesTableView];
//    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to view most recent places picture list"];
//	[scenario addStepsFromArray:preliminaryScenario.steps];
//	
//	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
//	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:MostRecentPlacesViewAccessibilityLabel atIndexPath:path]];
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	return scenario;
//}
//
//+ (id)scenarioToViewScrollableViewInTopPlacesTab;
//{
//	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to view scrollable view in top places tab"];
//	
//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapTopRatedTabBarItem];
//    [scenario addStepsFromArray:preliminaryScenario.steps];
//	
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	
//	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
//	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel atIndexPath:path]];
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:ScrollableImageViewAccessibilityLabel]];
//	return scenario;
//}
//
//+ (id)scenarioToViewScrollableViewInMostRecentPlacesTab;
//{
//	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to view scrollable view in most recent places tab"];
//	
//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapMostRecentTabBarItem];
//    [scenario addStepsFromArray:preliminaryScenario.steps];
//	
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	
//	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
//	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel atIndexPath:path]];
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:ScrollableImageViewAccessibilityLabel]];
//	return scenario;
//}
//
//+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
//{
//	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to go back to places table view for top places tab"];
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:PLTabBarViewAccessibilityLabel]];
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Rated"]];
//	//TODO: figure out why this would create an error.
////	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapTopRatedTabBarItem];
////	[scenario addStepsFromArray:preliminaryScenario.steps];
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:ScrollableImageViewAccessibilityLabel]];
//	//extract the place title to put in place
//	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//	PLTabBarController *tabBarController;
//	UINavigationController *navcon;
////	NSString **referenceString;
//	if ([windowID isKindOfClass:[UIWindow class]])
//	{
//		UIWindow *window = (UIWindow *)windowID;
//		
//		UIViewController *theRootController =  window.rootViewController;
//		if ([theRootController isKindOfClass:[PLTabBarController class]])
//		{
//			tabBarController = (PLTabBarController *)theRootController;
//		}
//		navcon = [tabBarController.viewControllers objectAtIndex:INDEX_IN_TAB_BAR_FOR_TOP_PLACES];
//	}
//	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title" executionBlock:^(KIFTestStep *step, NSError **error){
//		if ([navcon.viewControllers objectAtIndex:INDEX_IN_NAVCON_FOR_PICTURE_LIST])
//		{
//			PictureListTableViewController *pictureList = [navcon.viewControllers objectAtIndex:INDEX_IN_NAVCON_FOR_PICTURE_LIST];
//			referenceString = [pictureList.title copy];
//			return KIFTestStepResultSuccess;
//		}
//		return KIFTestStepResultFailure;
//	}]];
//	
//	[scenario addStep:[KIFTestStep stepToTapViewWithStringReference:&referenceString]];
//	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
//		[referenceString release];
//		return KIFTestStepResultSuccess;
//	}]];
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Places"]];
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:TopPlacesViewAccessibilityLabel]];
//	return scenario;
//}
//
//+ (id)scenarioToGoBackToPlacesTableViewForMostRecentPlacesTab;
//{
//	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test"];
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:PLTabBarViewAccessibilityLabel]];
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Most Recent"]];
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:ScrollableImageViewAccessibilityLabel]];
//	//extract the place title to put in place
//	id windowID = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//	PLTabBarController *tabBarController;
//	UINavigationController *navcon;
////	NSString **referenceString;
//	if ([windowID isKindOfClass:[UIWindow class]])
//	{
//		UIWindow *window = (UIWindow *)windowID;
//		
//		UIViewController *theRootController =  window.rootViewController;
//		if ([theRootController isKindOfClass:[PLTabBarController class]])
//		{
//			tabBarController = (PLTabBarController *)theRootController;
//		}
//		navcon = [tabBarController.viewControllers objectAtIndex:INDEX_IN_TAB_BAR_FOR_MOST_RECENT_PLACES];
//	}
//	[scenario addStep:[KIFTestStep stepWithDescription:@"get the title" executionBlock:^(KIFTestStep *step, NSError **error){
//		if ([navcon.viewControllers objectAtIndex:INDEX_IN_NAVCON_FOR_PICTURE_LIST])
//		{
//			PictureListTableViewController *pictureList = [navcon.viewControllers objectAtIndex:INDEX_IN_NAVCON_FOR_PICTURE_LIST];
//			referenceString = pictureList.title;
//			return KIFTestStepResultSuccess;
//		}
//		return KIFTestStepResultFailure;
//	}]];
//	
//	[scenario addStep:[KIFTestStep stepToTapViewWithStringReference:&referenceString]];
//	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
//		[referenceString release];
//		return KIFTestStepResultSuccess;
//	}]];
//
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Most Recent"]];
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:MostRecentPlacesViewAccessibilityLabel]];
//	return scenario;
//}
//
////delete all the contents of the most recent places
//+ (id)scenarioToEraseAllTheRowsInMostRecentPlaces;
//{	
////	NSString **referenceString;
////	*referenceString = @"";
//	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to erase all the rows in most recent places"];
//
//	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:PLTabBarViewAccessibilityLabel]];
//    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Most Recent"]];
//	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Edit"]];
//	NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:0];
////	[scenario addStep:[KIFTestStep stepToExtractDeleteLabelOfRowInTableViewWithAccessibilityLabel:MostRecentPlacesViewAccessibilityLabel atIndexPath:path toStringReference:referenceString]];
//	
//	[scenario addStep:[KIFTestStep stepWithDescription:@"Get The Delete Label" executionBlock:^(KIFTestStep *step, NSError **error){
//		UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:MostRecentPlacesViewAccessibilityLabel];
//        KIFTestCondition(element, error, @"View with label %@ not found", MostRecentPlacesViewAccessibilityLabel);
//        UITableView *tableView = (UITableView *)[UIAccessibilityElement viewContainingAccessibilityElement:element];
//        
//        KIFTestCondition([tableView isKindOfClass:[UITableView class]], error, @"Specified view is not a UITableView");
//        
//        KIFTestCondition(tableView, error, @"Table view with label %@ not found", MostRecentPlacesViewAccessibilityLabel);
//        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
//		NSString *label = @"Delete ";
//		label = [label stringByAppendingString:cell.textLabel.text];
//		label = [label stringByAppendingString:@", "];
//		label = [label stringByAppendingString:cell.detailTextLabel.text];
//		NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
//		NSLog(label);
//		NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
//		referenceString = [label copy];
//		return KIFTestStepResultSuccess;
//	}]];
//	[scenario addStep:[KIFTestStep stepToTapViewWithStringReference:&referenceString]];
//	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
//		[referenceString release];
//		return KIFTestStepResultSuccess;
//	}]];
//
//	[scenario addStep:[KIFTestStep stepWithDescription:@"Get The Delete Label" executionBlock:^(KIFTestStep *step, NSError **error){
//		UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:MostRecentPlacesViewAccessibilityLabel];
//        KIFTestCondition(element, error, @"View with label %@ not found", MostRecentPlacesViewAccessibilityLabel);
//        UITableView *tableView = (UITableView *)[UIAccessibilityElement viewContainingAccessibilityElement:element];
//        
//        KIFTestCondition([tableView isKindOfClass:[UITableView class]], error, @"Specified view is not a UITableView");
//        
//        KIFTestCondition(tableView, error, @"Table view with label %@ not found", MostRecentPlacesViewAccessibilityLabel);
//        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
//		NSString *label = @"Confirm Deletion for ";
//		label = [label stringByAppendingString:cell.textLabel.text];
//		label = [label stringByAppendingString:@", "];
//		label = [label stringByAppendingString:cell.detailTextLabel.text];
//		NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
//		NSLog(label);
//		NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
//		referenceString = [label copy];
//		return KIFTestStepResultSuccess;
//	}]];
//	[scenario addStep:[KIFTestStep stepToTapViewWithStringReference:&referenceString]];
//	[scenario addStep:[KIFTestStep stepWithDescription:@"release the hounds" executionBlock:^(KIFTestStep *step, NSError **error){
//		[referenceString release];
//		return KIFTestStepResultSuccess;
//	}]];
////	[scenario addStep:[KIFTestStep stepToDeleteRowInTableViewWithAccessibilityLabel:MostRecentPlacesViewAccessibilityLabel atIndexPath:path]];
////	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Delete"]];
//	[scenario addStep:[KIFTestStep stepToWaitForTimeInterval:2 description:@"   "]];
//	return scenario;
//}

@end

