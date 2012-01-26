//
//  NSString+FindCharacterInSet.m
//  Places_09
//
//  Created by Jinwoo Baek on 1/8/12.
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
