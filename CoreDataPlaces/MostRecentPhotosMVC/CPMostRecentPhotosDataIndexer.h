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
- (NSMutableArray *)indexedSectionsOfTheRawElementsArray:(NSArray *)rawElements;
- (void)refineTheRawElement:(id)rawElement thenAddToTemporaryMutableArray:(NSMutableArray *)temporaryDataElements;
- (void)setSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
- (NSInteger)sectionCount;
- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray andAddToArrayOfSections:(NSMutableArray *)elementSections;

@end

@class CPMostRecentPhotosRefinedElement;

@interface CPMostRecentPhotosDataIndexer : NSObject <CPDataIndexHandlingTemporary>

#pragma mark - Property

@property (retain) CPMostRecentPhotosRefinedElement *refinedElement;
@property NSInteger highSection;

#pragma mark - Intialization

- (id)initWithRefinedElement:(CPMostRecentPhotosRefinedElement *)refinedElement;

@end
