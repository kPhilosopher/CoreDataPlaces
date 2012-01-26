//
//  CPPlacesDataIndexer.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import "CPPlacesDataIndexer.h"
#import "CPPlacesRefinedElement.h"

@implementation CPPlacesDataIndexer

#pragma mark - Initialization

- (id)init;
{
	self = [super init];
	if (self) {
		self.refinedElement = [[[CPPlacesRefinedElement alloc] init] autorelease];
	}
	return self;
}

#pragma mark - Methods to override

- (void)refineTheRawElementDictionary:(NSDictionary *)rawElement thenAddToTemporaryMutableArray:(NSMutableArray *)temporaryDataElements
{
	CPPlacesRefinedElement *refinedElement = [self.refinedElement copy];
	refinedElement.comparable = [refinedElement extractComparableFromDictionary:rawElement];
	refinedElement.dictionary = rawElement;
	[temporaryDataElements addObject:refinedElement];
	[refinedElement release];
}
//
//- (void)setTheSectionNumberForEach:(CPRefinedElement *)refinedElement
//{
//	refinedElement.sectionNumber = [[UILocalizedIndexedCollation currentCollation] sectionForObject:refinedElement collationStringSelector:@selector(comparable)];
//}

- (void)setSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
{
	for (CPRefinedElement *refinedElement in temporaryDataElements)
	{
		refinedElement.sectionNumber = [[UILocalizedIndexedCollation currentCollation] sectionForObject:refinedElement collationStringSelector:@selector(comparable)];
	}
//		[self setTheSectionNumberForEach:refinedElement];
}

- (NSInteger)setSectionCount
{
	return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
}

- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray thenAddToArrayOfSections:(NSMutableArray *)elementSections;
{
	NSArray *sortedSection = [[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:sectionArray collationStringSelector:@selector(comparable)];
	[elementSections addObject:sortedSection];
}

@end
