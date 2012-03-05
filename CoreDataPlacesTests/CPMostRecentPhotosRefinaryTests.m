//
//  CPMostRecentPhotosRefinaryTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/2/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinaryTests-Internal.h"
#import "CPPhotoInterfacing.h"
#import "Photo.h"
#import <OCMock/OCMock.h>


@interface CPMostRecentPhotosRefinaryTests()
{
	CPMostRecentPhotosRefinedElement *CP_mostRecentPhotosRefinedElement;
	CPMostRecentPhotosRefinary *CP_refinary;
	id CP_mockPhoto;
	NSDate *CP_inputDate;
	NSInteger CP_hour;
	NSInteger CP_minute;
	NSInteger CP_second;
	NSString *CP_inputTitle;
	NSString *CP_inputSubtitle;
}
@end

@implementation CPMostRecentPhotosRefinaryTests

#pragma mark - Synthesize

@synthesize mostRecentPhotosRefinedElement = CP_mostRecentPhotosRefinedElement;
@synthesize refinary = CP_refinary;
@synthesize mockPhoto = CP_mockPhoto;
@synthesize inputDate = CP_inputDate;
@synthesize inputTitle = CP_inputTitle;
@synthesize inputSubtitle = CP_inputSubtitle;
@synthesize hour = CP_hour;
@synthesize minute = CP_minute;
@synthesize second = CP_second;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_mostRecentPhotosRefinedElement release];
	[CP_refinary release];
	[CP_mockPhoto release];
	[CP_inputDate release];
	[CP_inputTitle release];
	[CP_inputSubtitle release];
	[super dealloc];
}

#pragma mark - Setup / Tear down

- (void)setUp;
{
	self.mostRecentPhotosRefinedElement = [[[CPMostRecentPhotosRefinedElement alloc] init] autorelease];
	self.refinary = [[CPMostRecentPhotosRefinary alloc] init];
}

- (void)tearDown;
{
	self.refinary = nil;
	self.mostRecentPhotosRefinedElement = nil;
	self.inputDate = nil;
	self.inputTitle = nil;
	self.inputSubtitle = nil;
	self.mockPhoto = nil;
	self.hour = 0;
	self.minute = 0;
	self.second = 0;
}

#pragma mark - refinedElementsWithRawElements Test

- (void)testMethod_refinedElementsWithRawElements_01;
{
	//setup.
	int numberOfElements = 10;
	NSMutableArray *rawElements = [NSMutableArray arrayWithCapacity:numberOfElements];
	self.hour = 0;
	self.minute = 0;
	self.second = 0;
	self.inputTitle = @"title_01";
	self.inputSubtitle = @"subtitle_01";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 300;
	self.minute = 0;
	self.second = 1;
	self.inputTitle = @"title_02";
	self.inputSubtitle = @"subtitle_02";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 0;
	self.minute = 0;
	self.second = 1;
	self.inputTitle = @"title_03";
	self.inputSubtitle = @"subtitle_03";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 3;
	self.minute = 0;
	self.second = 1;
	self.inputTitle = @"title_04";
	self.inputSubtitle = @"subtitle_04";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 3;
	self.minute = 0;
	self.second = 0;
	self.inputTitle = @"title_05";
	self.inputSubtitle = @"subtitle_05";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 3;
	self.minute = 0;
	self.second = 39;
	self.inputTitle = @"title_06";
	self.inputSubtitle = @"subtitle_06";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 40;
	self.minute = 0;
	self.second = 1;
	self.inputTitle = @"title_07";
	self.inputSubtitle = @"subtitle_07";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 40;
	self.minute = 0;
	self.second = 1;
	self.inputTitle = @"title_08";
	self.inputSubtitle = @"subtitle_08";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 300;
	self.minute = 2;
	self.second = 1;
	self.inputTitle = @"title_09";
	self.inputSubtitle = @"subtitle_09";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	self.hour = 300;
	self.minute = 0;
	self.second = 1;
	self.inputTitle = @"title_10";
	self.inputSubtitle = @"subtitle_10";
	[self CP_setupForInputDateAndMockPhoto];
	[rawElements addObject:self.mockPhoto];
	
	//method under test.
	
	NSArray *supposedRefinedElements = [self.refinary refinedElementsWithGivenRefinedElementType:self.mostRecentPhotosRefinedElement rawElements:rawElements];
	
	//evaluate the outcome.
	STAssertTrue(([[supposedRefinedElements lastObject] isKindOfClass:[CPMostRecentPhotosRefinedElement class]]),@"The element returned is not a refined element type that is specified.");
	
	int count = 0;
	for (CPMostRecentPhotosRefinedElement *element in supposedRefinedElements) 
	{
		STAssertTrue(([[[rawElements objectAtIndex:count] title] isEqualToString:element.title]),@"The title is set correctly.");
		STAssertTrue(([[[rawElements objectAtIndex:count] subtitle] isEqualToString:element.subtitle]),@"The title is set correctly.");
		count++;
	}
}

#pragma mark - setComparableForRefinedElement Test

- (void)testMethod_setComparableForRefinedElement_01;
{
	//setup
	self.hour = 0;
	[self CP_setupForInputDateAndMockPhoto];
	
	//method under test.
	[self.refinary setComparableForRefinedElement:self.mostRecentPhotosRefinedElement];

	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableForRefinedElement_02;
{
	//setup
	self.hour = 2;
	[self CP_setupForInputDateAndMockPhoto];
	
	//method under test.
	[self.refinary setComparableForRefinedElement:self.mostRecentPhotosRefinedElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableForRefinedElement_03;
{
	//setup
	self.hour = 7;
	self.minute = 3;
	self.second = 33;
	[self CP_setupForInputDateAndMockPhoto];
	
	//method under test.
	[self.refinary setComparableForRefinedElement:self.mostRecentPhotosRefinedElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hour]]),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableForRefinedElement_04;
{
	//setup
	self.inputDate = nil;
	[self CP_mockPhotoSetup];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test.
	[self.refinary setComparableForRefinedElement:self.mostRecentPhotosRefinedElement];
	
	//evaluate the outcome
	STAssertTrue(([self.mostRecentPhotosRefinedElement.comparable intValue] > 10000),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableForRefinedElement_05;
{	
	//setup
	self.hour = 43;
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour];
	self.mockPhoto = nil;
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test
	[self.refinary setComparableForRefinedElement:self.mostRecentPhotosRefinedElement];
	
	//evaluate the outcome
	STAssertNil(self.mostRecentPhotosRefinedElement.comparable,@"");
}

#pragma mark - setTitleAndSubtitleForRefinedElement Test

- (void)testMethod_setTitleAndSubtitleForRefinedElement_01;
{
	//setup
	self.inputTitle = @"titleString";
	self.inputSubtitle = @"subtitleString";
	[self CP_mockPhotoSetup];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//evaluate the status before the method.
	STAssertNil(self.mostRecentPhotosRefinedElement.title,@"the title should be nil.");
	STAssertNil(self.mostRecentPhotosRefinedElement.subtitle,@"the subtitle should be nil.");
	
	//method under test.
	[self.refinary setTitleAndSubtitleForRefinedElement:self.mostRecentPhotosRefinedElement];
	
	//evaluate the outcome.
	STAssertTrue(([self.mostRecentPhotosRefinedElement.title isEqualToString:self.inputTitle]),@"the title is not set correctly.");
	STAssertTrue(([self.mostRecentPhotosRefinedElement.subtitle isEqualToString:self.inputSubtitle]),@"the subtitle is not set correctly.");
}

- (void)testMethod_setTitleAndSubtitleForRefinedElement_02;
{
	//setup
	id mockPhoto = nil;
	self.mostRecentPhotosRefinedElement.rawElement = mockPhoto;
	
	//evaluate the status before the method.
	STAssertNil(self.mostRecentPhotosRefinedElement.title,@"the title should be nil.");
	STAssertNil(self.mostRecentPhotosRefinedElement.subtitle,@"the subtitle should be nil.");
	
	//method under test.
	[self.refinary setTitleAndSubtitleForRefinedElement:self.mostRecentPhotosRefinedElement];
	
	//evaluate the outcome.
	STAssertNil(self.mostRecentPhotosRefinedElement.title,@"the title should be nil.");
	STAssertNil(self.mostRecentPhotosRefinedElement.subtitle,@"the subtitle should be nil.");
}


#pragma mark - Internal method

- (void)CP_setupForInputDateAndMockPhoto;
{
	self.inputDate = [self CP_dateOfTimeIntervalWithGivenHour:self.hour minute:self.minute second:self.second];
	[self CP_mockPhotoSetup];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
}

- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour;
{
	return [self CP_dateOfTimeIntervalWithGivenHour:hour minute:0 second:0];
}

- (NSDate *)CP_dateOfTimeIntervalWithGivenHour:(int)hour minute:(int)minute second:(int)second;
{
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setHour:-hour];
	[comps setMinute:-minute];
	[comps setSecond:-second];
	NSCalendar *gregorian = [[[NSCalendar alloc]
							  initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	return [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
}

- (void)CP_mockPhotoSetup;
{
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterfacing)];
	BOOL yesValue = YES;
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(yesValue)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	[[[self.mockPhoto stub] andReturn:self.inputTitle] title];
	[[[self.mockPhoto stub] andReturn:self.inputSubtitle] subtitle];
}

@end
