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
	NSString *CP_comparable;
	id CP_rawElement;
	NSString *CP_title;
	NSString *CP_subtitle;
	NSInteger CP_sectionNumber;
}
@end

#pragma mark -

@implementation CPRefinedElement

#pragma mark - Synthesize

@synthesize comparable = CP_comparable;
@synthesize rawElement = CP_rawElement;
@synthesize title = CP_title;
@synthesize subtitle = CP_subtitle;
@synthesize sectionNumber = CP_sectionNumber;

#pragma mark - View lifecycle

- (void)dealloc
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
	return [[CPRefinedElement alloc] init];
}

- (NSComparisonResult)compare:(CPRefinedElement *)refinedElement;
{
	return [[NSNumber numberWithFloat:[self.comparable floatValue]] compare:[NSNumber numberWithFloat:[refinedElement.comparable floatValue]]];
}

@end
