//
//  NSString+TitleExtractor.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/26/11.
//

#import "NSString+TitleExtraction.h"

@implementation NSString (TitleExtraction)

#pragma mark - Class method

+ (NSCharacterSet *)characterSetWithComma;
{
	return [NSCharacterSet characterSetWithCharactersInString:@","];
}

#pragma mark - Public method

- (NSString *)initialStringWithDelimiterSet:(NSCharacterSet *)aSet;
{
	NSArray *delimitedString = [self componentsSeparatedByCharactersInSet:aSet];
	NSString *initialString = [delimitedString objectAtIndex:0];
	return [initialString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end