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
- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray andAddToArrayOfSections:(NSMutableArray *)elementSections;

@end

@class CPMostRecentPhotosRefinedElement;

@interface CPMostRecentPhotosDataIndexer : NSObject <CPDataIndexHandlingTemporary>

#pragma mark - Property

@property (retain) CPMostRecentPhotosRefinedElement *refinedElement;

#pragma mark - Intialization

- (id)initWithRefinedElement:(CPMostRecentPhotosRefinedElement *)refinedElement;

@end
