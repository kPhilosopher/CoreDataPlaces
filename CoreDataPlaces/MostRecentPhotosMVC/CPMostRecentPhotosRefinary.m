//
//  CPMostRecentPhotosRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/2/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinary.h"
#import "CPRefinedElement.h"
#import "Photo.h"


@implementation CPMostRecentPhotosRefinary

#pragma mark - Instance method

- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	if ([refinedElement.rawElement isKindOfClass:[Photo class]])
	{
		//set up
		Photo *thePhoto = (Photo *)refinedElement.rawElement;
		
		//date manipulation
		NSDate *startDate = thePhoto.timeOfLastView;
		NSDate *endDate = [NSDate date];
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
		NSDateComponents *components = [gregorian components:unitFlags
													fromDate:startDate
													  toDate:endDate 
													 options:0];
		
		//math with components
		float seconds = (float)[components second];
		float minutesInSeconds = (((float)[components minute]) * 60.0);
		float allSecondsInDecimal = (seconds + minutesInSeconds) / 3600.0;
		float number = allSecondsInDecimal + (float)[components hour];
		refinedElement.comparable = [NSString stringWithFormat:@"%.5f",number];
		
		//clean up
		[gregorian release];gregorian = nil;
	}
}

- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement.rawElement isKindOfClass:[Photo class]])
	{
		Photo *thePhoto = (Photo *)refinedElement.rawElement;
		refinedElement.title = thePhoto.title;
		refinedElement.subtitle = thePhoto.subtitle;
	}
}

@end
