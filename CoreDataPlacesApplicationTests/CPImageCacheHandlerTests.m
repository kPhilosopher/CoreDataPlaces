//
//  CPImageCacheHandlerTests.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/16/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPImageCacheHandlerTests.h"
#import "CPImageCacheHandler.h"
#import "FlickrFetcher+TestHelper.h"
#import "NSFileManager+RemoveFile.h"
#import "NSString+DirectoryFinder.h"
#import <UIKit/UIKit.h>


@interface CPImageCacheHandlerTests ()
{
	@private
	NSString *CP_uniquePath;
	UIImage *CP_imageInUniquePath;
	NSString *CP_imageLocation;
}
@end

#pragma mark -

@implementation CPImageCacheHandlerTests

#pragma mark - Synthesize

@synthesize uniquePath = CP_uniquePath;
@synthesize imageInUniquePath = CP_imageInUniquePath;
@synthesize imageLocation = CP_imageLocation;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_imageLocation release];
	[CP_imageInUniquePath release];
	[CP_imageLocation release];
	[super dealloc];
}

#pragma mark - Setup teardown

- (void)setUp;
{
    [super setUp];
	NSDictionary *photoDictionary = [FlickrFetcher anyFlickPhotoDictionary];
	self.imageLocation = [FlickrFetcher urlStringForPhotoWithFlickrInfo:photoDictionary format:FlickrFetcherPhotoFormatSmall];
	
	NSString *cacheLocation = [NSString cacheLocation];
	NSURL *url = [NSURL URLWithString:self.imageLocation];
	NSString *fileName = [url lastPathComponent];
	self.uniquePath = [cacheLocation stringByAppendingPathComponent:fileName];
	
	//delete if there is a file in the cache with unique path.
	if ([[NSFileManager defaultManager] fileExistsAtPath:self.uniquePath]) 
	{
		self.imageInUniquePath = [UIImage imageWithContentsOfFile:self.uniquePath];
	}
	[NSFileManager removeFileAtPath:self.uniquePath];
}

- (void)tearDown;
{
    // Tear-down code here.
	[NSFileManager removeFileAtPath:self.uniquePath];
	
	if (self.imageInUniquePath)
	{
		[UIImageJPEGRepresentation(self.imageInUniquePath, 100) writeToFile:self.uniquePath atomically:YES];
		self.imageInUniquePath = nil;
	}
    [super tearDown];
}

#pragma mark - Tests

// All code under test is in the iOS Application
- (void)test_cacheImage;
{
	STAssertFalse([[NSFileManager defaultManager] fileExistsAtPath:self.uniquePath], @"there shouldn't be any files there.");
	
	CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
	[imageCacheHandler cacheImage:self.imageLocation UIImage:nil];
	
	STAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:self.uniquePath], @"there should be a file there");
}

- (void)test_getCachedImageWithFileAlreadyInCache;
{
	//write into the cache an image that is different from what you get from Flickr using the self.imageLocation.
	NSDictionary *photoDictionary = [FlickrFetcher anyFlickPhotoDictionary];
	NSString *largeImageLocation = [FlickrFetcher urlStringForPhotoWithFlickrInfo:photoDictionary format:FlickrFetcherPhotoFormatLarge];
	NSURL *largeImageURL = [NSURL URLWithString:largeImageLocation];
	NSData *largeImageData = [NSData dataWithContentsOfURL:largeImageURL];
	UIImage *imageToBeReturned = [UIImage imageWithData:largeImageData];
	[UIImageJPEGRepresentation(imageToBeReturned, 100) writeToFile:self.uniquePath atomically: YES];
	
	//check it.
	CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
	UIImage *returnedImage = [imageCacheHandler getCachedImage:self.imageLocation];
	
	STAssertTrue(returnedImage.size.width == imageToBeReturned.size.width,@"The images' width should be the same.");
	STAssertTrue(returnedImage.size.height == imageToBeReturned.size.height,@"The images' height should be the same.");
}

- (void)test_getCachedImageWithFileNotInCache;
{
	//get the image to compare it to the UIImage returned by the api.
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageLocation]];
	UIImage *imageToBeReturned = [UIImage imageWithData:imageData];
	
	//check it.
	CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
	UIImage *returnedImage = [imageCacheHandler getCachedImage:self.imageLocation];
	
	STAssertTrue(returnedImage.size.width == imageToBeReturned.size.width,@"The images' width should be the same.");
	STAssertTrue(returnedImage.size.height == imageToBeReturned.size.height,@"The images' height should be the same.");
}

- (void)test_deleteCacheImage;
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageLocation]];
	UIImage *imageToDelete = [UIImage imageWithData:imageData];
	[UIImageJPEGRepresentation(imageToDelete, 100) writeToFile:self.uniquePath atomically: YES];
	STAssertTrue([fileManager fileExistsAtPath:self.uniquePath],@"the file should exist.");
	//delete the cache
	CPImageCacheHandler *imageCacheHandler = [[CPImageCacheHandler alloc] init];
	STAssertTrue(([imageCacheHandler deleteCacheImage:self.imageLocation] == YES),@"The image cache delete should return a YES");
	//check if the cache is deleted.
	STAssertFalse([fileManager fileExistsAtPath:self.uniquePath],@"the file should not exist.");
}

@end
