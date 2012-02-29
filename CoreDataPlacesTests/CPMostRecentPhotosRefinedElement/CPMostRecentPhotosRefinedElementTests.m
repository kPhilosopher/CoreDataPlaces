//
//  CPMostRecentPhotosRefinedElementTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/28/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPMostRecentPhotosRefinedElementTests-Internal.h"
#import <OCMock/OCMock.h>
#import "Photo.h"

@implementation CPMostRecentPhotosRefinedElementTests

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

#pragma mark - Setup / Tear down

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

#pragma mark - setComparableWithRawElement Test

- (void)testMethod_setComparableWithRawElement_01;
{
	//setup
	self.hour = 0;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour];
	[self CP_mockPhotoSetup];
	
	//method under test.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableWithRawElement_02;
{
	//setup
	self.hour = 2;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour];
	[self CP_mockPhotoSetup];
	
	//method under test.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableWithRawElement_03;
{
	//setup
	self.inputDate = nil;
	[self CP_mockPhotoSetup];
	
	//method under test.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([self.mostRecentPhotosRefinedElement.comparable intValue] > 10000),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableWithRawElement_04;
{	
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
	//setup
	self.second = 2;
	
	self.hour = 1;
	self.minute = 0;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
	[self CP_mockPhotoSetup];
	
	
	CPMostRecentPhotosRefinedElement *anotherMostRecentPhotoRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	
	self.second = 0;
	
	self.hour = 1;
	self.minute = 0;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
//	[self CP_mockPhotoSetup];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterfacing)];
	BOOL yesValue = YES;
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesValue)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	anotherMostRecentPhotoRefinedElement.rawElement = self.mockPhoto;
	
	//extract the data I need.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	NSString *firstComparable = self.mostRecentPhotosRefinedElement.comparable;
	
	[anotherMostRecentPhotoRefinedElement setComparableWithRawElement];
	NSString *secondComparable = anotherMostRecentPhotoRefinedElement.comparable;
	
	//evaluate the outcome.
	STAssertTrue(([anotherMostRecentPhotoRefinedElement.comparable intValue] == 1),@"setComparableWithRawElement isn't functioning correctly.");
	STAssertTrue(([self.mostRecentPhotosRefinedElement.comparable intValue] == 1),@"setComparableWithRawElement isn't functioning correctly.");
	STAssertTrue(([firstComparable floatValue] > [secondComparable floatValue]),@"Ensure that the time difference in seconds are accounted for.");
}

#pragma mark - setTitleAndSubtitleWithRawElement Test

- (void)testMethod_setTitleAndSubtitleWithRawElement_01;
{
	//setup
	CPMostRecentPhotosRefinedElement *mostRecentPhotosRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	NSString *inputTitle = @"titleString";
	NSString *inputSubtitle = @"subtitleString";
	id mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterfacing)];
	BOOL yesValue = YES;
	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesValue)] isKindOfClass:[Photo class]];
	[[[mockPhoto stub] andReturn:inputTitle] title];
	[[[mockPhoto stub] andReturn:inputSubtitle] subtitle];
	mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//evaluate the outcome.
	STAssertTrue(([mostRecentPhotosRefinedElement.title isEqualToString:inputTitle]),@"the title is not set correctly.");
	STAssertTrue(([mostRecentPhotosRefinedElement.subtitle isEqualToString:inputSubtitle]),@"the subtitle is not set correctly.");
}

#pragma mark - compare Test

- (void)testMethod_compare_01;
{
	//setup
	
	//first comparable setup
	self.second = 2;
	
	self.hour = 1;
	self.minute = 0;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
	[self CP_mockPhotoSetup];
	
	//second comparable setup
	CPMostRecentPhotosRefinedElement *anotherMostRecentPhotoRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	
	self.second = 0;
	
	self.hour = 1;
	self.minute = 0;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
	//	[self CP_mockPhotoSetup];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterfacing)];
	BOOL yesValue = YES;
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesValue)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	anotherMostRecentPhotoRefinedElement.rawElement = self.mockPhoto;
	
	//extract the data I need.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	NSString *firstComparable = self.mostRecentPhotosRefinedElement.comparable;
	
	[anotherMostRecentPhotoRefinedElement setComparableWithRawElement];
	NSString *secondComparable = anotherMostRecentPhotoRefinedElement.comparable;
	
	//evaluate the outcome.
	STAssertTrue(([anotherMostRecentPhotoRefinedElement.comparable intValue] == 1),@"setComparableWithRawElement isn't functioning correctly.");
	STAssertTrue(([self.mostRecentPhotosRefinedElement.comparable intValue] == 1),@"setComparableWithRawElement isn't functioning correctly.");
	STAssertTrue(([firstComparable floatValue] > [secondComparable floatValue]),@"Ensure that the time difference in seconds are accounted for.");
	STAssertTrue(([self.mostRecentPhotosRefinedElement.comparable compare:anotherMostRecentPhotoRefinedElement.comparable] > 0), @"");
}

#pragma mark - Internal method

- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour;
{
	return [self CP_dateOfTimeIntervalWithGivenHour:hour minute:0];
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

- (void)CP_mockPhotoSetup;
{
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterfacing)];
	BOOL yesValue = YES;
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesValue)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
}

@end
