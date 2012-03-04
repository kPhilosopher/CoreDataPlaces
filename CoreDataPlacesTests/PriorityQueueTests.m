//
//  PriorityQueueTests.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/30/11.
//  Copyright (c) 2011 Jinwoo Baek. All rights reserved.
//

#import "PriorityQueueTests.h"

@implementation PriorityQueueTests

- (void)setUp
{
	
}

- (void)tearDown
{
	
}

- (void)testAscendingPriorityQueue
{
	JBBPriorityQueue *ascendingPriority = [[JBBPriorityQueue alloc] initWithClass:[NSNumber class] ordering:NSOrderedAscending];
	[ascendingPriority addObject:[NSNumber numberWithInt:8]];
	[ascendingPriority addObject:[NSNumber numberWithInt:3]];
	[ascendingPriority addObject:[NSNumber numberWithInt:5]];
	[ascendingPriority addObject:[NSNumber numberWithInt:6]];
	[ascendingPriority addObject:[NSNumber numberWithInt:9]];
	[ascendingPriority addObject:[NSNumber numberWithInt:2]];
	[ascendingPriority addObject:[NSNumber numberWithInt:1]];
	[ascendingPriority addObject:[NSNumber numberWithInt:10]];
	
	STAssertTrue(([[ascendingPriority removeFirstObject] intValue] == 1),@"");
	STAssertTrue(([[ascendingPriority removeFirstObject] intValue] == 2),@"");
	STAssertTrue(([[ascendingPriority removeFirstObject] intValue] == 3),@"");
	STAssertTrue(([[ascendingPriority removeFirstObject] intValue] == 5),@"");
	STAssertTrue(([[ascendingPriority removeFirstObject] intValue] == 6),@"");
	STAssertTrue(([[ascendingPriority removeFirstObject] intValue] == 8),@"");
	STAssertTrue(([[ascendingPriority removeFirstObject] intValue] == 9),@"");
	STAssertTrue(([[ascendingPriority removeFirstObject] intValue] == 10),@"");
}

- (void)testDescendingPriorityQueue
{
	JBBPriorityQueue *descendingPriority = [[JBBPriorityQueue alloc] initWithClass:[NSNumber class] ordering:NSOrderedDescending];
	[descendingPriority addObject:[NSNumber numberWithInt:8]];
	[descendingPriority addObject:[NSNumber numberWithInt:3]];
	[descendingPriority addObject:[NSNumber numberWithInt:5]];
	[descendingPriority addObject:[NSNumber numberWithInt:6]];
	[descendingPriority addObject:[NSNumber numberWithInt:9]];
	[descendingPriority addObject:[NSNumber numberWithInt:2]];
	[descendingPriority addObject:[NSNumber numberWithInt:1]];
	[descendingPriority addObject:[NSNumber numberWithInt:10]];
	
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 10),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 9),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 8),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 6),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 5),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 3),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 2),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 1),@"");
}

- (void)testDuplicates
{
	JBBPriorityQueue *descendingPriority = [[JBBPriorityQueue alloc] initWithClass:[NSNumber class] ordering:NSOrderedDescending];
	[descendingPriority addObject:[NSNumber numberWithInt:8]];
	[descendingPriority addObject:[NSNumber numberWithInt:3]];
	[descendingPriority addObject:[NSNumber numberWithInt:8]];
	
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 8),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 8),@"");
	STAssertTrue(([[descendingPriority removeFirstObject] intValue] == 3),@"");
}

@end
