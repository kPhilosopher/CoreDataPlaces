//
//  CPPhotosRefinary.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/15/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPPhotosRefinary.h"
#import "CPPhotosRefinedElement.h"
#import "FlickrFetcher.h"


@implementation CPPhotosRefinary

#pragma mark - Overriding method

//TODO: refactor dateUpload should be secondsSinceUpload
//NSString *secondsSinceUpload = [photosRefinedElement.dictionary objectForKey:@"dateupload"];
//NSDate *uploadDate = [NSDate dateWithTimeIntervalSince1970:[secondsSinceUpload intValue]];
//secondsBetween1970AndUpload
- (void)setComparableForRefinedElement:(CPRefinedElement *)refinedElement;
{ 
	if ([refinedElement.rawElement isKindOfClass:[NSDictionary class]])
	{
		//TODO: create a file with this redundant code.
		NSDictionary *dictionary = (NSDictionary *)refinedElement.rawElement;
		NSString *dateUpload = [dictionary objectForKey:@"dateupload"];
		NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[dateUpload intValue]];
		NSDate *endDate = [NSDate date];
		
		NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
		NSDateComponents *components = [gregorian components:unitFlags
													fromDate:startDate
													  toDate:endDate 
													 options:0];
		
		//math with components
		float seconds = (float)[components second];
		float minutesInSeconds = (((float)[components minute]) * 60.0);
		float allSecondsInDecimal = (seconds + minutesInSeconds) / 3600.0;
		float number = allSecondsInDecimal + (float)[components hour];
		refinedElement.comparable = [NSString stringWithFormat:@"%.5f",number];
	}
}

//TODO: refactor
- (void)setTitleAndSubtitleForRefinedElement:(CPRefinedElement *)refinedElement;
{
	if ([refinedElement.rawElement isKindOfClass:[NSDictionary class]])
	{
		NSDictionary *dictionary = (NSDictionary *)refinedElement.rawElement;
		NSDictionary *cellDictionary = dictionary;
		id temporaryTitleString = [cellDictionary objectForKey:@"title"];
		id temporaryDescriptionDictionary = [cellDictionary objectForKey:@"description"];
		id temporaryDescriptionString = nil;
		if ([temporaryDescriptionDictionary isKindOfClass:[NSDictionary class]]) {
			temporaryDescriptionString = [temporaryDescriptionDictionary objectForKey:@"_content"];
		}
		
		NSString *titleString = nil;
		NSString *subTitleString = nil;
		if ([temporaryTitleString isKindOfClass:[NSString class]])
		{
			titleString = (NSString *)temporaryTitleString;
		}
		if ([temporaryDescriptionString isKindOfClass:[NSString class]]) {
			subTitleString = (NSString *)temporaryDescriptionString;
		}
		
		if ([titleString length] == 0) 
		{
			titleString = subTitleString;		
			if ([subTitleString length] == 0) {
				titleString = @"Unknown";
			}
			subTitleString = @"";
		}
		
		refinedElement.title = [titleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		if (!([subTitleString length] == 0))
		{
			refinedElement.subtitle = [subTitleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		}
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
