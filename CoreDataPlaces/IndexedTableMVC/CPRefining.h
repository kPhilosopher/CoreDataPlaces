//
//  CPRefining.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/4/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CPRefinedElement;

@protocol CPRefining <NSObject>

@required

- (NSArray *)refinedElementsWithGivenRefinedElementType:(CPRefinedElement *)refinedElement rawElements:(NSArray *)rawElements;
- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
- (void)setCustomPropertiesForRefinedElement:(CPRefinedElement *)refinedElement;

@end
