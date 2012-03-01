//
//  CPMostRecentPhotosDataIndexer.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosDataIndexer.h"
#import "CPMostRecentPhotosRefinedElement.h"
#import "JBBPriorityQueue.h"


@interface CPMostRecentPhotosDataIndexer ()
{
@private
	CPMostRecentPhotosRefinedElement *CP_refinedElement;
	NSInteger CP_highSection;
}
@end

#pragma mark -

@implementation CPMostRecentPhotosDataIndexer

#pragma mark - Synthesize

@synthesize highSection = CP_highSection;
@synthesize refinedElement = CP_refinedElement;

#pragma mark - Object lifecycle

- (void)dealloc
{
	[CP_refinedElement release];
	[super dealloc];
}

#pragma mark - Intialization

- (id)initWithRefinedElement:(CPMostRecentPhotosRefinedElement *)refinedElement;
{
	self = [super init];
	if (self)
	{
		self.refinedElement = refinedElement;
	}
	return self;
}

#pragma mark - CPDataIndexHandling protocol methods

- (NSMutableArray *)indexedSectionsOfTheRawElementsArray:(NSArray *)rawElements;
{
	
	return nil;
}

- (void)refineTheRawElement:(id)rawElement thenAddToTemporaryMutableArray:(NSMutableArray *)temporaryDataElements;
{
	
}

- (void)setSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
{
//	NSMutableSet *setOfHours = [NSMutableSet set];
//	self.highSection = 0;
//	for (CPPhotosRefinedElement *refinedElement in temporaryDataElements) 
//	{
//		[setOfHours addObject:[NSNumber numberWithInt:[refinedElement.comparable intValue]]];
//	}
//	JBBPriorityQueue *priorityQueue = [[JBBPriorityQueue alloc] initWithClass:[NSNumber class] ordering:NSOrderedAscending];
//	for (NSNumber *number in setOfHours) 
//	{
//		[priorityQueue addObject:number];
//	}
//	self.highSection = [priorityQueue count];
//	NSMutableArray *copiedArray = [NSMutableArray arrayWithArray:temporaryDataElements];
//	for (int indexForSections = 0; indexForSections < self.highSection; indexForSections++) 
//	{
//		NSNumber *temporaryHourNumber = [priorityQueue removeFirstObject];
//		
//		for (int indexForEachElement = 0; indexForEachElement < [copiedArray count]; indexForEachElement++) 
//		{
//			CPPhotosRefinedElement *refinedElement = [copiedArray objectAtIndex:indexForEachElement];
//			if ([temporaryHourNumber intValue] == [refinedElement.comparable intValue])
//			{
//				refinedElement.sectionNumber = indexForSections;
//				[copiedArray removeObjectAtIndex:indexForEachElement];
//				indexForEachElement = indexForEachElement - 1;
//			}
//			
//		}
//	}
//	[priorityQueue release];
}

- (NSInteger)sectionCount;
{
	return 0;
//	return self.highSection;
}

- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray andAddToArrayOfSections:(NSMutableArray *)elementSections;
{
	NSMutableArray *temporarySection = [NSMutableArray arrayWithCapacity:[sectionArray count]];
	id element = [sectionArray lastObject];
	JBBPriorityQueue *priorityQueue = [[JBBPriorityQueue alloc] initWithClass:[element class] ordering:NSOrderedAscending];
	for (id refinedElement in sectionArray)
		[priorityQueue addObject:refinedElement];
	int upperLimit = [priorityQueue count];
	for (int index = 0; index < upperLimit; index++) 
		[temporarySection addObject:[priorityQueue removeFirstObject]];
	[elementSections addObject:temporarySection];
	[priorityQueue release];
}

@end
