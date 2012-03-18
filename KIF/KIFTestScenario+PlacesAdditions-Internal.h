//
//  KIFTestScenario+PlacesAdditions-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/12/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "KIFTestScenario+PlacesAdditions.h"


@interface KIFTestScenario (Internal)

extern NSString *CPPhotoURLKey;

#pragma mark - Internal method

+ (UINavigationController *)CP_navigationControllerWithIndexAtTabBar:(int)indexAtTabBar;
+ (id)CP_scenarioToExtractAccessibilityLabelThenTapTheBackButtonWithIndexOfTabBar:(int)indexOfTabBar;

@end
