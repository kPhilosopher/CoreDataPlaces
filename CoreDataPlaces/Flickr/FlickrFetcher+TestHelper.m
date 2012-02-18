//
//  FlickrFetcher+TestHelper.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/17/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "FlickrFetcher+TestHelper.h"


@implementation FlickrFetcher (TestHelper)

#pragma mark - Class method

+ (NSDictionary *)anyFlickPhotoDictionary;
{
	NSDictionary *place = [[FlickrFetcher topPlaces] lastObject];
	NSString *place_id = [place objectForKey:@"place_id"];
	return [[FlickrFetcher photosAtPlace:place_id] lastObject];
}

@end
