//
//  CPRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPRefinedElementInterfacing.h"

//TODO: erase CPRefinedElementInterfacing.
//TODO: make changes to tableViewHandlers to allow to just handle RefinedElements, not managed objects as well.
@interface CPRefinedElement : NSObject <NSCopying, CPRefinedElementInterfacing>

#pragma mark - Property

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (copy) NSString *comparable;
@property (retain) NSDictionary *dictionary;
@property NSInteger sectionNumber;

#pragma mark - Recommended to override


//TODO: change method name to: - (void)setComparableWithRawElement:(id)rawElement;
- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement;
//TODO: change method name to: - (void)setTitleAndSubtitle;
- (void)extractTitleAndSubTitleFromDictionary;
- (id)copyWithZone:(NSZone *)zone;

@end
