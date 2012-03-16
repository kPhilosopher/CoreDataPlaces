//
//  CPTopPlacesRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/14/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPTopPlacesRefinary.h"
#import "CPRefinedElement.h"
#import "NSString+TitleExtraction.h"
#import "NSString+TitleExtraction.h"
#import "NSString+FindCharacterInSet.h"


@implementation CPTopPlacesRefinary

//TODO: change the location of the extern string
NSString *CPPlaceID = @"place_id";

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

@end
