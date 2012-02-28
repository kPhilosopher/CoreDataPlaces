//
//  CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/28/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement.h"
#import "CPMostRecentPhotosRefinedElement.h"


@interface CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement()

#pragma mark - Property

@property (retain) CPMostRecentPhotosRefinedElement *mostRecentPhotosRefinedElement;
@property (retain) id mockPhoto;
@property (retain) NSDate *inputDate;
@property (assign) NSInteger hours;

#pragma mark - Internal method

- (NSDate *)CP_dateOfHoursAgoWithGivenInteger:(int)hours;

@end