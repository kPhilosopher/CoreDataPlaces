//
//  CPPhotosRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPPhotosRefinedElement.h"


@interface CPPhotosRefinedElement ()
{
@private
	NSString *CP_largePhotoURL;
}
@end

#pragma mark -

@implementation CPPhotosRefinedElement

#pragma mark - Synthesize

@synthesize largePhotoURL = CP_largePhotoURL;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_largePhotoURL release];
	[super dealloc];
}

#pragma mark - NSCopying protocol method

- (id)copyWithZone:(NSZone *)zone;
{
	return [[CPPhotosRefinedElement alloc] init];
}

@end
