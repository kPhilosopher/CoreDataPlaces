//
//  CPMostRecentPhotosRefinedElementTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/28/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
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
}

//#pragma mark - setComparableWithRawElement Test
//
//- (void)testMethod_setComparableWithRawElement_01;
//{
//	//setup
//	self.hour = 0;
//	[self CP_setupForInputDateAndMockPhoto];
//		
//	//method under test.
//	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
//	
//	//evaluate the outcome
//	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
//}
//
//- (void)testMethod_setComparableWithRawElement_02;
//{
//	//setup
//	self.hour = 2;
//	[self CP_setupForInputDateAndMockPhoto];
//	
//	//method under test.
//	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
//	
//	//evaluate the outcome
//	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
//}
//
//- (void)testMethod_setComparableWithRawElement_03;
//{
//	//setup
//	self.hour = 7;
//	self.minute = 3;
//	self.second = 33;
//	[self CP_setupForInputDateAndMockPhoto];
//	
//	//method under test.
//	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
//	
//	//evaluate the outcome
//	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
//}
//
//- (void)testMethod_setComparableWithRawElement_04;
//{
//	//setup
//	self.inputDate = nil;
//	[self CP_mockPhotoSetup];
//	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
//	
//	//method under test.
//	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
//	
//	//evaluate the outcome
//	STAssertTrue(([self.mostRecentPhotosRefinedElement.comparable intValue] > 10000),@"setComparableWithRawElement isn't functioning correctly.");
//}
//
//- (void)testMethod_setComparableWithRawElement_05;
//{	
//	//setup
//	self.hour = 43;
//	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour];
//	self.mockPhoto = nil;
//	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
//	
//	//method under test
//	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
//	
//	//evaluate the outcome
//	STAssertNil(self.mostRecentPhotosRefinedElement.comparable,@"");
//}
//
//#pragma mark - setTitleAndSubtitleWithRawElement Test
//
//- (void)testMethod_setTitleAndSubtitleWithRawElement_01;
//{
//	//setup
//	NSString *inputTitle = @"titleString";
//	NSString *inputSubtitle = @"subtitleString";
//	id mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterfacing)];
//	BOOL yesValue = YES;
//	[[[mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesValue)] isKindOfClass:[Photo class]];
//	[[[mockPhoto stub] andReturn:inputTitle] title];
//	[[[mockPhoto stub] andReturn:inputSubtitle] subtitle];
//	
//	
//	//evaluate the status before the method.
//	STAssertNil(self.mostRecentPhotosRefinedElement.title,@"the title should be nil.");
//	STAssertNil(self.mostRecentPhotosRefinedElement.subtitle,@"the subtitle should be nil.");
//	
//	self.mostRecentPhotosRefinedElement.rawElement = mockPhoto;
//	
//	//evaluate the outcome.
//	STAssertTrue(([self.mostRecentPhotosRefinedElement.title isEqualToString:inputTitle]),@"the title is not set correctly.");
//	STAssertTrue(([self.mostRecentPhotosRefinedElement.subtitle isEqualToString:inputSubtitle]),@"the subtitle is not set correctly.");
//}
//
//- (void)testMethod_setTitleAndSubtitleWithRawElement_02;
//{
//	//setup
//	id mockPhoto = nil;
//	
//	//evaluate the status before the method.
//	STAssertNil(self.mostRecentPhotosRefinedElement.title,@"the title should be nil.");
//	STAssertNil(self.mostRecentPhotosRefinedElement.subtitle,@"the subtitle should be nil.");
//	
//	self.mostRecentPhotosRefinedElement.rawElement = mockPhoto;
//	
//	//evaluate the outcome.
//	STAssertNil(self.mostRecentPhotosRefinedElement.title,@"the title should be nil.");
//	STAssertNil(self.mostRecentPhotosRefinedElement.subtitle,@"the subtitle should be nil.");
//}

#pragma mark - compare Test

- (void)testMethod_compare_01;
{
	//setup
	
	//first comparable setup
//	self.second = 2;
//	
//	self.hour = 1;
//	self.minute = 0;
//	[self CP_setupForInputDateAndMockPhoto];
	NSString *firstComparable = @"2.3338";
	self.mostRecentPhotosRefinedElement.comparable = firstComparable;
	
	//second comparable setup
	CPMostRecentPhotosRefinedElement *anotherMostRecentPhotoRefinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	NSString *secondComparable = @"2.3337";
	anotherMostRecentPhotoRefinedElement.comparable = secondComparable;
//	self.second = 0;
//	
//	self.hour = 1;
//	self.minute = 0;
//	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
//	[self CP_mockPhotoSetup];
//	anotherMostRecentPhotoRefinedElement.rawElement = self.mockPhoto;
	
	//extract the data I need.
//	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
//	NSString *firstComparable = self.mostRecentPhotosRefinedElement.comparable;
	
//	[anotherMostRecentPhotoRefinedElement setComparableWithRawElement];
//	NSString *secondComparable = anotherMostRecentPhotoRefinedElement.comparable;
	
	//evaluate the outcome.
//	STAssertTrue(([anotherMostRecentPhotoRefinedElement.comparable intValue] == self.hour),@"setComparableWithRawElement isn't functioning correctly.");
//	STAssertTrue(([self.mostRecentPhotosRefinedElement.comparable intValue] == self.hour),@"setComparableWithRawElement isn't functioning correctly.");
	STAssertTrue(([firstComparable floatValue] > [secondComparable floatValue]),@"Ensure that the time difference in seconds are accounted for.");
	//method under test.
	STAssertTrue(([self.mostRecentPhotosRefinedElement compare:anotherMostRecentPhotoRefinedElement] > 0), @"");
}

#pragma mark - Internal method

//- (void)CP_setupForInputDateAndMockPhoto;
//{
//	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
//	[self CP_mockPhotoSetup];
//	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
//}
//
//- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour;
//{
//	return [self CP_dateOfTimeIntervalWithGivenHour:hour minute:0 second:0];
//}
//
//- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour minute:(int)minute second:(int)second;
//{
//	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
//	[comps setHour:-hour];
//	[comps setMinute:-minute];
//	[comps setSecond:-second];
//	NSCalendar *gregorian = [[[NSCalendar alloc]
//							  initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
//	return [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
//}
//
//- (void)CP_mockPhotoSetup;
//{
//	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterfacing)];
//	BOOL yesValue = YES;
//	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesValue)] isKindOfClass:[Photo class]];
//	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
//}

@end
