//
//  CPDataIndexer.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CPRefinedElement.h"


@class CPRefinedElement;

@protocol CPDataIndexHandling <NSObject>

#pragma mark - Methods

//- (NSMutableArray *)returnTheIndexedSectionsOfTheGiven:(NSArray *)rawData;
- (NSMutableArray *)indexedSectionsOfTheRawElementsArray:(NSArray *)rawElements;
//- (void)convertThe:(NSDictionary *)rawElement IntoRefinedElementsAndAddTo:(NSMutableArray *)temporaryDataElements;
- (void)refineTheRawElementDictionary:(NSDictionary *)rawElement thenAddToTemporaryMutableArray:(NSMutableArray *)temporaryDataElements;


//- (void)setTheSectionNumberForAllTheElementsIn:(NSMutableArray *)temporaryDataElements;
- (void)setSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
//- (NSInteger)setTheTotalNumberOfSections;
- (NSInteger)sectionCount;
//- (void)sortTheElementsInEach:(NSMutableArray *)sectionArray andAddTo:(NSMutableArray *)elementSections;
- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray andAddToArrayOfSections:(NSMutableArray *)elementSections;

@end

#pragma mark -

@interface CPDataIndexer : NSObject <CPDataIndexHandling>

#pragma mark - Property

@property (retain) CPRefinedElement *refinedElement;

#pragma mark - Intialization

- (id)initWithRefinedElement:(CPRefinedElement *)refinedElement;

@end
