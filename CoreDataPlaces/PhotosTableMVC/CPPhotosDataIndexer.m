//
//  CPPhotosDataIndexer.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//

#import "CPPhotosDataIndexer.h"

@interface CPPhotosDataIndexer ()
{
@private
	NSInteger CP_highSection;
}
@end

#pragma mark -

@implementation CPPhotosDataIndexer

#pragma mark - Synthesize

@synthesize highSection = CP_highSection;

#pragma mark - Initialization

- (id)init;
{
	self = [super init];
	if (self) {
		self.refinedElement = [[[CPPhotosRefinedElement alloc] init] autorelease];
	}
	return self;
}

#pragma mark - Instance method to override

- (void)setSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
{
	NSMutableSet *setOfHours = [NSMutableSet set];
	self.highSection = 0;
	for (CPPhotosRefinedElement *refinedElement in temporaryDataElements) 
	{
		[setOfHours addObject:[NSNumber numberWithInt:[refinedElement.comparable intValue]]];
	}
	JBBPriorityQueue *priorityQueue = [[JBBPriorityQueue alloc] initWithClass:[NSNumber class] ordering:NSOrderedAscending];
	for (NSNumber *number in setOfHours) 
	{
		[priorityQueue addObject:number];
	}
	self.highSection = [priorityQueue count];
	NSMutableArray *copiedArray = [NSMutableArray arrayWithArray:temporaryDataElements];
	for (int indexForSections = 0; indexForSections < self.highSection; indexForSections++) 
	{
		NSNumber *temporaryHourNumber = [priorityQueue removeFirstObject];

		for (int indexForEachElement = 0; indexForEachElement < [copiedArray count]; indexForEachElement++) 
		{
			CPPhotosRefinedElement *refinedElement = [copiedArray objectAtIndex:indexForEachElement];
			if ([temporaryHourNumber intValue] == [refinedElement.comparable intValue])
			{
				refinedElement.sectionNumber = indexForSections;
				[copiedArray removeObjectAtIndex:indexForEachElement];
				indexForEachElement = indexForEachElement - 1;
			}
			
		}
	}
	[priorityQueue release];
}

- (NSInteger)sectionCount;
{
	return self.highSection;
}

- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray thenAddToArrayOfSections:(NSMutableArray *)elementSections;
{
	NSMutableArray *temporarySection = [NSMutableArray arrayWithCapacity:[sectionArray count]];
	JBBPriorityQueue *priorityQueue = [[JBBPriorityQueue alloc] initWithClass:[CPPhotosRefinedElement class] ordering:NSOrderedAscending];
	for (CPPhotosRefinedElement *refinedElement in sectionArray)
		[priorityQueue addObject:refinedElement];
	int upperLimit = [priorityQueue count];
	for (int index = 0; index < upperLimit; index++) 
		[temporarySection addObject:[priorityQueue removeFirstObject]];
	[elementSections addObject:temporarySection];
	[priorityQueue release];
}

@end
