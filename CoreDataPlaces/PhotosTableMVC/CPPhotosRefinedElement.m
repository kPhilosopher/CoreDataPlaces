//
//  CPPhotosRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosRefinedElement.h"
#import "Place.h"

@interface CPPhotosRefinedElement ()
{
@private
	NSString *CP_title;
	NSString *CP_subtitle;
	Place *CP_itsPlace;
}
@end

#pragma mark -

@implementation CPPhotosRefinedElement

#pragma mark - Synthesize

@synthesize title = CP_title;
@synthesize subtitle = CP_subtitle;
@synthesize itsPlace = CP_itsPlace;

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement;
{
	NSDate *endDate = [NSDate date];
	NSString *dateUpload = [rawElement objectForKey:@"dateupload"];
	NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[dateUpload intValue]];
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate 
												 options:0];
	double minute = (double)[components minute]/60.0;
	double number = minute + (double)[components hour];
	NSString *string = [NSString stringWithFormat:@"%.2f",number];
	return string;
}

- (NSComparisonResult)compare:(CPPhotosRefinedElement *)aRefinedElementPhoto;
{
	int result;
	NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
	if ([formatter numberFromString:self.comparable] && [formatter numberFromString:aRefinedElementPhoto.comparable])
		result = [[NSNumber numberWithDouble:[self.comparable doubleValue]] compare:[NSNumber numberWithDouble:[aRefinedElementPhoto.comparable doubleValue]]];
	else	result = 0;
	return result;
}

#pragma mark - NSCopying protocol method

- (id)copyWithZone:(NSZone *)zone;
{
	CPPhotosRefinedElement *refinedElementCopy = [[CPPhotosRefinedElement alloc] init];
	return refinedElementCopy;
}

@end
