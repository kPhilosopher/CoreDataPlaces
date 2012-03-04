//
//  CPMostRecentPhotosDataIndexer.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

//#import "CPDataIndexer.h"
#import <Foundation/Foundation.h>


@protocol CPDataIndexHandlingTemporary <NSObject>

#pragma mark - Required methods

@required
- (NSMutableArray *)indexedSectionsOfRefinedElements:(NSArray *)refinedElements;
- (NSInteger)sectionsCountAndSetSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
- (void)sortTheElementsInSectionArray:(NSMutableArray *)unsortedSection andAddToArrayOfSections:(NSMutableArray *)indexedSections;

@end

#pragma mark -

@interface CPMostRecentPhotosDataIndexer : NSObject <CPDataIndexHandlingTemporary>

@end
