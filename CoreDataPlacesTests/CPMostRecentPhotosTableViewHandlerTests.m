//
//  CPMostRecentPhotosTableViewHandlerTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/3/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosTableViewHandlerTests.h"
#import "CPCoreDataPhotosTableViewHandler.h"
#import "CPRefinedElement.h"
#import "CPIndexedTableViewController.h"
#import <OCMock/OCMock.h>


@implementation CPMostRecentPhotosTableViewHandlerTests

#pragma mark - titleForHeaderInSection Test

- (void)testMethod_titleForHeaderInSection_01;
{
	//setup
	int numberOfSections = 4;
	NSMutableArray *indexedSections = [NSMutableArray arrayWithCapacity:numberOfSections];
	for (int index = 0; index < numberOfSections; index++) 
	{
		[indexedSections addObject:[NSMutableArray arrayWithCapacity:1]];
	}
	
	int index = 0;
	CPRefinedElement *refinedElement = [[CPRefinedElement alloc] init];
	refinedElement.comparable = @"0";
	[[indexedSections objectAtIndex:index] addObject:[refinedElement autorelease]];
	
	index = 1;
	refinedElement = [[CPRefinedElement alloc] init];
	refinedElement.comparable = @"4";
	[[indexedSections objectAtIndex:index] addObject:[refinedElement autorelease]];	
	
	index = 2;
	refinedElement = [[CPRefinedElement alloc] init];
	refinedElement.comparable = @"99";
	[[indexedSections objectAtIndex:index] addObject:[refinedElement autorelease]];	
	
	index = 3;
	refinedElement = [[CPRefinedElement alloc] init];
	refinedElement.comparable = @"1229";
	[[indexedSections objectAtIndex:index] addObject:[refinedElement autorelease]];	
	
	id mockTVC = [OCMockObject mockForClass:[CPIndexedTableViewController class]];
	[[[mockTVC stub] andReturn:indexedSections] theElementSections];
	
	CPCoreDataPhotosTableViewHandler *tableViewHandler = [[CPCoreDataPhotosTableViewHandler alloc] init];
	
	//method under test and evaluation.
	NSString *headerTitle = [tableViewHandler indexedTableViewController:mockTVC titleForHeaderInSection:0];
	STAssertTrue(([headerTitle isEqualToString:@"Right Now"]),@"Header with zero is incorrect.");
	
	headerTitle = [tableViewHandler indexedTableViewController:mockTVC titleForHeaderInSection:1];
	STAssertTrue(([headerTitle isEqualToString:@"4 Hour(s) Ago"]),@"Header with zero is incorrect.");
	
	headerTitle = [tableViewHandler indexedTableViewController:mockTVC titleForHeaderInSection:2];
	STAssertTrue(([headerTitle isEqualToString:@"99 Hour(s) Ago"]),@"Header with zero is incorrect.");
	
	headerTitle = [tableViewHandler indexedTableViewController:mockTVC titleForHeaderInSection:3];
	STAssertTrue(([headerTitle isEqualToString:@"1229 Hour(s) Ago"]),@"Header with zero is incorrect.");
	
	//clean up
	[tableViewHandler release];
}

@end
