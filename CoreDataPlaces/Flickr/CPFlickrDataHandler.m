//
//  CPFlickrDataHandler.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPFlickrDataHandler.h"

@implementation CPFlickrDataHandler

#pragma mark - Instance method.

- (NSArray *)flickrTopPlaces;
{
	return [FlickrFetcher topPlaces];
}

- (NSArray *)flickrPhotoListWithPlaceID:(NSString *)flickrPlaceId;
{
	return [FlickrFetcher photosAtPlace:flickrPlaceId];
}

@end
