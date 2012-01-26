//
//  CPDataIndexer.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import <Foundation/Foundation.h>
#import "CPRefinedElement.h"

@interface CPDataIndexer : NSObject

#pragma mark - Property

@property (retain) CPRefinedElement *refinedElement;

#pragma mark - Intialization

//TODO: add initializer with refinedElement;
- (id)initWithRefinedElement:(CPRefinedElement *)refinedElement;

#pragma mark - Methods

//- (NSMutableArray *)returnTheIndexedSectionsOfTheGiven:(NSArray *)rawData;
- (NSMutableArray *)indexedSectionsOfTheRawElementsArray:(NSArray *)rawElements;

#pragma mark - Methods to override

//- (void)convertThe:(NSDictionary *)rawElement IntoRefinedElementsAndAddTo:(NSMutableArray *)temporaryDataElements;
- (void)refineTheRawElementDictionary:(NSDictionary *)rawElement thenAddToTemporaryMutableArray:(NSMutableArray *)temporaryDataElements;
//- (void)setTheSectionNumberForAllTheElementsIn:(NSMutableArray *)temporaryDataElements;
- (void)setSectionNumberForElementsInArray:(NSMutableArray *)temporaryDataElements;
//- (NSInteger)setTheTotalNumberOfSections;
- (NSInteger)setSectionCount;
//- (void)sortTheElementsInEach:(NSMutableArray *)sectionArray andAddTo:(NSMutableArray *)elementSections;
- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray thenAddToArrayOfSections:(NSMutableArray *)elementSections;

@end
