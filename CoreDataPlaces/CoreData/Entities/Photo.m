//
//  Photo.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/9/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "Photo.h"
#import "Place.h"


@implementation Photo

#pragma mark - Dynamic

@dynamic isFavorite;
@dynamic photoURL;
@dynamic subtitle;
@dynamic timeOfLastView;
@dynamic timeOfUpload;
@dynamic title;
@dynamic timeLapseSinceUpload;
@dynamic timeLapseSinceLastView;
@dynamic itsPlace;

#pragma mark - Instance method

- (BOOL)isKindOfClass:(Class)aClass;
{
	return [super isKindOfClass:aClass];
}

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
