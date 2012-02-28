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
	id mockPhoto = nil;
	int hours = 0;
	NSDate *inputDate = nil;
	BOOL yesBoolValue = YES;
	
	//---------
	//test 1 (hours = 0)
	//---------
	
	//setup
	CPMostRecentPhotosRefinedElement *mostRecentPhotosRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	hours = 0;
	inputDate = [self dateOfHoursAgoWithGivenInteger:hours];
	mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesBoolValue)] isKindOfClass:[Photo class]];
	[[[mockPhoto stub] andReturn:inputDate] timeOfLastView];
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//method under test.
	[mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",hours]]),@"setComparableWithRawElement isn't functioning correctly.");
	
	//tear down
	[mostRecentPhotosRefinedElement release];mostRecentPhotosRefinedElement = nil;
	
	//---------
	//test 2 (hours = 2)
	//---------
	
	//setup
	mostRecentPhotosRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	hours = 2;
	inputDate = [self dateOfHoursAgoWithGivenInteger:hours];
	mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesBoolValue)] isKindOfClass:[Photo class]];
	[[[mockPhoto stub] andReturn:inputDate] timeOfLastView];
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//method under test.
	[mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",hours]]),@"setComparableWithRawElement isn't functioning correctly.");
	
	//tear down
	[mostRecentPhotosRefinedElement release];mostRecentPhotosRefinedElement = nil;
	
	//---------
	//test 3 (nil input date)
	//---------
	
	//setup
	mostRecentPhotosRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	inputDate = nil;
	mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesBoolValue)] isKindOfClass:[Photo class]];
	[[[mockPhoto stub] andReturn:inputDate] timeOfLastView];
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//method under test.
	[mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([mostRecentPhotosRefinedElement.comparable intValue] > 10000),@"setComparableWithRawElement isn't functioning correctly.");
	
	//tear down
	[mostRecentPhotosRefinedElement release];mostRecentPhotosRefinedElement = nil;
	
	//---------
	//test 4 (nil rawElement)
	//---------
	
	//setup
	mostRecentPhotosRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	hours = 43;
	inputDate = [self dateOfHoursAgoWithGivenInteger:hours];
	mockPhoto = nil;
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//method under test
	[mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertNil(mostRecentPhotosRefinedElement.comparable,@"");
	
	//tear down
	[mostRecentPhotosRefinedElement release];mostRecentPhotosRefinedElement = nil;
}

@end
