//
//  Photo+TimeLapseCalculator.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "Photo+TimeLapseCalculator.h"


@implementation Photo (TimeLapseCalculator)

#pragma mark - Instance method

- (NSNumber *)timeLapseSinceDate:(NSDate *)date;
{
	NSDate *endDate = [NSDate date];
	NSDate *startDate = date;
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSUInteger unitFlags = NSHourCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate 
												 options:0];
	int number = [components hour];
	return [NSNumber numberWithInt:number];
}

- (NSNumber *)timeLapseSinceUpload;
{
	return [self timeLapseSinceDate:self.timeOfUpload];
}

- (NSNumber *)timeLapseSinceLastView;
{
	return [self timeLapseSinceDate:self.timeOfLastView];
}

@end
