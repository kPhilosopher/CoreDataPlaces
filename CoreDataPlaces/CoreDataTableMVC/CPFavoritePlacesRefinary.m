//
//  CPFavoritePlacesRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/20/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPFavoritePlacesRefinary.h"
#import "CPPlacesRefinedElement.h"
#import "Place.h"


@implementation CPFavoritePlacesRefinary

#pragma mark - Overriding method

- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	if ([refinedElement.rawElement isKindOfClass:[Place class]])
	{
		Place *thePlace = (Place *)refinedElement.rawElement;
		refinedElement.comparable = thePlace.title;
	}
}

- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement.rawElement isKindOfClass:[Place class]]) 
	{
		Place *thePlace = (Place *)refinedElement.rawElement;
		refinedElement.title = thePlace.title;
		refinedElement.subtitle = thePlace.subtitle;
	}
}

- (void)setCustomPropertiesForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement.rawElement isKindOfClass:[NSDictionary class]] && [refinedElement isKindOfClass:[CPPlacesRefinedElement class]]) 
	{
		CPPlacesRefinedElement *placesRefinedElement = (CPPlacesRefinedElement *)refinedElement;
		Place *thePlace = (Place *)refinedElement.rawElement;
		placesRefinedElement.placeID = thePlace.placeID;
	}
}

@end
