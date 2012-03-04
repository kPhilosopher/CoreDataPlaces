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


@implementation CPMostRecentPhotosDataIndexer

#pragma mark - CPDataIndexHandling protocol methods

- (NSMutableArray *)indexedSectionsOfRefinedElements:(NSArray *)refinedElements;
{
	NSMutableArray *theElementSections = [[[NSMutableArray alloc] init] autorelease];
	NSMutableArray *temporaryDataElements = [NSMutableArray arrayWithArray:refinedElements];
	
	//TODO: in the controller that calls the refinary, the raw elements should be checked to not be nil and have at least one element in it.
	//1. set the sections number for each element
	NSInteger highSection = [self sectionsCountAndSetSectionNumberForElementsInArray:temporaryDataElements];
	
	//2. create the sectionsArray
	NSMutableArray *indexedSections = [NSMutableArray arrayWithCapacity:highSection];
	
	//3. make the empty arrays for each sections.
	for (int i = 0 ; i < highSection; i++)
		[indexedSections addObject:[[[NSMutableArray alloc] initWithCapacity:0] autorelease]];
	
	//4. put elements into its section
	for (CPMostRecentPhotosRefinedElement *element in temporaryDataElements) 
		[(NSMutableArray *)[indexedSections objectAtIndex:element.sectionNumber] addObject:element];
	
	//5. sort the elements within each sections
	for (NSMutableArray *unsortedSection in indexedSections) 
		[self sortTheElementsInSectionArray:unsortedSection andAddToArrayOfSections:theElementSections];
	
	return theElementSections;
}

- (NSInteger)sectionsCountAndSetSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
{
	NSInteger highSection = 0;

	//eliminate duplicates using NSSet.
	NSMutableSet *setOfHours = [NSMutableSet set];
	for (CPMostRecentPhotosRefinedElement *refinedElement in temporaryDataElements) 
	{
		[setOfHours addObject:[NSNumber numberWithInt:[refinedElement.comparable intValue]]];
	}
	
	//find the ordering of the numbers using priority queue.
	JBBPriorityQueue *priorityQueue = [[JBBPriorityQueue alloc] initWithClass:[NSNumber class] ordering:NSOrderedAscending];
	for (NSNumber *number in setOfHours) 
		[priorityQueue addObject:number];
	
	
	//map the ordering to a sequential number for array.
	highSection = [priorityQueue count];
	NSMutableDictionary *sectionNumberMapping = [NSMutableDictionary dictionaryWithCapacity:highSection];
	for (int sectionNumber = 0; sectionNumber < highSection; sectionNumber++)
	{
		NSNumber *comparableValue = [priorityQueue removeFirstObject];
		NSString *comparableIntAsKey = [NSString stringWithFormat:@"%d",[comparableValue intValue]];
		[sectionNumberMapping setObject:[NSString stringWithFormat:@"%d",sectionNumber] forKey:comparableIntAsKey];
	}
	
	//set the sections numbers for each element.
	for (CPMostRecentPhotosRefinedElement *refinedElement in temporaryDataElements)
	{
		NSString *key = [NSString stringWithFormat:@"%d",[refinedElement.comparable intValue]];
		refinedElement.sectionNumber = [[sectionNumberMapping objectForKey:key] intValue];
	}
	[priorityQueue release];
	return highSection;
}

- (void)sortTheElementsInSectionArray:(NSMutableArray *)unsortedSection andAddToArrayOfSections:(NSMutableArray *)indexedSections;
{
	//setup the priority queue.
	id element = [unsortedSection lastObject];
	JBBPriorityQueue *priorityQueue = [[JBBPriorityQueue alloc] initWithClass:[element class] ordering:NSOrderedAscending];
	
	//load the priority queue with the refined elements.
	for (CPMostRecentPhotosRefinedElement *refinedElement in unsortedSection)
		[priorityQueue addObject:refinedElement];
	
	//place the sorted elements into an array.
	int upperLimit = [priorityQueue count];
	NSMutableArray *sortedSection = [NSMutableArray arrayWithCapacity:upperLimit];
	for (int index = 0; index < upperLimit; index++) 
		[sortedSection addObject:[priorityQueue removeFirstObject]];
	
	//add the sorted sections in the array of sections.
	[indexedSections addObject:sortedSection];
	
	//clean up
	[priorityQueue release];
}

@end
