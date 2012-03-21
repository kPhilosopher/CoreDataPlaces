//
//  CPRefinary.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/13/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

// !!!:This is an abstract class. It must be subclassed with appropriate implementation.

#import <Foundation/Foundation.h>


@class CPRefinedElement;

@interface CPRefinary : NSObject

#pragma mark - Instance method

- (NSArray *)refinedElementsWithGivenRefinedElementType:(CPRefinedElement *)refinedElement rawElements:(NSArray *)rawElements;
- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
- (void)setCustomPropertiesForRefinedElement:(CPRefinedElement *)refinedElement;

@end
