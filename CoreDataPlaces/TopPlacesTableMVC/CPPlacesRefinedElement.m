//
//  CPPlacesRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import "CPPlacesRefinedElement.h"
#import "NSString+TitleExtraction.h"

@implementation CPPlacesRefinedElement

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement
{
	return [[rawElement objectForKey:@"_content"] initialStringWithDelimiterSet:[NSString characterSetWithComma]];
}

#pragma mark - NSCopying protocol method

- (id)copyWithZone:(NSZone *)zone;
{
	CPPlacesRefinedElement *refinedElementCopy = [[CPPlacesRefinedElement alloc] init];
	return refinedElementCopy;
}

@end
