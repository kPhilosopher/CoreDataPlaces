//
//  CPMostRecentPhotosDataIndexerTests-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

// !!!: Testing using CPMostRecentPhotosRefinedElement

#import "CPMostRecentPhotosDataIndexerTests.h"
#import "CPMostRecentPhotosDataIndexer.h"


@interface CPMostRecentPhotosDataIndexerTests()

#pragma mark - Property

@property (retain) CPMostRecentPhotosDataIndexer *dataIndexer;
@property (retain) NSMutableArray *listOfRawTestData;
@property (retain) NSMutableArray *listOfTestInput;

#pragma mark - Helper method

- (void)CP_setupListOfTestInputAtIndex:(NSInteger)index;

@end