//
//  CPPlacesDataIndexerWithPlacesRefinedElementTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/25/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPlacesDataIndexerWithPlacesRefinedElementTests.h"
#import "CPPlacesRefinedElement.h"

@interface CPPlacesDataIndexerWithPlacesRefinedElementTests ()
{
@private
	CPPlacesDataIndexer *CP_placesDataIndexer;
}
@end

#pragma mark -

@implementation CPPlacesDataIndexerWithPlacesRefinedElementTests

#pragma mark - Synthesize

@synthesize placesDataIndexer = CP_placesDataIndexer;

- (void)setUp;
{
    [super setUp];
	self.placesDataIndexer = [[[CPPlacesDataIndexer alloc] init] autorelease];
}

- (void)tearDown;
{
	self.placesDataIndexer = nil;
    [super tearDown];
}

//TODO: implement these tests
//TODO: change the names of the tests to fit the changing method names.
- (void)test_refineTheRawElementDictionaryThenAddToTemporaryMutableArray;
{
	
}

- (void)test_setSectionNumberForElementsInArray;
{
	
}

- (void)test_sectionCount;
{
	
}

- (void)test_sortTheElementsInSectionArrayAndAddToArrayOfSections;
{
	
}

- (void)test_indexedSectionsOfTheRawElementsArray_withData;
{
	
	NSMutableArray *testData = [[NSMutableArray alloc] init];
	
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"South Park", @"_content", nil]];
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Seattle", @"_content", nil]];
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Beirut", @"_content", nil]];
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"8Baghdad", @"_content", nil]];
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"London", @"_content", nil]];
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Seoul", @"_content", nil]];
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Cairo", @"_content", nil]];
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Hong Kong", @"_content", nil]];
	[testData addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Cairo", @"_content", nil]];
	
	NSArray *theElementSections = [self.placesDataIndexer indexedSectionsOfTheRawElementsArray:testData];
	
	STAssertTrue(([theElementSections count] == 27),@"The element sections array does not have the correct number of sections.");
	
	//A (empty section)
	STAssertTrue(([[theElementSections objectAtIndex:0] count] == 0),@"the section with A should not have any elements in it.");
	
	//B (existance of certain object)
	STAssertTrue(([[theElementSections objectAtIndex:1] count] == 1),@"The B section's member count is off");
	CPRefinedElement *elementForB = (CPRefinedElement *)[[theElementSections objectAtIndex:1] objectAtIndex:0];
	STAssertTrue([elementForB.comparable isEqualToString:@"Beirut"],@"The B section does not have the Beirut dictionary _content");
	STAssertTrue((elementForB.sectionNumber == 1),@"The section number of the element is not correct");
	
	//C (duplicate)
	CPRefinedElement *elementForC_01 = (CPRefinedElement *)[[theElementSections objectAtIndex:2] objectAtIndex:0];
	CPRefinedElement *elementForC_02 = (CPRefinedElement *)[[theElementSections objectAtIndex:2] objectAtIndex:1];
	STAssertTrue([elementForC_01.comparable isEqualToString:elementForC_02.comparable],@"The two elements in the C section does not have the same string sequence.");
	STAssertTrue(([[theElementSections objectAtIndex:2] count] == 2),@"The C section does not have the correct number of sections.");
	
	//S (ordering)
	CPRefinedElement *elementForS_01 = (CPRefinedElement *)[[theElementSections objectAtIndex:18] objectAtIndex:0];
	CPRefinedElement *elementForS_02 = (CPRefinedElement *)[[theElementSections objectAtIndex:18] objectAtIndex:1];
	CPRefinedElement *elementForS_03 = (CPRefinedElement *)[[theElementSections objectAtIndex:18] objectAtIndex:2];
	STAssertTrue([elementForS_01.comparable isEqualToString:@"Seattle"], @"The first element in the S section is not 'Seattle'");
	STAssertTrue([elementForS_02.comparable isEqualToString:@"Seoul"], @"The second element in the S section is not 'Seoul'");
	STAssertTrue([elementForS_03.comparable isEqualToString:@"South Park"], @"The third element in the S section is not 'South Park'");
	
	//#
	STAssertTrue(([[theElementSections objectAtIndex:26] count] == 1),@"The # section's member count is off");
	CPRefinedElement *elementForSharp = (CPRefinedElement *)[[theElementSections objectAtIndex:26] objectAtIndex:0];
	STAssertTrue([elementForSharp.comparable isEqualToString:@"8Baghdad"],@"The # section element is incorrect");
	
	[testData release];
}

- (void)test_indexedSectionsOfTheRawElementsArray_nilData
{
	NSArray *theElementSectionsWithNilData = [self.placesDataIndexer indexedSectionsOfTheRawElementsArray:nil];
	STAssertNil((theElementSectionsWithNilData),@"The element sections array should be nil");
}

- (void)test_indexedSectionsOfTheRawElementsArray_emptyData
{
	NSArray *emptyArray = [[NSArray alloc] init];
	NSArray *theElementSectionsWithEmptyData = [self.placesDataIndexer indexedSectionsOfTheRawElementsArray:emptyArray];
	STAssertTrue(([theElementSectionsWithEmptyData count] == 27),@"The element sections should have empty sections.");
	STAssertTrue([[theElementSectionsWithEmptyData objectAtIndex:0] count] == 0,@"The first section of the empty section should be empty");
	[emptyArray release];
}

@end
