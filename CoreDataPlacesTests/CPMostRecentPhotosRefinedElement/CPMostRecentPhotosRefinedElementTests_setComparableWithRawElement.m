//
//  CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/28/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
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
	NSInteger CP_hours;
}
@end

@implementation CPMostRecentPhotosRefinedElementTests_setComparableWithRawElement

#pragma mark - Synthesize

@synthesize mostRecentPhotosRefinedElement = CP_mostRecentPhotosRefinedElement;
@synthesize mockPhoto = CP_mockPhoto;
@synthesize inputDate = CP_inputDate;
@synthesize hours = CP_hours;

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
}

- (void)tearDown;
{
	self.mostRecentPhotosRefinedElement = nil;
	self.inputDate = nil;
	self.mockPhoto = nil;
	self.hours = 0;
}

#pragma mark - Tests

- (void)testMethod_setComparableWithRawElement_01;
{
	self.hours = 0;
	self.inputDate = [self CP_dateOfHoursAgoWithGivenInteger:self.hours];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(CPYESBoolReturnValueForMock)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hours]]),@"setComparableWithRawElement isn't functioning correctly.");
}

- (void)testMethod_setComparableWithRawElement_02;
{
	self.hours = 2;
	self.inputDate = [self CP_dateOfHoursAgoWithGivenInteger:self.hours];
	self.mockPhoto = [OCMockObject mockForProtocol:@protocol(CPPhotoInterface)];
	[[[self.mockPhoto stub] andReturnValue:OCMOCK_VALUE(CPYESBoolReturnValueForMock)] isKindOfClass:[Photo class]];
	[[[self.mockPhoto stub] andReturn:self.inputDate] timeOfLastView];
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test.
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertTrue(([[NSString stringWithFormat:@"%d",[self.mostRecentPhotosRefinedElement.comparable intValue]] isEqualToString:[NSString stringWithFormat:@"%d",self.hours]]),@"setComparableWithRawElement isn't functioning correctly.");
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
	//setup
	self.hours = 43;
	self.inputDate = [self CP_dateOfHoursAgoWithGivenInteger:self.hours];
	self.mockPhoto = nil;
	self.mostRecentPhotosRefinedElement.rawElement = self.mockPhoto;
	
	//method under test
	[self.mostRecentPhotosRefinedElement setComparableWithRawElement];
	
	//evaluate the outcome
	STAssertNil(self.mostRecentPhotosRefinedElement.comparable,@"");
}

#pragma mark - Internal method

- (NSDate *)CP_dateOfHoursAgoWithGivenInteger:(int)hours;
{
	NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
	[comps setHour:-hours];
	NSCalendar *gregorian = [[[NSCalendar alloc]
							  initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSDate *dateToReturn = [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
	return dateToReturn;
}

@end
