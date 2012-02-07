//
//  CPRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPRefinedElement.h"


@interface CPRefinedElement ()
{
@private
//	NSString *CP_title;
//	NSString *CP_subtitle;
	NSString *CP_comparable;
	NSDictionary *CP_dictionary;
	NSInteger CP_sectionNumber;
}
@end

#pragma mark -

@implementation CPRefinedElement

#pragma mark - Synthesize

@synthesize title = CP_title;
@synthesize subtitle = CP_subtitle;
@synthesize comparable = CP_comparable;
@synthesize dictionary = CP_dictionary;
@synthesize sectionNumber = CP_sectionNumber;

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_title release];
	[CP_subtitle release];
	[CP_comparable release];
	[CP_dictionary release];
	[super dealloc];
}

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement
{
	return nil;
}

- (void)extractTitleAndSubTitleFromDictionary;
{
	return;
}

#pragma mark - NSCopying protocol method

- (id)copyWithZone:(NSZone *)zone;
{
	return [[CPRefinedElement alloc] init];
}

@end
