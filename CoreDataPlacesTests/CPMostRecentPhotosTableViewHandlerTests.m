//
//  CPMostRecentPhotosTableViewHandlerTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/3/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPMostRecentPhotosTableViewHandlerTests.h"
#import "CPMostRecentPhotosTableViewHandler.h"
#import "CPMostRecentPhotosRefinedElement.h"
#import "CPIndexedTableViewController.h"
#import <OCMock/OCMock.h>


@implementation CPMostRecentPhotosTableViewHandlerTests

#pragma mark - titleForHeaderInSection Test

- (void)testMethod_titleForHeaderInSection_01;
{
	//setup
	int numberOfSections = 4;
	NSMutableArray *indexedSections = [NSMutableArray arrayWithCapacity:4];
	for (int index = 0; index < numberOfSections; index++) 
	{
		[indexedSections addObject:[NSMutableArray arrayWithCapacity:1]];
	}
	
	int index = 0;
	CPMostRecentPhotosRefinedElement *refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	refinedElement.comparable = @"0";
	[[indexedSections objectAtIndex:index] addObject:[refinedElement autorelease]];
	
	index = 1;
	refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	refinedElement.comparable = @"4";
	[[indexedSections objectAtIndex:index] addObject:[refinedElement autorelease]];	
	
	index = 2;
	refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	refinedElement.comparable = @"99";
	[[indexedSections objectAtIndex:index] addObject:[refinedElement autorelease]];	
	
	index = 3;
	refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	refinedElement.comparable = @"1229";
	[[indexedSections objectAtIndex:index] addObject:[refinedElement autorelease]];	
	
	id mockTVC = [OCMockObject mockForClass:[CPIndexedTableViewController class]];
	[[[mockTVC stub] andReturn:indexedSections] fetchTheElementSections];
	
	CPMostRecentPhotosTableViewHandler *tableViewHandler = [[CPMostRecentPhotosTableViewHandler alloc] init];
	
	//method under test and evaluation.
	NSString *headerTitle = [tableViewHandler indexedTableViewController:mockTVC titleForHeaderInSection:0];
	STAssertTrue(([headerTitle isEqualToString:@"Right Now"]),@"Header with zero is incorrect.");
	
	headerTitle = [tableViewHandler indexedTableViewController:mockTVC titleForHeaderInSection:1];
	STAssertTrue(([headerTitle isEqualToString:@"4 Hour(s) Ago"]),@"Header with zero is incorrect.");
	
	headerTitle = [tableViewHandler indexedTableViewController:mockTVC titleForHeaderInSection:2];
	STAssertTrue(([headerTitle isEqualToString:@"99 Hour(s) Ago"]),@"Header with zero is incorrect.");
	
	headerTitle = [tableViewHandler indexedTableViewController:mockTVC titleForHeaderInSection:3];
	STAssertTrue(([headerTitle isEqualToString:@"1229 Hour(s) Ago"]),@"Header with zero is incorrect.");
	
	[tableViewHandler release];
	
}

@end
