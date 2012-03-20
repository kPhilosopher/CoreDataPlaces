//
//  NSNumber+Additions.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/19/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "NSNumber+Additions.h"

@implementation NSNumber (Additions)

#pragma mark - Class method

+ (NSNumber *)numberInHoursWithDateComponents:(NSDateComponents *)dateComponents;
{
	float seconds = (float)[dateComponents second];
	float minutesInSeconds = (((float)[dateComponents minute]) * 60.0);
	float allSecondsInDecimal = (seconds + minutesInSeconds) / 3600.0;
	float hoursInDecimal = allSecondsInDecimal + (float)[dateComponents hour];
	return [NSNumber numberWithFloat:hoursInDecimal];
}

@end
