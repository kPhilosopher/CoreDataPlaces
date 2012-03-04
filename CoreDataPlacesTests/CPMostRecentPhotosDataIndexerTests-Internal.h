//
//  CPMostRecentPhotosDataIndexerTests-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/1/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

// !!!: Testing using CPMostRecentPhotosRefinedElement

#import "CPMostRecentPhotosDataIndexerTests.h"
#import "CPMostRecentPhotosDataIndexer.h"
#import "CPMostRecentPhotosRefinedElement.h"


@interface CPMostRecentPhotosDataIndexerTests()

#pragma mark - Property

@property (retain) CPMostRecentPhotosDataIndexer *dataIndexer;
@property (retain) NSMutableArray *listOfRawTestData;
@property (retain) NSMutableArray *listOfTestInput;

#pragma mark - Helper method

- (void)CP_setupListOfRefinedElementWithIndex:(NSInteger)index;

@end