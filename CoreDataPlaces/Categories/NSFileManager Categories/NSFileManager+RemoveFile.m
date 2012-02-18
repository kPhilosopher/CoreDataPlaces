//
//  NSFileManager+RemoveFile.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/17/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "NSFileManager+RemoveFile.h"

@implementation NSFileManager (RemoveFile)

#pragma mark - Class method

+ (BOOL)removeFileAtPath:(NSString *)path;
{
	NSError *error = nil;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL fileExists = [fileManager fileExistsAtPath:path];
	BOOL success = NO;
	if (fileExists) 
	{
		success = [fileManager removeItemAtPath:path error:&error];
		if (!success) NSLog(@"Error: %@", [error localizedDescription]);
	}
	return success;
}

@end
