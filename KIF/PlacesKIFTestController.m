//
//  PlacesKIFTestController.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Jinwoo Baek. All rights reserved.
//

#import "PlacesKIFTestController.h"
#import "KIFTestScenario+PlacesAdditions.h"


@implementation PlacesKIFTestController

- (void)initializeScenarios;
{
	//tap the three tabs
	[self addScenario:[KIFTestScenario scenarioToViewFavoritePlacesTableView]];
	[self addScenario:[KIFTestScenario scenarioToViewMostRecentPhotosTableView]];
	[self addScenario:[KIFTestScenario scenarioToViewTopPlacesTableView]];
	
	//go to Top Places and add a favorite
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPlaceInTopPlacesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPhotoInTopPlacesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapFavoritesSwitchOn]];
	[self addScenario:[KIFTestScenario scenarioToGoBackToPhotosTableViewForTopPlacesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapSecondPhotoInTopPlacesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapFavoritesSwitchOn]];
	[self addScenario:[KIFTestScenario scenarioToGoBackToPlacesTableViewForTopPlacesTab]];
	
	//check if that favorite is there.
	[self addScenario:[KIFTestScenario scenarioToViewFavoritePlacesTableView]];
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPlaceInFavoritesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPhotoInFavoritesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapFavoritesSwitchOff]];
	[self addScenario:[KIFTestScenario scenarioToGoBackToPhotosTableViewForFavoritesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPhotoInFavoritesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapFavoritesSwitchOff]];
	[self addScenario:[KIFTestScenario scenarioToGoBackToPlacesTableViewForFavoritesTab]];
	
	//check if the MostRecentPhotos work.
	[self addScenario:[KIFTestScenario scenarioToViewMostRecentPhotosTableView]];
	[self addScenario:[KIFTestScenario scenarioToTapSecondRowPhotoInMostRecentsTabAndSetPhotoURLInReferenceDictionary]];
	[self addScenario:[KIFTestScenario scenarioToGoBackToPhotosTableViewForMostRecentsTab]];
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPhotoInMostRecentsTabAndCheckPhotoURLAgainstReferenceDictionary]];
	[self addScenario:[KIFTestScenario scenarioToGoBackToPhotosTableViewForMostRecentsTab]];
}

@end