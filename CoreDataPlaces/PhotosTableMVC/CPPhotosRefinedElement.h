//
//  CPPhotosRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPRefinedElement.h"


@class Place;

@interface CPPhotosRefinedElement : CPRefinedElement

#pragma mark - Property

@property (copy) NSString *title;
@property (copy) NSString *subtitle;
@property (retain) Place *itsPlace;

#pragma mark - Instance method

- (NSComparisonResult)compare:(CPPhotosRefinedElement *)aRefinedElementPicture;

@end
