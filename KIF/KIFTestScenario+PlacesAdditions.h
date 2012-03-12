//
//  KIFTestScenario+PlacesAdditions.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIFTestScenario.h"


@interface KIFTestScenario (PlacesAdditions)

#pragma mark - Class method

+ (NSMutableDictionary *)referenceDictionary;

#pragma mark - View the table views

+ (id)scenarioToViewTopPlacesTableView;
+ (id)scenarioToViewMostRecentPhotosTableView;
+ (id)scenarioToViewFavoritePlacesTableView;

+ (id)scenarioToTapTopRowPlaceInTopPlacesTab;
+ (id)scenarioToTapTopRowPhotoInTopPlacesTab;
+ (id)scenarioToTapSecondPhotoInTopPlacesTab;

+ (id)scenarioToTapTopRowPlaceInFavoritesTab;
+ (id)scenarioToTapTopRowPhotoInFavoritesTab;

+ (id)scenarioToTapFavoritesSwitchOn;
+ (id)scenarioToTapFavoritesSwitchOff;
+ (id)scenarioToGoBackToPhotosTableViewForTopPlacesTab;
+ (id)scenarioToGoBackToPlacesTableViewForTopPlacesTab;
+ (id)scenarioToGoBackToPlacesTableViewForFavoritesTab;
+ (id)scenarioToGoBackToPhotosTableViewForFavoritesTab;

+ (id)scenarioToTapSecondRowPhotoInMostRecentsTabAndSetPhotoURLInReferenceDictionary;
+ (id)scenarioToTapTopRowPhotoInMostRecentsTabAndCheckPhotoURLAgainstReferenceDictionary;
+ (id)scenarioToGoBackToPhotosTableViewForMostRecentsTab;


@end
