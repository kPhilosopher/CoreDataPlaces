//
//  NSString+TitleExtractor.m
//  Places
//
//  Created by Jinwoo Baek on 12/26/11.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "NSString+TitleExtraction.h"


@implementation NSString (TitleExtraction)

#pragma mark - Class method

+ (NSCharacterSet *)characterSetWithComma;
{
	return [NSCharacterSet characterSetWithCharactersInString:@","];
}

#pragma mark - Instance method

- (NSString *)initialStringWithDelimiterSet:(NSCharacterSet *)aSet;
{
	NSArray *delimitedString = [self componentsSeparatedByCharactersInSet:aSet];
	NSString *initialString = [delimitedString objectAtIndex:0];
	return [initialString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end