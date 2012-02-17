//
//  CPImageCacheHandlerTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/16/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPImageCacheHandlerTests.h"
#import "CPImageCacheHandler.h"
#import "FlickrFetcher.h"
#import <UIKit/UIKit.h>


@implementation CPImageCacheHandlerTests

- (void)setUp;
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown;
{
    // Tear-down code here.
    
    [super tearDown];
}

// All code under test is in the iOS Application
- (void)test_cacheImage;
{
	//get the imageURL from a Flickr.
	NSDictionary *place = [[FlickrFetcher topPlaces] lastObject];
	NSString *place_id = [place objectForKey:@"place_id"];
	NSDictionary *photoDictionary = [[FlickrFetcher photosAtPlace:place_id] lastObject];
	NSString *imageURL = [FlickrFetcher urlStringForPhotoWithFlickrInfo:photoDictionary format:FlickrFetcherPhotoFormatSmall];
//    NSString *imageURL = [[NSBundle bundleForClass:[self class]] pathForResource:@"testImage" ofType:@"jpeg"];
	
	//get the cache url.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [paths objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error;
	if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir == NO) {
		[[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
	}
	NSURL *url = [NSURL URLWithString:imageURL];
	NSString *fileName = [url lastPathComponent];
	NSString *uniquePath = [cachePath stringByAppendingPathComponent:fileName];
	
	BOOL appCache = NO;
	//see if the application cached this file.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	error = nil;
    BOOL fileExists = [fileManager fileExistsAtPath:uniquePath];
    NSLog(@"Path to file: %@", uniquePath);        
    NSLog(@"File exists: %d", fileExists);
    NSLog(@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:uniquePath]);
    if (fileExists) 
    {
		appCache = YES;
        BOOL success = [fileManager removeItemAtPath:uniquePath error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
    }
	
	//test
	STAssertFalse([[NSFileManager defaultManager] fileExistsAtPath: uniquePath], @"there shouldn't be any files there.");
	
	CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
	[imageCacheHandler cacheImage:imageURL];
	
	STAssertTrue([[NSFileManager defaultManager] fileExistsAtPath: uniquePath], @"there should be a file there");

	
	//delete the file if the application didn't have this file.
	if (!appCache) {
		error = nil;
		fileExists = [fileManager fileExistsAtPath:uniquePath];
//		NSLog(@"Path to file: %@", uniquePath);        
//		NSLog(@"File exists: %d", fileExists1);
//		NSLog(@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:uniquePath]);
		if (fileExists) 
		{
			BOOL success = [fileManager removeItemAtPath:uniquePath error:&error];
			if (!success) NSLog(@"Error: %@", [error localizedDescription]);
		}
	}
}

- (void)test_getCachedImage;
{
	
	//with the file cached in the directory, see if I get it back.
	
	//get the file.
	NSDictionary *place = [[FlickrFetcher topPlaces] lastObject];
	NSString *place_id = [place objectForKey:@"place_id"];
	NSDictionary *photoDictionary = [[FlickrFetcher photosAtPlace:place_id] lastObject];
	NSString *imageLocation = [FlickrFetcher urlStringForPhotoWithFlickrInfo:photoDictionary format:FlickrFetcherPhotoFormatSmall];
	
	//get the cache url.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [paths objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error;
	if (! [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDir] && isDir == NO) {
		[[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
	}
	NSURL *url = [NSURL URLWithString:imageLocation];
	NSString *fileName = [url lastPathComponent];
	NSString *uniquePath = [cachePath stringByAppendingPathComponent:fileName];
	
	BOOL appCache = NO;
	//see if the application cached this file.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	error = nil;
    BOOL fileExists = [fileManager fileExistsAtPath:uniquePath];
    NSLog(@"Path to file: %@", uniquePath);        
    NSLog(@"File exists: %d", fileExists);
    NSLog(@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:uniquePath]);
    if (fileExists) 
    {
		appCache = YES;
        BOOL success = [fileManager removeItemAtPath:uniquePath error:&error];
        if (!success) NSLog(@"Error: %@", [error localizedDescription]);
    }
	
	
	//write into the cache an image that is different from what you get from Flickr.
//    NSString *imageURL = [[NSBundle bundleForClass:[self class]] pathForResource:@"testImage" ofType:@"jpeg"];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *image = [UIImage imageWithData:data];
	[UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
	
	
	
	
	//check it.
	CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
	UIImage *returnedImage = [imageCacheHandler getCachedImage:imageLocation];
	
	STAssertTrue(returnedImage.size.width == image.size.width,@"The images' width should be the same.");
	STAssertTrue(returnedImage.size.height == image.size.height,@"The images' height should be the same.");

	
	//delete the file if the application didn't have this file.
	if (!appCache) {
		error = nil;
		fileExists = [fileManager fileExistsAtPath:uniquePath];
		//		NSLog(@"Path to file: %@", uniquePath);        
		//		NSLog(@"File exists: %d", fileExists1);
		//		NSLog(@"Is deletable file at path: %d", [fileManager isDeletableFileAtPath:uniquePath]);
		if (fileExists) 
		{
			BOOL success = [fileManager removeItemAtPath:uniquePath error:&error];
			if (!success) NSLog(@"Error: %@", [error localizedDescription]);
		}
	}
	
	//without the file in the cache, see if I get it back.
	
	
}

@end
