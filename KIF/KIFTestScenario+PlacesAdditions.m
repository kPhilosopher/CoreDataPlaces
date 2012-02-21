//
//  KIFTestScenario+PlacesAdditions.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "KIFTestScenario+PlacesAdditions.h"
#import "KIFTestStep.h"
#import "KIFTestStep+PlacesAdditions.h"

#define INDEX_IN_TAB_BAR_FOR_TOP_PLACES 0
#define INDEX_IN_TAB_BAR_FOR_MOST_RECENT_PLACES 1

#define INDEX_IN_NAVCON_FOR_PLACES 0
#define INDEX_IN_NAVCON_FOR_PICTURE_LIST 1
#define INDEX_IN_NAVCON_FOR_SCROLLABLE_IMAGE 2

//#import "KIFTestController.h"

//static NSString *referenceString = nil;


@implementation KIFTestScenario (PlacesAdditions)

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

+ (id)scenarioToTapTopRatedTabBarItem;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Scenario of tapping the Top Rated tab bar item."];	
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
	[scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Top Rated"]];
	return scenario;
}

+ (id)scenarioToViewTopPlacesTableView;
{
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapTopRatedTabBarItem];
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Top Rated tab bar item is functional"];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPTopPlacesViewAccessibilityLabel]];
	return scenario;
}

+ (id)scenarioToTapMostRecentTabBarItem;
{
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Scenario of tapping the Most Recent tab bar item."];	
	[scenario addStep:[KIFTestStep stepToWaitForViewWithAccessibilityLabel:CPTabBarViewAccessibilityLabel]];
    [scenario addStep:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"Most Recent"]];
	return scenario;
}

+ (id)scenarioToViewMostRecentPlacesTableView;
{
	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToTapMostRecentTabBarItem];
	KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to see if the Most Recent tab bar item is functional"];
	[scenario addStepsFromArray:preliminaryScenario.steps];
	
    [scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:CPMostRecentPhotosViewAccessibilityLabel]];
	return scenario;
}
//
//+ (id)scenarioToViewTopPlacesPictureList;
//{
//	KIFTestScenario *preliminaryScenario = [KIFTestScenario scenarioToViewTopPlacesTableView];
//    KIFTestScenario *scenario = [KIFTestScenario scenarioWithDescription:@"Test to view top places picture list"];
//	[scenario addStepsFromArray:preliminaryScenario.steps];
//	
//	NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
//	[scenario addStep:[KIFTestStep stepToTapRowInTableViewWithAccessibilityLabel:TopPlacesViewAccessibilityLabel atIndexPath:path]];
//	[scenario addStep:[KIFTestStep stepToWaitForTappableViewWithAccessibilityLabel:PictureListViewAccessibilityLabel]];
//	return scenario;
//}
//
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

