//
//  CPCoreDataPhotosRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/16/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPCoreDataPhotosRefinary.h"
#import "CPRefinedElement.h"
#import "Photo.h"


@implementation CPCoreDataPhotosRefinary

#pragma mark - Overriding method

- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement.rawElement isKindOfClass:[Photo class]])
	{
		Photo *thePhoto = (Photo *)refinedElement.rawElement;
		refinedElement.title = thePhoto.title;
		refinedElement.subtitle = thePhoto.subtitle;
	}
}

@end
