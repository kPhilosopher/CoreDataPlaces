//
//  PlacesKIFTestController.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "PlacesKIFTestController.h"
#import "KIFTestScenario+PlacesAdditions.h"

@implementation PlacesKIFTestController


- (void)initializeScenarios;
{
	[self addScenario:[KIFTestScenario scenarioToViewTopPlacesTableView]];
	[self addScenario:[KIFTestScenario scenarioToViewMostRecentPlacesTableView]];
//	[self addScenario:[KIFTestScenario scenarioToViewTopPlacesPictureList]];
//	[self addScenario:[KIFTestScenario scenarioToViewMostRecentPlacesPictureList]];
//	[self addScenario:[KIFTestScenario scenarioToViewScrollableViewInTopPlacesTab]];
//	[self addScenario:[KIFTestScenario scenarioToViewScrollableViewInMostRecentPlacesTab]];
//	[self addScenario:[KIFTestScenario scenarioToGoBackToPlacesTableViewForTopPlacesTab]];
//	[self addScenario:[KIFTestScenario scenarioToGoBackToPlacesTableViewForMostRecentPlacesTab]];
//	[self addScenario:[KIFTestScenario scenarioToEraseAllTheRowsInMostRecentPlaces]];
}

@end