//
//  KIFTestScenario+PlacesAdditions.h
//  Places_09
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIFTestScenario.h"
//#import "TopPlacesTableViewController.h"
#import "CPTopPlacesTableViewController.h"
//#import "MostRecentTableViewController.h"
#import "CPMostRecentPhotosTableViewController.h"
//#import "PictureListTableViewController.h"
#import "CPPhotosTableViewController.h"
//#import "ScrollableImageViewController.h"
#import "CPScrollableImageViewController.h"
//#import "PLTabBarController.h"
#import "CPTabBarController.h"
//#import "PLAppDelegate.h"
#import "CPAppDelegate.h"

#import "UIAccessibilityElement-KIFAdditions.h"
#import "UIApplication-KIFAdditions.h"

@interface KIFTestScenario (PlacesAdditions)

+ (id)scenarioToTapTopRatedTabBarItem;
+ (id)scenarioToTapMostRecentTabBarItem;
+ (id)scenarioToViewTopPlacesTableView;
+ (id)scenarioToViewMostRecentPlacesTableView;
//+ (id)scenarioToViewTopPlacesPictureList;
//+ (id)scenarioToViewMostRecentPlacesPictureList;
//+ (id)scenarioToViewScrollableViewInTopPlacesTab;
//+ (id)scenarioToViewScrollableViewInMostRecentPlacesTab;
//+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
//+ (id)scenarioToGoBackToPlacesTableViewForMostRecentPlacesTab;
//+ (id)scenarioToEraseAllTheRowsInMostRecentPlaces;

@end
