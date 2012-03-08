//
//  PlacesKIFTestController.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Jinwoo Baek. All rights reserved.
//

#import "PlacesKIFTestController.h"
#import "KIFTestScenario+PlacesAdditions.h"

@implementation PlacesKIFTestController


- (void)initializeScenarios;
{
//	[self addScenario:[KIFTestScenario scenarioToViewTopPlacesTableView]];
//	[self addScenario:[KIFTestScenario scenarioToTapMostRecentTabBarItem]];
//	[self addScenario:[KIFTestScenario scenarioToTapFavoritesTabBarItem]];
	
	[self addScenario:[KIFTestScenario scenarioToViewFavoritePlacesTableView]];
	[self addScenario:[KIFTestScenario scenarioToViewMostRecentPlacesTableView]];
	[self addScenario:[KIFTestScenario scenarioToViewTopPlacesTableView]];
	
	//go to Top Places and add a favorite
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPlaceInTopPlacesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPhotoInTopPlacesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapFavoritesSwitchOn]];
	[self addScenario:[KIFTestScenario scenarioToGoBackToPhotosTableViewForTopPlacesTab]];
	
	//check if that favorite is there.
	[self addScenario:[KIFTestScenario scenarioToViewFavoritePlacesTableView]];
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPlaceInFavoritesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapTopRowPhotoInFavoritesTab]];
	[self addScenario:[KIFTestScenario scenarioToTapFavoritesSwitchOff]];
	[self addScenario:[KIFTestScenario scenarioToGoBackToPhotosTableViewForTopPlacesTab]];
	
//	[self addScenario:[KIFTestScenario scenarioToTapFirstRowOfEverySectionInTableView]];
	
//	[self addScenario:[KIFTestScenario scenarioToViewMostRecentPlacesTableView]];
//	[self addScenario:[KIFTestScenario scenarioToViewTopPlacesPictureList]];
//	[self addScenario:[KIFTestScenario scenarioToViewMostRecentPlacesPictureList]];
//	[self addScenario:[KIFTestScenario scenarioToViewScrollableViewInTopPlacesTab]];
//	[self addScenario:[KIFTestScenario scenarioToViewScrollableViewInMostRecentPlacesTab]];
//	[self addScenario:[KIFTestScenario scenarioToGoBackToPlacesTableViewForTopPlacesTab]];
//	[self addScenario:[KIFTestScenario scenarioToGoBackToPlacesTableViewForMostRecentPlacesTab]];
//	[self addScenario:[KIFTestScenario scenarioToEraseAllTheRowsInMostRecentPlaces]];
}

@end