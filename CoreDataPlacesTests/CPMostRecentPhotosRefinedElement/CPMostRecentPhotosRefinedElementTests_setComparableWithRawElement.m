//
//  CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/28/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement-Internal.h"
#import <OCMock/OCMock.h>
#import "CPPhotoInterface.h"
#import "Photo.h"


const BOOL CPYESBoolReturnValueForMock = YES;

@interface CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement ()
{
	@private
	CPMostRecentPhotosRefinedElement *CP_mostRecentPhotosRefinedElement;
	id CP_mockPhoto;
	NSDate *CP_inputDate;
	NSInteger CP_hour;
	NSInteger CP_minute;
	NSInteger CP_second;
}
@end

@implementation CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement

#pragma mark - Synthesize

@synthesize mostRecentPhotosRefinedElement = CP_mostRecentPhotosRefinedElement;
@synthesize mockPhoto = CP_mockPhoto;
@synthesize inputDate = CP_inputDate;
@synthesize hour = CP_hour;
@synthesize minute = CP_minute;
@synthesize second = CP_second;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_inputDate release];
	[CP_mockPhoto release];
	[CP_mostRecentPhotosRefinedElement release];
	[super dealloc];
}

#pragma mark - setup / tearDown

- (void)setUp;
{
	self.mostRecentPhotosRefinedElement = [[[CPMostRecentPhotosRefinedElement alloc] init] autorelease];
	self.inputDate = nil;
	self.mockPhoto = nil;
	self.hour = 0;
	self.minute = 0;
	self.second = 0;
}

- (void)tearDown;
{
	self.mostRecentPhotosRefinedElement = nil;
	self.inputDate = nil;
	self.mockPhoto = nil;
	self.hour = 0;
	self.minute = 0;
	self.second = 0;
}

#pragma mark - Tests

- (void)testMethod_setComparableWithRawElement_01;
{
	self.hour = 0;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(CPYESBoolReturnValueForMock)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableWithRawElement_02;
{
	self.hour = 2;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(CPYESBoolReturnValueForMock)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableWithRawElement_03;
{
	//setup
	self.inputDate = nil;
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(CPYESBoolReturnValueForMock)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([self.mostRecentPhotosRefinedElement.comparable intValue] > 10000),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableWithRawElement_04;
{
	self.hour = 2;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(CPYESBoolReturnValueForMock)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//setup
	self.hour = 43;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour];
	self.mockPhoto = nil;
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertNil(self.mostRecentPhotosRefinedElement.comparable,@"");
}

- (void)testMethod_setComparableWithRawElement_05;
{
	self.hour = 1;
	self.minute = 0;
	self.second = 2;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(CPYESBoolReturnValueForMock)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	CPMostRecentPhotosRefinedElement *anotherMostRecentPhotoRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	self.hour = 1;
	self.minute = 0;
	self.second = 0;//this is the difference.
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(CPYESBoolReturnValueForMock)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	anotherMostRecentPhotoRefinedElement.rawElement = self.mockPhoto;
	
	//extract the data I need.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	NSString *firstComparable = self.mostRecentPhotosRefinedElement.comparable;
	
	[anotherMostRecentPhotoRefinedElement setComparableWithRawElement];
	NSString *secondComparable = anotherMostRecentPhotoRefinedElement.comparable;

	STAssertTrue(([firstComparable floatValue] > [secondComparable floatValue]),@"Ensure that the time difference in seconds are accounted for.");
}

#pragma mark - Internal method

- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour;
{
	return [self CP_dateOfTimeIntervalWithGivenHour:hour minute:0 second:0];
}

- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour minute:(int)minute;
{
	return [self CP_dateOfTimeIntervalWithGivenHour:hour minute:minute second:0];
}

- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour minute:(int)minute second:(int)second;
{
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setHour:-hour];
	[comps setMinute:-minute];
	[comps setSecond:-second];
	NSCalendar *gregorian = [[[NSCalendar alloc]
							  initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSDate *dateToReturn = [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
	return dateToReturn;
}


@end
