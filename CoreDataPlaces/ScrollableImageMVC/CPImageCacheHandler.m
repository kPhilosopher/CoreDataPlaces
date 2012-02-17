//
//  CPImageCacheHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/16/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPImageCacheHandler.h"
#import "FlickrFetcher.h"

@implementation CPImageCacheHandler


- (void)cacheImage:(NSString *)imageLocation;
{
	NSURL *imageURL = [NSURL URLWithString: imageLocation];
    
    NSString *filename = [imageURL lastPathComponent];
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [paths objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error;
	if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir == NO) {
		[[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
	}
    NSString *uniquePath = [cachePath stringByAppendingPathComponent: filename];
	
    // Check for file existence
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        // The file doesn't exist, we should get a copy of it
		
        // Fetch image
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [[[UIImage alloc] initWithData: data] autorelease];
                
        // Is it PNG or JPG/JPEG?
        // Running the image representation function writes the data from the image to a file
		if(
			[imageLocation rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound || 
			[imageLocation rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound
			)
        {
            [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
        }
    }
}

- (UIImage *)getCachedImage:(NSString *)imageLocation;
{
	
	NSURL *imageURL = [NSURL URLWithString: imageLocation];
    
    NSString *filename = [imageURL lastPathComponent];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [paths objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error;
	if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir == NO) {
		[[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
	}
    NSString *uniquePath = [cachePath stringByAppendingPathComponent:filename];

    UIImage *image;
    
    // Check for a cached version
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        image = [UIImage imageWithContentsOfFile: uniquePath]; // this is the cached image
    }
    else
    {
        // get a new one
        [self cacheImage:imageLocation];
        image = [UIImage imageWithContentsOfFile: uniquePath];
    }
	
    return image;
}

@end
