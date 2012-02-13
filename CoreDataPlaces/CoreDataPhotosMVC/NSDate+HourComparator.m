//
//  NSDate+HourComparator.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "NSDate+HourComparator.h"

@implementation NSDate (HourComparator)

- (NSNumber *)hoursAgo;
{
	NSDate *endDate = [NSDate date];
	NSDate *startDate = self;
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSUInteger unitFlags = NSHourCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate 
												 options:0];
	int number = [components hour];
	return [NSNumber numberWithInt:number];
}

- (NSComparisonResult)compareHoursOfTimeInterval:(NSDate *)date;
{
	return [[self hoursAgo] compare:[date hoursAgo]];
}

@end
