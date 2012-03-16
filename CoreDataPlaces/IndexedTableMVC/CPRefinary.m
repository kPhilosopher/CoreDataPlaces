//
//  CPRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/13/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
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
		[refinedElements addObject:temporaryRefinedElement];
		[temporaryRefinedElement release];
	}
	return refinedElements;
}

- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	
}

- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
{
	
}

@end
