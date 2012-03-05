//
//  CPMostRecentPhotosRefinaryTests-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/2/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinaryTests.h"
#import "CPMostRecentPhotosRefinedElement.h"
#import "CPMostRecentPhotosRefinary.h"


@interface CPMostRecentPhotosRefinaryTests()

#pragma mark - Property

@property (retain) CPMostRecentPhotosRefinedElement *mostRecentPhotosRefinedElement;
@property (retain) CPMostRecentPhotosRefinary *refinary;
@property (retain) id mockPhoto;
@property (retain) NSDate *inputDate;
@property (assign) NSInteger hour;
@property (assign) NSInteger minute;
@property (assign) NSInteger second;
@property (copy) NSString *inputTitle;
@property (copy) NSString *inputSubtitle;

#pragma mark - Internal method

- (void)CP_setupForInputDateAndMockPhoto;
- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour;
- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour minute:(int)minute second:(int)second;
- (void)CP_mockPhotoSetup;

@end