//
//  CPFavoritePhotosRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/20/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPFavoritePhotosRefinary.h"
#import "NSNumber+Additions.h"
#import "NSDate+Additions.h"
#import "CPRefinedElement.h"
#import "Photo+Logic.h"


@implementation CPFavoritePhotosRefinary

#pragma mark - Overriding method

- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	if ([refinedElement.rawElement isKindOfClass:[Photo class]])
	{
		Photo *thePhoto = (Photo *)refinedElement.rawElement;
		NSDate *startDate = thePhoto.timeOfUpload;
		NSDateComponents *components = [NSDate dateComponentsBetweenNowAndGivenDate:startDate];
		refinedElement.comparable = [[NSNumber numberInHoursWithDateComponents:components] stringValue];
	}
}

@end
