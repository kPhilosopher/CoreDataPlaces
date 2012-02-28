//
//  CPPlacesDataIndexer.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPlacesDataIndexer.h"
#import "CPPlacesRefinedElement.h"


@implementation CPPlacesDataIndexer

#pragma mark - Instance method to override

- (void)setSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
{
	for (CPRefinedElement *refinedElement in temporaryDataElements)
	{
		refinedElement.sectionNumber = [[UILocalizedIndexedCollation currentCollation] sectionForObject:refinedElement collationStringSelector:@selector(comparable)];
	}
}

- (NSInteger)sectionCount
{
	return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
}

- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray andAddToArrayOfSections:(NSMutableArray *)elementSections;
{
	NSArray *sortedSection = [[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:sectionArray collationStringSelector:@selector(comparable)];
	[elementSections addObject:sortedSection];
}

@end
