//
//  CPTopPlacesDataIndexer.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPTopPlacesDataIndexer.h"
#import "CPRefinedElement.h"


@implementation CPTopPlacesDataIndexer

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
