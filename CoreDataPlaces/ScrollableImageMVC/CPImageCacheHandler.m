//
//  CPImageCacheHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/16/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPImageCacheHandler.h"


@implementation CPImageCacheHandler

#pragma mark - Instance method

- (void)cacheImage:(NSString *)imageLocation UIImage:(UIImage *)image;
{
	NSURL *imageLocationURL = [NSURL URLWithString: imageLocation];
    NSString *filename = [imageLocationURL lastPathComponent];
	
	//TODO: create a convenience method.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cacheLocation = [paths objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error;
	if (! [[NSFileManager defaultManager] fileExistsAtPath:cacheLocation isDirectory:&isDir] && isDir == NO) {
		[[NSFileManager defaultManager] createDirectoryAtPath:cacheLocation withIntermediateDirectories:NO attributes:nil error:&error];
	}
	
	
	
    NSString *uniquePath = [cacheLocation stringByAppendingPathComponent: filename];
	
    // Check for file existence
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        // Fetch image
        if (image)
		{
			NSData *data = [NSData dataWithContentsOfURL:imageLocationURL];
			image = [[[UIImage alloc] initWithData: data] autorelease];
        }
		if(
			[imageLocation rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound || 
			[imageLocation rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound
		   )
        {
            [UIImageJPEGRepresentation(image, 100) writeToFile:uniquePath atomically: YES];
        }
    }
}

- (UIImage *)getCachedImage:(NSString *)imageLocation;
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cacheLocation = [paths objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error;
	if (! [[NSFileManager defaultManager] fileExistsAtPath:cacheLocation isDirectory:&isDir] && isDir == NO)
	{
		[[NSFileManager defaultManager] createDirectoryAtPath:cacheLocation withIntermediateDirectories:NO attributes:nil error:&error];
	}
	
    NSURL *imageLocationURL = [NSURL URLWithString: imageLocation];
    NSString *filename = [imageLocationURL lastPathComponent];
	NSString *uniquePath = [cacheLocation stringByAppendingPathComponent:filename];
    
    // Check for a cached version
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
        [self cacheImage:imageLocation UIImage:nil];
    return [UIImage imageWithContentsOfFile:uniquePath];
}

- (BOOL)deleteCacheImage:(NSString *)imageLocation;
{
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//	NSString *cacheLocation = [paths objectAtIndex:0];
//	BOOL isDir = NO;
//	NSError *error;
//	if (! [[NSFileManager defaultManager] fileExistsAtPath:cacheLocation isDirectory:&isDir] && isDir == NO) {
//		[[NSFileManager defaultManager] createDirectoryAtPath:cacheLocation withIntermediateDirectories:NO attributes:nil error:&error];
//	}
	NSString *cacheLocation = 
	
	NSURL *imageLocationURL = [NSURL URLWithString: imageLocation];
    NSString *filename = [imageLocationURL lastPathComponent];
    NSString *uniquePath = [cacheLocation stringByAppendingPathComponent:filename];

	NSFileManager *fileManager = [NSFileManager defaultManager];
	error = nil;
    BOOL fileExists = [fileManager fileExistsAtPath:uniquePath];
	BOOL success = NO;
    if (fileExists) 
    {
		success = [fileManager removeItemAtPath:uniquePath error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
    }
	return success;
}

- (NSString *)CP_cacheLocation;
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cacheLocation = [paths objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error;
	if (! [[NSFileManager defaultManager] fileExistsAtPath:cacheLocation isDirectory:&isDir] && isDir == NO)
	{
		[[NSFileManager defaultManager] createDirectoryAtPath:cacheLocation withIntermediateDirectories:NO attributes:nil error:&error];
	}
}

@end
