//
//  CPPlacesRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPlacesRefinedElement.h"
#import "NSString+TitleExtraction.h"
#import "NSString+TitleExtraction.h"
#import "NSString+FindCharacterInSet.h"


@implementation CPPlacesRefinedElement

NSString *CPPlaceID = @"place_id";

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement
{
	return [[rawElement objectForKey:@"_content"] initialStringWithDelimiterSet:[NSString characterSetWithComma]];
}

//TODO: refactor
- (void)extractTitleAndSubTitleFromDictionary;
{
	//TODO: this should be divided to be giving only title and subtitle.
	NSString *contentString = [self.dictionary objectForKey:@"_content"];
	self.title = [contentString initialStringWithDelimiterSet:[NSString characterSetWithComma]];
	
	if ([contentString enumerateStringToDetermineTheExistanceOfCharacterInSet:[NSString characterSetWithComma]])
	{
		int startingIndexOfSubTitle = [contentString rangeOfCharacterFromSet:[NSString characterSetWithComma]].location + 1;
		NSString *subTitle = [contentString substringFromIndex:startingIndexOfSubTitle +1];
		self.subtitle = [subTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
}

#pragma mark - NSCopying protocol method

- (id)copyWithZone:(NSZone *)zone;
{
	CPPlacesRefinedElement *refinedElementCopy = [[CPPlacesRefinedElement alloc] init];
	return refinedElementCopy;
}

@end
