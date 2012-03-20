//
//  CPPhotosRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/15/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosRefinary.h"
#import "NSNumber+Additions.h"
#import "NSDate+Additions.h"
#import "CPPhotosRefinedElement.h"
#import "FlickrFetcher.h"


@implementation CPPhotosRefinary

#pragma mark - Overriding method

- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	if ([refinedElement.rawElement isKindOfClass:[NSDictionary class]])
	{
		NSDictionary *dictionary = (NSDictionary *)refinedElement.rawElement;
		NSString *secondsBetween1970AndUpload = [dictionary objectForKey:@"dateupload"];
		NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[secondsBetween1970AndUpload intValue]];
		NSDateComponents *components = [NSDate dateComponentsBetweenNowAndGivenDate:startDate];
		refinedElement.comparable = [[NSNumber numberInHoursWithDateComponents:components] stringValue];
	}
}

- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement.rawElement isKindOfClass:[NSDictionary class]])
	{
		NSDictionary *dictionary = (NSDictionary *)refinedElement.rawElement;
		NSDictionary *cellDictionary = dictionary;
		id undeterminedTitle = [cellDictionary objectForKey:@"title"];
		
		id undeterminedDescriptionString = nil;
		id undeterminedDescriptionDictionary = [cellDictionary objectForKey:@"description"];
		if ([undeterminedDescriptionDictionary isKindOfClass:[NSDictionary class]])
			undeterminedDescriptionString = [undeterminedDescriptionDictionary objectForKey:@"_content"];
		
		NSString *titleString = nil;
		if ([undeterminedTitle isKindOfClass:[NSString class]])
			titleString = (NSString *)undeterminedTitle;
		
		NSString *subTitleString = nil;
		if ([undeterminedDescriptionString isKindOfClass:[NSString class]])
			subTitleString = (NSString *)undeterminedDescriptionString;
		
		if ([titleString length] == 0) 
		{
			if ([subTitleString length] == 0)
				titleString = @"Unknown";
			else
				titleString = subTitleString;
			subTitleString = @"";
		}
		refinedElement.title = [titleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		if (!([subTitleString length] == 0))
			refinedElement.subtitle = [subTitleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
}

- (void)setCustomPropertiesForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement isKindOfClass:[CPPhotosRefinedElement class]]) 
	{
		CPPhotosRefinedElement *photoRefinedElement = (CPPhotosRefinedElement *)refinedElement;
		if ([photoRefinedElement.rawElement isKindOfClass:[NSDictionary class]]) {
			
			photoRefinedElement.largePhotoURL = [FlickrFetcher urlStringForPhotoWithFlickrInfo:refinedElement.rawElement format:FlickrFetcherPhotoFormatLarge];
		}
	}
}

@end
