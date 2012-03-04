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
}
@end

#pragma mark -

@implementation CPMostRecentPhotosDataIndexer

#pragma mark - Synthesize

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

- (NSMutableArray *)indexedSectionsOfRefinedElements:(NSArray *)refinedElements;
{
	NSMutableArray *theElementSections = [[[NSMutableArray alloc] init] autorelease];
	NSMutableArray *temporaryDataElements = [NSMutableArray arrayWithArray:refinedElements];
	
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
	
	//TODO:refactor the variable names.
	for (NSMutableArray *sectionArray in indexedSections) 
		[self sortTheElementsInSectionArray:sectionArray andAddToArrayOfSections:theElementSections];
	
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
	{
		[priorityQueue addObject:number];
	}
	highSection = [priorityQueue count];
	
	//map the ordering to a sequential number for array.
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

- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray andAddToArrayOfSections:(NSMutableArray *)elementSections;
{
	NSMutableArray *sortedSection = [NSMutableArray arrayWithCapacity:[sectionArray count]];
	id element = [sectionArray lastObject];
	JBBPriorityQueue *priorityQueue = [[JBBPriorityQueue alloc] initWithClass:[element class] ordering:NSOrderedAscending];
	for (CPMostRecentPhotosRefinedElement *refinedElement in sectionArray)
		[priorityQueue addObject:refinedElement];
	int upperLimit = [priorityQueue count];
	for (int index = 0; index < upperLimit; index++) 
		[sortedSection addObject:[priorityQueue removeFirstObject]];
	[elementSections addObject:sortedSection];
	[priorityQueue release];
}

@end
