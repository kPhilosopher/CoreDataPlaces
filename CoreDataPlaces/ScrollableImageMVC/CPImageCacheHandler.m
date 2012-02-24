//
//  CPImageCacheHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/16/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPImageCacheHandler.h"
#import "NSString+DirectoryFinder.h"


@implementation CPImageCacheHandler

#pragma mark - Instance method

- (void)cacheImage:(NSString *)imageLocation UIImage:(UIImage *)image;
{
	NSURL *imageLocationURL = [NSURL URLWithString: imageLocation];
    NSString *filename = [imageLocationURL lastPathComponent];
	NSString *cacheLocation = [NSString cacheLocation];
    NSString *uniquePath = [cacheLocation stringByAppendingPathComponent: filename];
	
    // Check for file existence
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        // Fetch image
        if (!image)
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
	NSString *cacheLocation = [NSString cacheLocation];
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
	NSString *cacheLocation = [NSString cacheLocation];	
	NSURL *imageLocationURL = [NSURL URLWithString: imageLocation];
    NSString *filename = [imageLocationURL lastPathComponent];
    NSString *uniquePath = [cacheLocation stringByAppendingPathComponent:filename];

	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error = nil;
    BOOL fileExists = [fileManager fileExistsAtPath:uniquePath];
	BOOL success = NO;
    if (fileExists) 
    {
		success = [fileManager removeItemAtPath:uniquePath error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
    }
	return success;
}

@end
