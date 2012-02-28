//
//  CPMostRecentPhotosRefinedElementTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/27/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "CPMostRecentPhotosRefinedElementTests.h"
#import "CPMostRecentPhotosRefinedElement.h"
#import "CPPhotoInterface.h"
#import "Photo.h"

@implementation CPMostRecentPhotosRefinedElementTests

- (NSDate *)dateOfHoursAgoWithGivenInteger:(int)hours;
{
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setHour:-hours];
	NSCalendar *gregorian = [[[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSDate *dateToReturn = [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
	return dateToReturn;
}

- (void)testMethod_setComparableWithRawElement;
{
//	NSDictionary *inputDictionary;
//	Photo *inputPhoto = nil;
	id mockPhoto = nil;
	CPMostRecentPhotosRefinedElement *mostRecentPhotosRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	int hours = 0;
	NSDate *inputDate = nil;
	BOOL yesBoolValue = YES;
	
	//test 1
	mostRecentPhotosRefinedElement.comparable = nil;
	hours = 0;
	inputDate = [self dateOfHoursAgoWithGivenInteger:hours];
	mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];

	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesBoolValue)] isKindOfClass:[Photo class]];
	[[[mockPhoto stub] andReturn:inputDate] timeOfLastView];
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//method under test.
	[mostRecentPhotosRefinedElement setComparableWithRawElement];
//	STAssertNil(mostRecentPhotosRefinedElement.comparable,@"");
	
	STAssertTrue(([[NSString stringWithFormat:@"%d",[mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",hours]]),@"setComparableWithRawElement isn't functioning correctly.");
	
	//test 2
	mostRecentPhotosRefinedElement.comparable = nil;
	hours = 2;
	inputDate = [self dateOfHoursAgoWithGivenInteger:hours];
	mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesBoolValue)] isKindOfClass:[Photo class]];
	[[[mockPhoto stub] andReturn:inputDate] timeOfLastView];
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//method under test.
	[mostRecentPhotosRefinedElement setComparableWithRawElement];
	//	STAssertNil(mostRecentPhotosRefinedElement.comparable,@"");
	
	STAssertTrue(([[NSString stringWithFormat:@"%d",[mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",hours]]),@"setComparableWithRawElement isn't functioning correctly.");
	
	//test 3
	mostRecentPhotosRefinedElement.comparable = nil;
	inputDate = nil;
	mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesBoolValue)] isKindOfClass:[Photo class]];
	[[[mockPhoto stub] andReturn:inputDate] timeOfLastView];
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//method under test.
	[mostRecentPhotosRefinedElement setComparableWithRawElement];
	//	STAssertNil(mostRecentPhotosRefinedElement.comparable,@"");
	
	STAssertTrue(([mostRecentPhotosRefinedElement.comparable intValue] > 10000),@"setComparableWithRawElement isn't functioning correctly.");
	
	//test 4
	mostRecentPhotosRefinedElement.comparable = nil;
	hours = 43;
	inputDate = [self dateOfHoursAgoWithGivenInteger:hours];
	mockPhoto = nil;
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//method under test.
	[mostRecentPhotosRefinedElement setComparableWithRawElement];
	STAssertNil(mostRecentPhotosRefinedElement.comparable,@"");
	[mostRecentPhotosRefinedElement release];
}

@end
