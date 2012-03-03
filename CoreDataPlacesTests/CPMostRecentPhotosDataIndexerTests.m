//
//  CPMostRecentPhotosDataIndexerTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/29/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

// !!!: Testing using CPMostRecentPhotosRefinedElement

#import "CPMostRecentPhotosDataIndexerTests-Internal.h"
#import "CPPhotosRefinedElement.h"
#import "Photo.h"


@interface CPMostRecentPhotosDataIndexerTests()
{
	CPMostRecentPhotosDataIndexer *CP_dataIndexer;
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
	CPMostRecentPhotosRefinedElement *refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	self.dataIndexer = [[[CPMostRecentPhotosDataIndexer alloc] initWithRefinedElement:refinedElement] autorelease];
	[refinedElement release];
	self.listOfRawTestData = [NSMutableArray array];
}

- (void)tearDown;
{
	self.dataIndexer = nil;
	self.listOfRawTestData = nil;
	self.listOfTestInput = nil;
}

#pragma mark - sectionCountAndSetSectionNumberForElementsInArray Test

- (void)testMethod_sectionsCountAndSetSectionNumberForElementsInArray_01;
{
	//setup
	int totalSections = 12;
	
	//sections include 0,1,2,3,4,5,6,11,12,13,14,200
	NSMutableDictionary *comparableToSection = [NSMutableDictionary dictionary];
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
		[self CP_setupListOfTestInputWithIndex:index];
	}
	
	//method under test
	int calculatedSectionCount = [self.dataIndexer sectionsCountAndSetSectionNumberForElementsInArray:self.listOfTestInput];
	
	//evaluate the outcome
	STAssertTrue((calculatedSectionCount == totalSections),@"The total section calculation is wrong");
	
	int counter = 0;
	for (CPMostRecentPhotosRefinedElement *refinedElement in self.listOfTestInput) 
	{
		NSString *integerOfTestDataComparable = [NSString stringWithFormat:@"%d",[[self.listOfRawTestData objectAtIndex:counter++] intValue]];
		
		STAssertTrue((refinedElement.sectionNumber == [[comparableToSection objectForKey:integerOfTestDataComparable] intValue]),@"The section setting algorithm has an error.");
	}
}

#pragma mark - sortTheElementsInSectionArrayAndAddToArrayOfSections Test

- (void)testMethod_sortTheElementsInSectionArrayAndAddToArrayOfSections_01;
{
	//setup]
	[self.listOfRawTestData addObject:@"0.00001"];
	[self.listOfRawTestData addObject:@"0.10000"];
	[self.listOfRawTestData addObject:@"0.20000"];
	[self.listOfRawTestData addObject:@"0.21000"];
	[self.listOfRawTestData addObject:@"0.30000"];
	[self.listOfRawTestData addObject:@"0.30001"];
	[self.listOfRawTestData addObject:@"0.30002"];
	[self.listOfRawTestData addObject:@"0.9"];
	
	NSMutableArray *listOfRawTestDataForEvaluation = [NSMutableArray arrayWithArray:self.listOfRawTestData];
	
	int numberOfElements = [self.listOfRawTestData count];
	self.listOfTestInput = [NSMutableArray arrayWithCapacity:numberOfElements];
	
	int count = numberOfElements;
	int randomNumber = 0;
	while (count > 0)
	{
		randomNumber = arc4random()%count;
		[self CP_setupListOfTestInputWithIndex:randomNumber];
		[self.listOfRawTestData removeObjectAtIndex:randomNumber];
		count = count - 1;
	}
	NSMutableArray *sectionsOfArray = [NSMutableArray array];
	
	//method under tests
	[self.dataIndexer sortTheElementsInSectionArray:self.listOfTestInput andAddToArrayOfSections:sectionsOfArray];
	
	//evaluate the outcomes
	STAssertTrue(([[sectionsOfArray lastObject] isKindOfClass:[NSMutableArray class]]),@"there should be a mutable array in the arrayOfSections");
	
	int indexCount = 0;
	for (CPMostRecentPhotosRefinedElement *element in [sectionsOfArray lastObject])
	{
		STAssertTrue(([[sectionsOfArray lastObject] count] == numberOfElements),@"The array does not have the correct number of elements.");
		STAssertTrue(([[listOfRawTestDataForEvaluation objectAtIndex:indexCount] floatValue] == [element.comparable floatValue]),@"The sorting algorithm isn't broken.");
		indexCount = indexCount + 1;
	}
}

#pragma mark - Helper method

- (void)CP_setupListOfTestInputWithIndex:(NSInteger)index;
{
	CPMostRecentPhotosRefinedElement *refinedElement = [[CPMostRecentPhotosRefinedElement alloc] init];
	refinedElement.comparable = [self.listOfRawTestData objectAtIndex:index];//use of internal setter.
	[self.listOfTestInput addObject:refinedElement];
	[refinedElement release];
}

@end
