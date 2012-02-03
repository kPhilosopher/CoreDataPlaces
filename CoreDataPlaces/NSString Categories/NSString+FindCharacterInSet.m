//
//  NSString+FindCharacterInSet.m
//  Places
//
//  Created by Jinwoo Baek on 1/8/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "NSString+FindCharacterInSet.h"

@implementation NSString (FindCharacterInSet)

#pragma  mark - Public method

- (BOOL)enumerateStringToDetermineTheExistanceOfCharacterInSet:(NSCharacterSet *)aSet;
{
	BOOL verdict = NO;
	for (int index = 0; index < [self length]; index++) 
	{
		char characterInString = [self characterAtIndex:index];
		if ([aSet characterIsMember:characterInString])
			verdict = YES;
	}
	return verdict;
}

@end
