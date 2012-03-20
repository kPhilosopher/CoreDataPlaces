//
//  CPTopPlacesRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/14/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPlacesRefinary.h"
#import "CPConstants.h"
#import "CPPlacesRefinedElement.h"
#import "NSString+TitleExtraction.h"
#import "NSString+FindCharacterInSet.h"


@implementation CPPlacesRefinary

#pragma mark - Overriding method

- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	refinedElement.comparable = [[refinedElement.rawElement objectForKey:@"_content"] initialStringWithDelimiterSet:[NSString characterSetWithComma]];
}

//TODO: refactor
- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement.rawElement isKindOfClass:[NSDictionary class]]) 
	{
		NSDictionary *dictionary = (NSDictionary *)refinedElement.rawElement;
		NSString *contentString = [dictionary objectForKey:@"_content"];
		refinedElement.title = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
		
		if ([contentString enumerateStringToDetermineTheExistanceOfCharacterInSet:[NSString characterSetWithComma]])
		{
			int startingIndexOfSubTitle = [contentString rangeOfCharacterFromSet:[NSString characterSetWithComma]].location + 1;
			NSString *subTitle = [contentString substringFromIndex:startingIndexOfSubTitle +1];
			refinedElement.subtitle = [subTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		}
	}
}

- (void)setCustomPropertiesForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement isKindOfClass:[CPPlacesRefinedElement class]]) 
	{
		CPPlacesRefinedElement *placesRefinedElement = (CPPlacesRefinedElement *)refinedElement;
		if ([placesRefinedElement.rawElement isKindOfClass:[NSDictionary class]]) 
		{
			NSDictionary *dictionary = (NSDictionary *)placesRefinedElement.rawElement;
			placesRefinedElement.placeID = [dictionary objectForKey:CPPlaceID];
		}
	}
}

@end
