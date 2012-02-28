//
//  CPMostRecentPhotosRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinedElement.h"
#import "Photo.h"


@interface CPMostRecentPhotosRefinedElement()
{
	@private
	NSString *CP_comparable;
	id CP_rawElement;
}

#pragma mark - Property

//@property (copy, readwrite) NSString *comparable;

@end

#pragma mark -

@implementation CPMostRecentPhotosRefinedElement

#pragma mark - Synthesize

@synthesize comparable = CP_comparable;
@synthesize rawElement = CP_rawElement;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_rawElement release];
	[CP_comparable release];
	[super dealloc];
}

#pragma mark - Instance method

- (void)setComparableWithRawElement;
{ 
	if ([self.rawElement isKindOfClass:[Photo class]])
	{
		//set up
		Photo *thePhoto = (Photo *)self.rawElement;
		
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
		self.comparable = [NSString stringWithFormat:@"%.5f",number];
		
		//clean up
		[gregorian release];gregorian = nil;
	}
}

@end
