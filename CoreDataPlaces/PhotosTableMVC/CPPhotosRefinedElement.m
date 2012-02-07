//
//  CPPhotosRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosRefinedElement.h"
#import "Place.h"

@interface CPPhotosRefinedElement ()
{
@private
	Place *CP_itsPlace;
}
@end

#pragma mark -

@implementation CPPhotosRefinedElement

#pragma mark - Synthesize

@synthesize itsPlace = CP_itsPlace;

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement;
{
	NSDate *endDate = [NSDate date];
	NSString *dateUpload = [rawElement objectForKey:@"dateupload"];
	NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:[dateUpload intValue]];
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate 
												 options:0];
	double minute = (double)[components minute]/60.0;
	double number = minute + (double)[components hour];
	NSString *string = [NSString stringWithFormat:@"%.2f",number];
	return string;
}

- (NSComparisonResult)compare:(CPPhotosRefinedElement *)aRefinedElementPhoto;
{
	int result;
	NSNumberFormatter *formatter = [[[NSNumberFormatter alloc] init] autorelease];
	if ([formatter numberFromString:self.comparable] && [formatter numberFromString:aRefinedElementPhoto.comparable])
		result = [[NSNumber numberWithDouble:[self.comparable doubleValue]] compare:[NSNumber numberWithDouble:[aRefinedElementPhoto.comparable doubleValue]]];
	else	
		result = 0;
	return result;
}

//TODO: refactor
- (void)extractTitleAndSubTitleFromDictionary;
{
	//TODO: this should be divided to be giving only title and subtitle.
	NSDictionary *cellDictionary = self.dictionary;
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
	
	self.title = [titleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if (!([subTitleString length] == 0))
	{
		self.subtitle = [subTitleString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
}

- (NSString *)title;
{
	if (CP_title == nil)
	{
		[self extractTitleAndSubTitleFromDictionary];
	}
	return [[CP_title copy] autorelease];
}

- (NSString *)subtitle;
{
	if (CP_subtitle == nil) 
	{
		[self extractTitleAndSubTitleFromDictionary];
	}
	return [[CP_subtitle copy] autorelease];
}

#pragma mark - NSCopying protocol method

- (id)copyWithZone:(NSZone *)zone;
{
	CPPhotosRefinedElement *refinedElementCopy = [[CPPhotosRefinedElement alloc] init];
	return refinedElementCopy;
}

@end
