//
//  CPDataIndexer.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import <Foundation/Foundation.h>
#import "CPRefinedElement.h"

@protocol CPDataIndexDelegate <NSObject>

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
- (void)sortTheElementsInSectionArray:(NSMutableArray *)sectionArray thenAddToArrayOfSections:(NSMutableArray *)elementSections;

@end

@interface CPDataIndexer : NSObject <CPDataIndexDelegate>

#pragma mark - Property

@property (retain) CPRefinedElement *refinedElement;

#pragma mark - Intialization

- (id)initWithRefinedElement:(CPRefinedElement *)refinedElement;

@end
