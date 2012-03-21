//
//  CPRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/13/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPRefinary.h"
#import "CPRefinedElement.h"


@implementation CPRefinary

#pragma mark - Instance method

- (NSArray *)refinedElementsWithGivenRefinedElementType:(CPRefinedElement *)refinedElement rawElements:(NSArray *)rawElements;
{
	NSMutableArray *refinedElements = [NSMutableArray arrayWithCapacity:[rawElements count]];
	for (id rawElement in rawElements)
	{
		CPRefinedElement *temporaryRefinedElement = [refinedElement copy];
		temporaryRefinedElement.rawElement = rawElement;
		[self setComparableForRefinedElement:temporaryRefinedElement];
		[self setTitleAndSubtitleForRefinedElement:temporaryRefinedElement];
		[self setCustomPropertiesForRefinedElement:temporaryRefinedElement];
		[refinedElements addObject:temporaryRefinedElement];
		[temporaryRefinedElement release];
	}
	return refinedElements;
}

#pragma mark - Instance method to be overridden

- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	
}

- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
{
	
}

- (void)setCustomPropertiesForRefinedElement:(CPRefinedElement *)refinedElement;
{
	
}

@end
