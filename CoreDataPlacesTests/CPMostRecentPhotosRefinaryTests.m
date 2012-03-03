//
//  CPMostRecentPhotosRefinaryTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/2/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPMostRecentPhotosRefinaryTests-Internal.h"
#import "CPMostRecentPhotosRefinary.h"


@implementation CPMostRecentPhotosRefinaryTests

#pragma mark - Synthesize

//@synthesize hour = CP_hour;
//@synthesize minute = CP_minute;
//@synthesize second = CP_second;

#pragma mark - setComparableForRefinedElement Test
//
//- (void)testMethod_setComparableForRefinedElement_01;
//{
//	//setup
//	self.hour = 0;
//	[self CP_setupForInputDateAndMockPhoto];
//	
//	//method under test.
////	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
//	[CPMostRecentPhotosRefinary setComparableForRefinedElement:<#(CPMostRecentPhotosRefinedElement *)#>]
//	
//	//evaluate the outcome
//	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
//}
//
//- (void)testMethod_setComparableForRefinedElement_02;
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
//- (void)testMethod_setComparableForRefinedElement_03;
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
//- (void)testMethod_setComparableForRefinedElement_04;
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
//- (void)testMethod_setComparableForRefinedElement_05;
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
//#pragma mark - setTitleAndSubtitleForRefinedElement Test
//
//- (void)testMethod_setTitleAndSubtitleForRefinedElement_01;
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
//- (void)testMethod_setTitleAndSubtitleForRefinedElement_02;
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
