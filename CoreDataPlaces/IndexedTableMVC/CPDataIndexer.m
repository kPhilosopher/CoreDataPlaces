//
//  CPDataIndexer.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPDataIndexer.h"
#import "CPRefinedElement.h"


@implementation CPDataIndexer

#pragma mark - Indexing Sequence

- (NSMutableArray *)indexedSectionsOfRefinedElements:(NSArray *)refinedElements;
{
	NSMutableArray *theElementSections = nil;
	if (refinedElements && refinedElements.count > 0)
	{
		theElementSections = [[[NSMutableArray alloc] init] autorelease];
		NSMutableArray *temporaryDataElements = [NSMutableArray arrayWithArray:refinedElements];
		
		//1. set the sections number for each element
		NSInteger highSection = [self sectionsCountAndSetSectionNumberForElementsInArray:temporaryDataElements];
		
		//2. create the sectionsArray
		NSMutableArray *indexedSections = [NSMutableArray arrayWithCapacity:highSection];
		
		//3. make the empty arrays for each sections.
		for (int i = 0 ; i < highSection; i++)
			[indexedSections addObject:[[[NSMutableArray alloc] initWithCapacity:0] autorelease]];
		
		//4. put elements into its section
		for (CPRefinedElement *element in temporaryDataElements) 
			[(NSMutableArray *)[indexedSections objectAtIndex:element.sectionNumber] addObject:element];
		
		//5. sort the elements within each sections
		for (NSMutableArray *unsortedSection in indexedSections) 
			[self sortTheElementsInSectionArray:unsortedSection andAddToArrayOfSections:theElementSections];
	}
	return theElementSections;
}

#pragma mark - Instance method to be overridden

- (NSInteger)sectionsCountAndSetSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
{
	return 0;
}

- (void)sortTheElementsInSectionArray:(NSMutableArray *)unsortedSection andAddToArrayOfSections:(NSMutableArray *)indexedSections;
{
	return;
}

@end
