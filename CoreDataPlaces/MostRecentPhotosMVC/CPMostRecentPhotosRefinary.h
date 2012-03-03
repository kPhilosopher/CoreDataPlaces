//
//  CPMostRecentPhotosRefinary.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/2/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPMostRecentPhotosRefinedElement;

@interface CPMostRecentPhotosRefinary : NSObject

#pragma mark - Instance method

//+ (NSArray *)refinedElementsWithRawElements:(NSArray *)rawElements;
+ (NSArray *)refinedElementsWithGivenRefinedElementType:(CPMostRecentPhotosRefinedElement *)refinedElement rawElements:(NSArray *)rawElements;
+ (void)setComparableForRefinedElement:(CPMostRecentPhotosRefinedElement *)refinedElement;
+ (void)setTitleAndSubtitleForRefinedElement:(CPMostRecentPhotosRefinedElement *)refinedElement;

@end
