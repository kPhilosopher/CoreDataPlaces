//
//  CPRefining.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/4/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CPMostRecentPhotosRefinedElement;

@protocol CPRefining <NSObject>

@required

//TODO: changed the most recent to just CPRefinedElement.
//- (id)initWithRefinedElementType:(CPMostRecentPhotosRefinedElement *)refinedElement;
- (NSArray *)refinedElementsWithGivenRefinedElementType:(CPMostRecentPhotosRefinedElement *)refinedElement rawElements:(NSArray *)rawElements;
- (void)setComparableForRefinedElement:(CPMostRecentPhotosRefinedElement *)refinedElement;
- (void)setTitleAndSubtitleForRefinedElement:(CPMostRecentPhotosRefinedElement *)refinedElement;

@end
