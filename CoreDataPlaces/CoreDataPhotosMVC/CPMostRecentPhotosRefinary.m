//
//  CPMostRecentPhotosRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/2/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinary.h"
#import "NSNumber+Additions.h"
#import "NSDate+Additions.h"
#import "CPRefinedElement.h"
#import "Photo.h"


@implementation CPMostRecentPhotosRefinary

#pragma mark - Overriding method

- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	if ([refinedElement.rawElement isKindOfClass:[Photo class]])
	{
		Photo *thePhoto = (Photo *)refinedElement.rawElement;
		NSDate *startDate = thePhoto.timeOfLastView;
		NSDateComponents *components = [NSDate dateComponentsBetweenNowAndGivenDate:startDate];
		refinedElement.comparable = [[NSNumber numberInHoursWithDateComponents:components] stringValue];
	}
}

@end
