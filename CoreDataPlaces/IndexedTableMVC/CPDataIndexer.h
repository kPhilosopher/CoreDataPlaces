//
//  CPDataIndexer.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

// !!!:This is an abstract class. It must be subclassed with appropriate implementation.

#import <Foundation/Foundation.h>


@interface CPDataIndexer : NSObject

- (NSMutableArray *)indexedSectionsOfRefinedElements:(NSArray *)refinedElements;
- (NSInteger)sectionsCountAndSetSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
- (void)sortTheElementsInSectionArray:(NSMutableArray *)unsortedSection andAddToArrayOfSections:(NSMutableArray *)indexedSections;

@end
