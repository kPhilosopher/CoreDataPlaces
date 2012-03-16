//
//  CPPlacesRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/15/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPPlacesRefinedElement.h"


@interface CPPlacesRefinedElement()
{
	@private
	NSString *CP_placeID;
}
@end

#pragma mark -

@implementation CPPlacesRefinedElement

#pragma mark - Synthesize

@synthesize placeID = CP_placeID;

#pragma mark - Object lifecycle

- (void)dealloc;
{
	[CP_placeID release];
	[super dealloc];
}

#pragma mark - NSCopying protocol method

- (id)copyWithZone:(NSZone *)zone;
{
	return [[CPPlacesRefinedElement alloc] init];
}


@end
