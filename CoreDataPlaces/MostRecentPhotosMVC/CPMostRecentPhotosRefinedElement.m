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
		Photo *thePhoto = (Photo *)self.rawElement;
		NSDate *startDate = thePhoto.timeOfLastView;
		
		NSDate *endDate = [NSDate date];
		NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
		NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
		NSDateComponents *components = [gregorian components:unitFlags
													fromDate:startDate
													  toDate:endDate 
													 options:0];
		double minute = (double)[components minute]/60.0;
		double number = minute + (double)[components hour];
		NSString *string = [NSString stringWithFormat:@"%.2f",number];
		self.comparable = string;
	}
}

@end
