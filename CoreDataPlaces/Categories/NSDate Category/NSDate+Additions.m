//
//  NSDate+Additions.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/19/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "NSDate+Additions.h"


@implementation NSDate (Additions)

#pragma mark - Class method

+ (NSDate *)dateOfTimeIntervalBetweenNowAndHoursAgo:(int)hour;
{
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setHour:-hour];
	NSCalendar *gregorian = [[[NSCalendar alloc]
							  initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	return [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
}

+ (NSDateComponents *)dateComponentsBetweenNowAndGivenDate:(NSDate *)date;
{
	NSDate *endDate = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:date
												  toDate:endDate 
												 options:0];
	[gregorian release]; gregorian = nil;
	return components;
}

@end
