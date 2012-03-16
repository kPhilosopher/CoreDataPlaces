//
//  CPDataIndexing.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/13/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CPDataIndexing <NSObject>

#pragma mark - Required methods

@required
- (NSMutableArray *)indexedSectionsOfRefinedElements:(NSArray *)refinedElements;
- (NSInteger)sectionsCountAndSetSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
- (void)sortTheElementsInSectionArray:(NSMutableArray *)unsortedSection andAddToArrayOfSections:(NSMutableArray *)indexedSections;

@end
