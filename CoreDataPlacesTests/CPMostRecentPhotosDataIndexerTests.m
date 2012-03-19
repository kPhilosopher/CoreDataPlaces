//
//  CPMostRecentPhotosDataIndexerTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/29/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

// !!!: Testing using CPMostRecentPhotosRefinedElement

#import "CPMostRecentPhotosDataIndexerTests-Internal.h"
#import "CPPhotosDataIndexer.h"
#import "CPRefinedElement.h"
#import "Photo.h"


@interface CPMostRecentPhotosDataIndexerTests()
{
	CPPhotosDataIndexer *CP_dataIndexer;
	NSMutableArray *CP_listOfRawTestData;
	NSMutableArray *CP_listOfTestInput;
}
@end

#pragma mark -

@implementation CPMostRecentPhotosDataIndexerTests

#pragma mark - Synthesize

@synthesize dataIndexer = CP_dataIndexer;
@synthesize listOfRawTestData = CP_listOfRawTestData;
@synthesize listOfTestInput = CP_listOfTestInput;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_dataIndexer release];
	[CP_listOfRawTestData release];
	[CP_listOfTestInput release];
	[super dealloc];
}

#pragma mark - Setup / Tear down

- (void)setUp;
{
	self.dataIndexer = [[CPPhotosDataIndexer alloc] init];
	self.listOfRawTestData = [NSMutableArray array];
}

- (void)tearDown;
{
	self.dataIndexer = nil;
	self.listOfRawTestData = nil;
	self.listOfTestInput = nil;
}

#pragma mark - indexedSectionsOfRefinedElements Test

- (void)testMethod_indexedSectionsOfRefinedElements_01;
{
	//setup
	
	//sections include 0,1,2,3,4,5,6,11,12,13,14,200
	NSMutableDictionary *sectionToComparableMapping = [NSMutableDictionary dictionary];
	[sectionToComparableMapping setObject:@"0" forKey:@"0"];
	[sectionToComparableMapping setObject:@"1" forKey:@"1"];
	[sectionToComparableMapping setObject:@"2" forKey:@"2"];
	[sectionToComparableMapping setObject:@"3" forKey:@"3"];
	[sectionToComparableMapping setObject:@"4" forKey:@"4"];
	[sectionToComparableMapping setObject:@"5" forKey:@"5"];
	[sectionToComparableMapping setObject:@"6" forKey:@"6"];
	[sectionToComparableMapping setObject:@"11" forKey:@"7"];
	[sectionToComparableMapping setObject:@"12" forKey:@"8"];
	[sectionToComparableMapping setObject:@"13" forKey:@"9"];
	[sectionToComparableMapping setObject:@"14" forKey:@"10"];
	[sectionToComparableMapping setObject:@"200" forKey:@"11"];
	int totalSections = [sectionToComparableMapping count];
	
	[self.listOfRawTestData addObject:@"0.00001"];
	[self.listOfRawTestData addObject:@"0.10000"];
	[self.listOfRawTestData addObject:@"0.21000"];
	[self.listOfRawTestData addObject:@"0.30002"];
	[self.listOfRawTestData addObject:@"0.9"];
	
	[self.listOfRawTestData addObject:@"2.10000"];
	[self.listOfRawTestData addObject:@"2.21000"];
	[self.listOfRawTestData addObject:@"2.30002"];
	[self.listOfRawTestData addObject:@"2.9"];
	
	[self.listOfRawTestData addObject:@"12.00001"];
	[self.listOfRawTestData addObject:@"12.10000"];
	[self.listOfRawTestData addObject:@"12.21000"];
	[self.listOfRawTestData addObject:@"12.30002"];
	[self.listOfRawTestData addObject:@"12.9"];
	
	[self.listOfRawTestData addObject:@"6.00001"];
	[self.listOfRawTestData addObject:@"5.99032"];
	[self.listOfRawTestData addObject:@"4.441000"];
	[self.listOfRawTestData addObject:@"3.00001"];
	[self.listOfRawTestData addObject:@"1.9"];
	
	[self.listOfRawTestData addObject:@"12.00001"];
	[self.listOfRawTestData addObject:@"12.10000"];
	[self.listOfRawTestData addObject:@"12.21000"];
	[self.listOfRawTestData addObject:@"12.30002"];
	[self.listOfRawTestData addObject:@"12.9"];
	
	[self.listOfRawTestData addObject:@"2.9"];
	[self.listOfRawTestData addObject:@"2.30002"];
	[self.listOfRawTestData addObject:@"2.21000"];
	[self.listOfRawTestData addObject:@"2.10000"];
	
	[self.listOfRawTestData addObject:@"11"];
	[self.listOfRawTestData addObject:@"11"];
	[self.listOfRawTestData addObject:@"11"];
	
	[self.listOfRawTestData addObject:@"200"];
	[self.listOfRawTestData addObject:@"14"];
	[self.listOfRawTestData addObject:@"13"];
	[self.listOfRawTestData addObject:@"11"];
	
	int numberOfElements = [self.listOfRawTestData count];
	self.listOfTestInput = [NSMutableArray arrayWithCapacity:numberOfElements];
	
	for (int index = 0; index < numberOfElements; index++)
	{
		[self CP_setupListOfTestInputAtIndex:index];
	}
	
	//method under test.
	NSMutableArray *indexedSections = [self.dataIndexer indexedSectionsOfRefinedElements:self.listOfTestInput];
	
	//evaluate the outcome
	STAssertTrue(([indexedSections count] == totalSections),@"The total section calculation is wrong");
	
	int index = 0;
	CPRefinedElement *refinedElementOfPreviousIndexedSection = nil;
	for (NSArray *indexedSection in indexedSections) 
	{
		CPRefinedElement *refinedElement = (CPRefinedElement *)[indexedSection lastObject];
		
		STAssertTrue(([refinedElement isKindOfClass:[CPRefinedElement class]]),@"The object in the indexed sections should be a refined element");
		NSString *keyForMapping = [NSString stringWithFormat:@"%d",index++];
		STAssertTrue(([refinedElement.comparable intValue] == [[sectionToComparableMapping objectForKey:keyForMapping] intValue]),@"The sections are not set correctly.");
		
		if (refinedElementOfPreviousIndexedSection)
		{
			NSNumber *refinedElementComparableValueFromPreviousSection = [NSNumber numberWithFloat:[refinedElementOfPreviousIndexedSection.comparable floatValue]];
			NSNumber *refinedElementComparableValueFromCurrentSection = [NSNumber numberWithFloat:[refinedElement.comparable floatValue]];
			STAssertTrue(([refinedElementComparableValueFromPreviousSection compare:refinedElementComparableValueFromCurrentSection] < 0),@"The sections are not set correctly.");
		}
		if ([indexedSection count] > 1)
		{
			CPRefinedElement *firstRefinedElementInSection = (CPRefinedElement *)[indexedSection objectAtIndex:0];
			NSNumber *firstRefinedElementComparableValueInSection = [NSNumber numberWithFloat:[firstRefinedElementInSection.comparable floatValue]];
			NSNumber *lastRefinedElementComparableValueInSection = [NSNumber numberWithFloat:[refinedElement.comparable floatValue]];
			STAssertTrue(([firstRefinedElementComparableValueInSection compare:lastRefinedElementComparableValueInSection] <= 0),@"The sorting algorithm isn't applied correctly.");
		}
		refinedElementOfPreviousIndexedSection = refinedElement;
	}
}

#pragma mark - sectionCountAndSetSectionNumberForElementsInArray Test

- (void)testMethod_sectionsCountAndSetSectionNumberForElementsInArray_01;
{
	//setup
	
	//sections include 0,1,2,3,4,5,6,11,12,13,14,200
	NSMutableDictionary *comparableToSectionMapping = [NSMutableDictionary dictionary];
	[comparableToSectionMapping setObject:@"0" forKey:@"0"];
	[comparableToSectionMapping setObject:@"1" forKey:@"1"];
	[comparableToSectionMapping setObject:@"2" forKey:@"2"];
	[comparableToSectionMapping setObject:@"3" forKey:@"3"];
	[comparableToSectionMapping setObject:@"4" forKey:@"4"];
	[comparableToSectionMapping setObject:@"5" forKey:@"5"];
	[comparableToSectionMapping setObject:@"6" forKey:@"6"];
	[comparableToSectionMapping setObject:@"7" forKey:@"11"];
	[comparableToSectionMapping setObject:@"8" forKey:@"12"];
	[comparableToSectionMapping setObject:@"9" forKey:@"13"];
	[comparableToSectionMapping setObject:@"10" forKey:@"14"];
	[comparableToSectionMapping setObject:@"11" forKey:@"200"];
	
	int totalSections = [comparableToSectionMapping count];
	
	[self.listOfRawTestData addObject:@"0.00001"];
	[self.listOfRawTestData addObject:@"0.10000"];
	[self.listOfRawTestData addObject:@"0.21000"];
	[self.listOfRawTestData addObject:@"0.30002"];
	[self.listOfRawTestData addObject:@"0.9"];
	
	[self.listOfRawTestData addObject:@"2.10000"];
	[self.listOfRawTestData addObject:@"2.21000"];
	[self.listOfRawTestData addObject:@"2.30002"];
	[self.listOfRawTestData addObject:@"2.9"];
	
	[self.listOfRawTestData addObject:@"12.00001"];
	[self.listOfRawTestData addObject:@"12.10000"];
	[self.listOfRawTestData addObject:@"12.21000"];
	[self.listOfRawTestData addObject:@"12.30002"];
	[self.listOfRawTestData addObject:@"12.9"];
	
	[self.listOfRawTestData addObject:@"6.00001"];
	[self.listOfRawTestData addObject:@"5.99032"];
	[self.listOfRawTestData addObject:@"4.441000"];
	[self.listOfRawTestData addObject:@"3.00001"];
	[self.listOfRawTestData addObject:@"1.9"];
	
	[self.listOfRawTestData addObject:@"12.00001"];
	[self.listOfRawTestData addObject:@"12.10000"];
	[self.listOfRawTestData addObject:@"12.21000"];
	[self.listOfRawTestData addObject:@"12.30002"];
	[self.listOfRawTestData addObject:@"12.9"];
	
	[self.listOfRawTestData addObject:@"2.9"];
	[self.listOfRawTestData addObject:@"2.30002"];
	[self.listOfRawTestData addObject:@"2.21000"];
	[self.listOfRawTestData addObject:@"2.10000"];
	
	[self.listOfRawTestData addObject:@"11"];
	[self.listOfRawTestData addObject:@"11"];
	[self.listOfRawTestData addObject:@"11"];
	
	[self.listOfRawTestData addObject:@"200"];
	[self.listOfRawTestData addObject:@"14"];
	[self.listOfRawTestData addObject:@"13"];
	[self.listOfRawTestData addObject:@"11"];
	
	int numberOfElements = [self.listOfRawTestData count];
	self.listOfTestInput = [NSMutableArray arrayWithCapacity:numberOfElements];
	
	for (int index = 0; index < numberOfElements; index++)
	{
		[self CP_setupListOfTestInputAtIndex:index];
	}
	
	//method under test
	int calculatedSectionCount = [self.dataIndexer sectionsCountAndSetSectionNumberForElementsInArray:self.listOfTestInput];
	
	//evaluate the outcome
	STAssertTrue((calculatedSectionCount == totalSections),@"The total section calculation is wrong");
	
	int counter = 0;
	for (CPRefinedElement *refinedElement in self.listOfTestInput) 
	{
		NSString *keyToMapping = [NSString stringWithFormat:@"%d",[[self.listOfRawTestData objectAtIndex:counter++] intValue]];
		
		STAssertTrue((refinedElement.sectionNumber == [[comparableToSectionMapping objectForKey:keyToMapping] intValue]),@"The section setting algorithm has an error.");
	}
}

#pragma mark - sortTheElementsInSectionArrayAndAddToArrayOfSections Test

- (void)testMethod_sortTheElementsInSectionArrayAndAddToArrayOfSections_01;
{
	//setup
	[self.listOfRawTestData addObject:@"0.00001"];
	[self.listOfRawTestData addObject:@"0.10000"];
	[self.listOfRawTestData addObject:@"0.20000"];
	[self.listOfRawTestData addObject:@"0.21000"];
	[self.listOfRawTestData addObject:@"0.30000"];
	[self.listOfRawTestData addObject:@"0.30001"];
	[self.listOfRawTestData addObject:@"0.30002"];
	[self.listOfRawTestData addObject:@"0.9"];
	
	NSMutableArray *listOfSortedRawTestDataForEvaluation = [NSMutableArray arrayWithArray:self.listOfRawTestData];
	
	int numberOfElements = [self.listOfRawTestData count];
	self.listOfTestInput = [NSMutableArray arrayWithCapacity:numberOfElements];
	
	//randomize the ordering of the input array.
	int index01 = numberOfElements;
	int randomNumber = 0;
	while (index01 > 0)
	{
		randomNumber = arc4random()%index01--;
		[self CP_setupListOfTestInputAtIndex:randomNumber];
		[self.listOfRawTestData removeObjectAtIndex:randomNumber];
	}
	NSMutableArray *sections = [NSMutableArray array];
	
	//method under tests
	[self.dataIndexer sortTheElementsInSectionArray:self.listOfTestInput andAddToArrayOfSections:sections];
	
	//evaluate the outcome.
	NSArray *sortedSection = [sections lastObject];
	STAssertTrue(([sortedSection isKindOfClass:[NSMutableArray class]]),@"there should be a mutable array in the sections");
	STAssertTrue(([sortedSection count] == numberOfElements),@"The array does not have the correct number of elements.");
	
	int index02 = 0;
	for (CPRefinedElement *element in sortedSection)
	{
		STAssertTrue(([[listOfSortedRawTestDataForEvaluation objectAtIndex:index02++] floatValue] == [element.comparable floatValue]),@"The sorting algorithm is broken.");
	}
}

#pragma mark - Helper method

- (void)CP_setupListOfTestInputAtIndex:(NSInteger)index;
{
	CPRefinedElement *refinedElement = [[CPRefinedElement alloc] init];
	refinedElement.comparable = [self.listOfRawTestData objectAtIndex:index];//use of internal setter.
	[self.listOfTestInput addObject:refinedElement];
	[refinedElement release];
}

@end
