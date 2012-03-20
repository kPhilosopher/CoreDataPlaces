//
//  Photo+TimeLapseCalculator.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "Photo+Logic.h"
#import "Place.h"


@implementation Photo (Logic)

#pragma mark - Accessor method

- (NSNumber *)isFavorite;
{
	[self willAccessValueForKey:@"isFavorite"];
    NSNumber *boolean = [self primitiveIsFavorite];
    [self didAccessValueForKey:@"isFavorite"];
    return boolean;
}

- (void)setIsFavorite:(NSNumber *)isFavorite;
{
	Place *itsPlace = [self primitiveItsPlace];
	NSNumber *oldBoolean = [self primitiveIsFavorite];
	//TODO: if isFavorite is NO when it was previously YES, send notification to Place to check if any others are still YES.
	
	[self willChangeValueForKey:@"isFavorite"];
	[self setPrimitiveIsFavorite:isFavorite];
	[self didChangeValueForKey:@"isFavorite"];
	
	if ([isFavorite boolValue])
	{
		itsPlace.hasFavoritePhoto = isFavorite;
	}
	else if ([oldBoolean boolValue] && ![isFavorite boolValue])
	{
		[itsPlace checkPhotosToEnsureFavoritePlace];
	}
}

@end
