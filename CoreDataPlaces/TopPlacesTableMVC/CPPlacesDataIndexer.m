//
//  CPTopPlacesDataIndexer.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/14/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPlacesDataIndexer.h"
#import "CPRefinedElement.h"


@implementation CPPlacesDataIndexer

#pragma mark - Overriding method

- (NSInteger)sectionsCountAndSetSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
{
	for (CPRefinedElement *refinedElement in temporaryDataElements)
	{
		refinedElement.sectionNumber = [[UILocalizedIndexedCollation currentCollation] sectionForObject:refinedElement collationStringSelector:@selector(comparable)];
	}
	return [[[UILocalizedIndexedCollation currentCollation] sectionTitles] count];
}

- (void)sortTheElementsInSectionArray:(NSMutableArray *)unsortedSection andAddToArrayOfSections:(NSMutableArray *)indexedSections;
{
	NSArray *sortedSection = [[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:unsortedSection collationStringSelector:@selector(comparable)];
	[indexedSections addObject:sortedSection];
}

@end
