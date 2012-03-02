//
//  CPMostRecentPhotosDataIndexerTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/29/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

// !!!: Testing using CPMostRecentPhotosRefinedElement

#import "CPMostRecentPhotosDataIndexerTests-Internal.h"


@interface CPMostRecentPhotosDataIndexerTests()
{
	CPMostRecentPhotosDataIndexer *CP_dataIndexer;
}
@end

#pragma mark -

@implementation CPMostRecentPhotosDataIndexerTests

#pragma mark - Synthesize

@synthesize dataIndexer = CP_dataIndexer;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_dataIndexer release];
	[super dealloc];
}

#pragma mark - Setup / Tear down

- (void)setUp;
{
	CPMostRecentPhotosRefinedElement *refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	self.dataIndexer = [[[CPMostRecentPhotosDataIndexer alloc] initWithRefinedElement:refinedElement] autorelease];
	[refinedElement release];
}

- (void)tearDown;
{
	self.dataIndexer = nil;
}

#pragma mark - sortTheElementsInSectionArrayAndAddToArrayOfSections Test

- (void)testMethod_sortTheElementsInSectionArrayAndAddToArrayOfSections_01;
{
	//setup
	int numberOfElements = 8;
	
	NSMutableArray *elementsToSort = [NSMutableArray arrayWithCapacity:numberOfElements];
	NSMutableArray *listOfComparableStrings = [NSMutableArray arrayWithCapacity:numberOfElements];
	
	NSString *comparableString_01 = @"0.00001";
	NSString *comparableString_02 = @"0.10000";
	NSString *comparableString_03 = @"0.20000";
	NSString *comparableString_04 = @"0.21000";
	NSString *comparableString_05 = @"0.30000";
	NSString *comparableString_06 = @"0.30001";
	NSString *comparableString_07 = @"0.30002";
	NSString *comparableString_08 = @"0.9";
	
	[listOfComparableStrings addObject:comparableString_01];
	[listOfComparableStrings addObject:comparableString_02];
	[listOfComparableStrings addObject:comparableString_03];
	[listOfComparableStrings addObject:comparableString_04];
	[listOfComparableStrings addObject:comparableString_05];
	[listOfComparableStrings addObject:comparableString_06];
	[listOfComparableStrings addObject:comparableString_07];
	[listOfComparableStrings addObject:comparableString_08];
	NSMutableArray *listOfComparableStringsForEvaluation = [NSMutableArray arrayWithArray:listOfComparableStrings];
	
	int count = numberOfElements;
	int randomNumber = 0;
	while (count > 0)
	{
		randomNumber = arc4random()%count;
		CPMostRecentPhotosRefinedElement *refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
		refinedElement.comparable = [listOfComparableStrings objectAtIndex:randomNumber];//use of internal setter.
		[listOfComparableStrings removeObjectAtIndex:randomNumber];
		[elementsToSort addObject:refinedElement];
		[refinedElement release];
		count = count - 1;
	}
	NSMutableArray *sectionsOfArray = [NSMutableArray array];
	
	//method under tests
	[self.dataIndexer sortTheElementsInSectionArray:elementsToSort andAddToArrayOfSections:sectionsOfArray];
	
	//evaluate the outcomes
	STAssertTrue(([[sectionsOfArray lastObject] isKindOfClass:[NSMutableArray class]]),@"there should be a mutable array in the arrayOfSections");
	
	int indexCount = 0;
	for (CPMostRecentPhotosRefinedElement *element in [sectionsOfArray lastObject])
	{
		STAssertTrue(([[sectionsOfArray lastObject] count] == numberOfElements),@"The array does not have the correct number of elements.");
		STAssertTrue(([[listOfComparableStringsForEvaluation objectAtIndex:indexCount] floatValue] == [element.comparable floatValue]),@"The sorting algorithm isn't working.");
		indexCount = indexCount + 1;
	}
}

@end
