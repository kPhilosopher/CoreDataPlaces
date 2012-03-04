//
//  CPMostRecentPhotosRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPMostRecentPhotosRefinedElement.h"
#import "Photo.h"


@interface CPMostRecentPhotosRefinedElement()
{
	@private
	NSString *CP_comparable;
	id CP_rawElement;
	NSString *CP_title;
	NSString *CP_subtitle;
	NSInteger CP_sectionNumber;
}

@end

#pragma mark -

@implementation CPMostRecentPhotosRefinedElement

#pragma mark - Synthesize

@synthesize comparable = CP_comparable;
@synthesize rawElement = CP_rawElement;
@synthesize title = CP_title;
@synthesize subtitle = CP_subtitle;
@synthesize sectionNumber = CP_sectionNumber;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_comparable release];
	[CP_rawElement release];
	[CP_title release];
	[CP_subtitle release];
	[super dealloc];
}

#pragma mark - Instance method

- (id)copyWithZone:(NSZone *)zone;
{
	return [[[CPMostRecentPhotosRefinedElement alloc] init] autorelease];
}

- (NSComparisonResult)compare:(CPMostRecentPhotosRefinedElement *)refinedElement;
{
//	return [self.comparable compare:refinedElement.comparable];
	return [[NSNumber numberWithFloat:[self.comparable floatValue]] compare:[NSNumber numberWithFloat:[refinedElement.comparable floatValue]]];
}

@end
