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

#pragma mark - Class method

+ (NSMutableDictionary *)initializeReferenceDictionary;

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
//+ (id)scenarioToGoBackToPictureListFromImage;
+ (id)scenarioToGoBackToPhotosTableViewForTopPlacesTab;
+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
+ (id)scenarioToGoBackToPlacesTableViewForFavoritesTab;
+ (id)scenarioToGoBackToPhotosTableViewForFavoritesTab;

+ (id)scenarioToTapSecondRowPhotoInMostRecentsTab;
+ (id)scenarioToTapTopRowPhotoInMostRecentsTab;
+ (id)scenarioToGoBackToPhotosTableViewForMostRecentsTab;

//+ (id)scenarioToTapFirstRowOfEverySectionInTableView;

//+ (id)scenarioToViewTopPlacesPictureList;
//+ (id)scenarioToViewMostRecentPlacesPictureList;
//+ (id)scenarioToViewScrollableViewInTopPlacesTab;
//+ (id)scenarioToViewScrollableViewInMostRecentPlacesTab;
//+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
//+ (id)scenarioToGoBackToPlacesTableViewForMostRecentPlacesTab;
//+ (id)scenarioToEraseAllTheRowsInMostRecentPlaces;

@end
