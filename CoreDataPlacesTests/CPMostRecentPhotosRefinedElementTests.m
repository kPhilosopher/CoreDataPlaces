//
//  CPMostRecentPhotosRefinedElementTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/28/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinedElementTests-Internal.h"
#import "CPPhotoInterfacing.h"


@interface CPMostRecentPhotosRefinedElementTests()
{
	CPRefinedElement *CP_mostRecentPhotosRefinedElement;
}
@end

#pragma mark -

@implementation CPMostRecentPhotosRefinedElementTests

#pragma mark - Synthesize

@synthesize mostRecentPhotosRefinedElement = CP_mostRecentPhotosRefinedElement;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_mostRecentPhotosRefinedElement release];
	[super dealloc];
}

#pragma mark - Setup / Tear down

- (void)setUp;
{
	self.mostRecentPhotosRefinedElement = [[[CPRefinedElement alloc] init] autorelease];
}

- (void)tearDown;
{
	self.mostRecentPhotosRefinedElement = nil;
}

#pragma mark - compare Test

- (void)testMethod_compare_01;
{
	//setup
	NSString *firstComparable = @"2.3338";
	self.mostRecentPhotosRefinedElement.comparable = firstComparable;
	
	//second comparable setup
	CPRefinedElement *anotherMostRecentPhotoRefinedElement = [[CPRefinedElement alloc] init];
	NSString *secondComparable = @"2.3337";
	anotherMostRecentPhotoRefinedElement.comparable = secondComparable;

	STAssertTrue(([firstComparable floatValue] > [secondComparable floatValue]),@"Ensure that the time difference in seconds are accounted for.");
	
	//method under test.
	STAssertTrue(([self.mostRecentPhotosRefinedElement compare:anotherMostRecentPhotoRefinedElement] > 0), @"");
	
	//clean up
	[anotherMostRecentPhotoRefinedElement release];
}

- (void)testMethod_compare_02;
{
	//setup
	NSString *firstComparable = @"0.3538";
	self.mostRecentPhotosRefinedElement.comparable = firstComparable;
	
	//second comparable setup
	CPRefinedElement *anotherMostRecentPhotoRefinedElement = [[CPRefinedElement alloc] init];
	NSString *secondComparable = @"0.3538";
	anotherMostRecentPhotoRefinedElement.comparable = secondComparable;
	
	STAssertTrue(([firstComparable floatValue] == [secondComparable floatValue]),@"Ensure that the time difference in seconds are accounted for.");
	
	//method under test.
	STAssertTrue(([self.mostRecentPhotosRefinedElement compare:anotherMostRecentPhotoRefinedElement] == 0), @"");
	
	//clean up
	[anotherMostRecentPhotoRefinedElement release];
}

- (void)testMethod_compare_03;
{
	//setup
	NSString *firstComparable = @"200.3538";
	self.mostRecentPhotosRefinedElement.comparable = firstComparable;
	
	//second comparable setup
	CPRefinedElement *anotherMostRecentPhotoRefinedElement = [[CPRefinedElement alloc] init];
	NSString *secondComparable = @"201.3538";
	anotherMostRecentPhotoRefinedElement.comparable = secondComparable;
	
	STAssertTrue(([firstComparable floatValue] < [secondComparable floatValue]),@"Ensure that the time difference in seconds are accounted for.");
	
	//method under test.
	STAssertTrue(([self.mostRecentPhotosRefinedElement compare:anotherMostRecentPhotoRefinedElement] < 0), @"");
	
	//clean up
	[anotherMostRecentPhotoRefinedElement release];
}

@end
