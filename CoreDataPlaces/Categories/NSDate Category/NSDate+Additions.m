//
//  NSDate+Additions.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/19/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
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

@end
