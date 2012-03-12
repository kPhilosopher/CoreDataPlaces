//
//  KIFTestScenario+PlacesAdditions.h
//  Places_09
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIFTestScenario.h"


@interface KIFTestScenario (PlacesAdditions)

extern NSString *CPPhotoURLKey;

#pragma mark - Class method

+ (NSMutableDictionary *)referenceDictionary;

#pragma mark - Tapping tab bar item

+ (id)scenarioToTapTopRatedTabBarItem;
+ (id)scenarioToTapFavoritesTabBarItem;
+ (id)scenarioToTapMostRecentTabBarItem;

#pragma mark - View the table views

+ (id)scenarioToViewTopPlacesTableView;
+ (id)scenarioToViewMostRecentPhotosTableView;
+ (id)scenarioToViewFavoritePlacesTableView;

+ (id)scenarioToTapTopRowPlaceInTopPlacesTab;
+ (id)scenarioToTapTopRowPhotoInTopPlacesTab;
+ (id)scenarioToTapTopRowOfSecondSectionInPhotoInTopPlacesTab;

+ (id)scenarioToTapTopRowPlaceInFavoritesTab;
+ (id)scenarioToTapTopRowPhotoInFavoritesTab;

+ (id)scenarioToTapFavoritesSwitchOn;
+ (id)scenarioToTapFavoritesSwitchOff;
+ (id)scenarioToViewFavoritesPhotoList;
+ (id)scenarioToGoBackToPhotosTableViewForTopPlacesTab;
+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
+ (id)scenarioToGoBackToPlacesTableViewForFavoritesTab;
+ (id)scenarioToGoBackToPhotosTableViewForFavoritesTab;

+ (id)scenarioToTapSecondRowPhotoInMostRecentsTabAndSetPhotoURL;
+ (id)scenarioToTapTopRowPhotoInMostRecentsTabAndCheckPhotoURL;
+ (id)scenarioToGoBackToPhotosTableViewForMostRecentsTab;


@end
