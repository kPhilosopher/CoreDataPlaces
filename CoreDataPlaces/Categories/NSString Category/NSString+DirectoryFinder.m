//
//  NSString+DirectoryFinder.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/17/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "NSString+DirectoryFinder.h"


@implementation NSString (DirectoryFinder)

#pragma mark - Class method

+ (NSString *)cacheLocation;
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cacheLocation = [paths objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error;
	if (! [[NSFileManager defaultManager] fileExistsAtPath:cacheLocation isDirectory:&isDir] && isDir == NO)
	{
		[[NSFileManager defaultManager] createDirectoryAtPath:cacheLocation withIntermediateDirectories:NO attributes:nil error:&error];
	}
	return cacheLocation;
}

@end
