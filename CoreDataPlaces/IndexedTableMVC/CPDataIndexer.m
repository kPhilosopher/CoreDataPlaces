//
//  CPDataIndexer.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import "CPDataIndexer.h"

@interface CPDataIndexer ()
{
@private
	CPRefinedElement *CP_refinedElement;
}

@end

@implementation CPDataIndexer

#pragma mark - Synthesize

@synthesize refinedElement = CP_refinedElement;

#pragma mark - Initlization

- (id)initWithRefinedElement:(CPRefinedElement *)refinedElement;
{
	self = [self init];
	if (self) {
		self.refinedElement = refinedElement;
	}
	return self;
}

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_refinedElement release];
	[super dealloc];
}

#pragma mark - Indexing Sequence
//TODO: Refactor this method.
- (NSMutableArray *)indexedSectionsOfTheRawElementsArray:(NSArray *)rawElements;
{
	NSMutableArray *theElementSections = [[NSMutableArray alloc] init];
	NSMutableArray *temporaryDataElements;
	
	//1. refinement process
	if (rawElements)//TODO: this might work if && ([rawData count] > 0) will allow efficiency do this by filtering alert message with count of the array returned.
	{
		temporaryDataElements = [[NSMutableArray alloc] initWithCapacity:1];
		for (NSDictionary *rawElement in rawElements) 
			[self refineTheRawElementDictionary:rawElement thenAddToTemporaryMutableArray:temporaryDataElements];
	}
	else
		return nil;
	
	//2. set the sections number for each element
	[self setSectionNumberForElementsInArray:temporaryDataElements];

	
	//3. create the sectionsArray
	NSInteger highSection = [self sectionCount];
	NSMutableArray *sectionArrays = [[NSMutableArray alloc]initWithCapacity:highSection];
	
	//4. make the empty arrays for each sections.
	for (int i = 0 ; i < highSection; i++) 
		[sectionArrays addObject:[[NSMutableArray alloc] initWithCapacity:0]];

	//5. put elements into its section
	for (CPRefinedElement *element in temporaryDataElements) 
		[(NSMutableArray *)[sectionArrays objectAtIndex:element.sectionNumber] addObject:element];
	
	//6. sort the elements within each sections
	for (NSMutableArray *sectionArray in sectionArrays) 
		[self sortTheElementsInSectionArray:sectionArray thenAddToArrayOfSections:theElementSections];
	return theElementSections;
}

- (void)refineTheRawElementDictionary:(NSDictionary *)rawElement thenAddToTemporaryMutableArray:(NSMutableArray *)temporaryDataElements;
{
	CPRefinedElement *refinedElement = [self.refinedElement copy];
	refinedElement.comparable = [refinedElement extractComparableFromDictionary:rawElement];
	refinedElement.dictionary = rawElement;
	[temporaryDataElements addObject:refinedElement];
	[refinedElement release];
}

#pragma mark - Instance method to be overridden

- (void)setSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
{
	return;
}

- (NSInteger)sectionCount;
{
	return 0;
}

- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray thenAddToArrayOfSections:(NSMutableArray *)elementSections;
{
	return;
}

@end
