//
//  CPMostRecentPhotosRefinedElementTests-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/28/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPMostRecentPhotosRefinedElementTests.h"
#import "CPMostRecentPhotosRefinedElement.h"

@interface CPMostRecentPhotosRefinedElementTests ()

#pragma mark - Property

@property (retain) CPMostRecentPhotosRefinedElement *mostRecentPhotosRefinedElement;
@property (retain) id mockPhoto;
@property (retain) NSDate *inputDate;
@property (assign) NSInteger hour;
@property (assign) NSInteger minute;
@property (assign) NSInteger second;

#pragma mark - Internal method

- (void)CP_mockPhotoSetup;
- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour;
- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour minute:(int)minute;
- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour minute:(int)minute second:(int)second;

@end