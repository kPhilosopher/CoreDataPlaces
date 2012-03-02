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

#pragma mark - sectionCountAndSetSectionNumberForElementsInArray Test

- (void)testMethod_sectionsCountAndSetSectionNumberForElementsInArray_01;
{
	//setup
	NSMutableArray *listOfComparableStrings = [NSMutableArray array];
	NSMutableDictionary *comparableToSection = [NSMutableDictionary dictionary];
	int totalSections = 12;
	//sections include 0,1,2,3,4,5,6,11,12,13,14,200
	[comparableToSection setObject:@"0" forKey:@"0"];
	[comparableToSection setObject:@"1" forKey:@"1"];
	[comparableToSection setObject:@"2" forKey:@"2"];
	[comparableToSection setObject:@"3" forKey:@"3"];
	[comparableToSection setObject:@"4" forKey:@"4"];
	[comparableToSection setObject:@"5" forKey:@"5"];
	[comparableToSection setObject:@"6" forKey:@"6"];
	[comparableToSection setObject:@"7" forKey:@"11"];
	[comparableToSection setObject:@"8" forKey:@"12"];
	[comparableToSection setObject:@"9" forKey:@"13"];
	[comparableToSection setObject:@"10" forKey:@"14"];
	[comparableToSection setObject:@"11" forKey:@"200"];
	
	
	[listOfComparableStrings addObject:@"0.00001"];
	[listOfComparableStrings addObject:@"0.10000"];
	[listOfComparableStrings addObject:@"0.21000"];
	[listOfComparableStrings addObject:@"0.30002"];
	[listOfComparableStrings addObject:@"0.9"];
	
	[listOfComparableStrings addObject:@"2.10000"];
	[listOfComparableStrings addObject:@"2.21000"];
	[listOfComparableStrings addObject:@"2.30002"];
	[listOfComparableStrings addObject:@"2.9"];
	
	[listOfComparableStrings addObject:@"12.00001"];
	[listOfComparableStrings addObject:@"12.10000"];
	[listOfComparableStrings addObject:@"12.21000"];
	[listOfComparableStrings addObject:@"12.30002"];
	[listOfComparableStrings addObject:@"12.9"];
	
	[listOfComparableStrings addObject:@"6.00001"];
	[listOfComparableStrings addObject:@"5.99032"];
	[listOfComparableStrings addObject:@"4.441000"];
	[listOfComparableStrings addObject:@"3.00001"];
	[listOfComparableStrings addObject:@"1.9"];
	
	[listOfComparableStrings addObject:@"12.00001"];
	[listOfComparableStrings addObject:@"12.10000"];
	[listOfComparableStrings addObject:@"12.21000"];
	[listOfComparableStrings addObject:@"12.30002"];
	[listOfComparableStrings addObject:@"12.9"];
	
	[listOfComparableStrings addObject:@"2.9"];
	[listOfComparableStrings addObject:@"2.30002"];
	[listOfComparableStrings addObject:@"2.21000"];
	[listOfComparableStrings addObject:@"2.10000"];
	
	[listOfComparableStrings addObject:@"11"];
	[listOfComparableStrings addObject:@"11"];
	[listOfComparableStrings addObject:@"11"];
	
	[listOfComparableStrings addObject:@"200"];
	[listOfComparableStrings addObject:@"14"];
	[listOfComparableStrings addObject:@"13"];
	[listOfComparableStrings addObject:@"11"];
	
	int numberOfElements = [listOfComparableStrings count];
	NSMutableArray *elementsToSetSections = [NSMutableArray arrayWithCapacity:numberOfElements];
	
	for (int index = 0; index < numberOfElements; index++)
	{
		CPMostRecentPhotosRefinedElement *refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
		refinedElement.comparable = [listOfComparableStrings objectAtIndex:index];
		[elementsToSetSections addObject:refinedElement];
		[refinedElement release];
	}
	
	//method under test
	int calculatedSectionCount = [self.dataIndexer sectionsCountAndSetSectionNumberForElementsInArray:elementsToSetSections];
	
	//evaluate the outcome
	STAssertTrue((calculatedSectionCount == totalSections),@"The total section calculation is wrong");
	for (int index = 0; index < [elementsToSetSections count]; index++)
	{
		if ([[elementsToSetSections objectAtIndex:index] isKindOfClass:[CPMostRecentPhotosRefinedElement class]])
		{
			CPMostRecentPhotosRefinedElement *refinedElement = (CPMostRecentPhotosRefinedElement *)[elementsToSetSections objectAtIndex:index];
			NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
			NSLog(@"%@",[NSString stringWithFormat:@"sectionNumber:%d",refinedElement.sectionNumber]);
			NSLog(@"%@",[NSString stringWithFormat:@"sectionNumber:%@",[listOfComparableStrings objectAtIndex:index]]);
			NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
			NSString *integerOfTestDataComparable = [NSString stringWithFormat:@"%d",[[listOfComparableStrings objectAtIndex:index] intValue]];
			
			STAssertTrue((refinedElement.sectionNumber == [[comparableToSection objectForKey:integerOfTestDataComparable] intValue]),@"The section setting algorithm has an error.");
		}
	}
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
