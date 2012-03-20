//
//  Place.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/9/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "Place.h"
#import "Photo.h"


@implementation Place

@dynamic category;
@dynamic hasFavoritePhoto;
@dynamic placeID;
@dynamic subtitle;
@dynamic title;
@dynamic photos;

#pragma mark - Instance method

- (void)checkPhotosToEnsureFavoritePlace;
{
	NSMutableSet *setOfPhotos = [self primitivePhotos];
	BOOL verdict = NO;
	for (Photo *photo in setOfPhotos)
	{
		if ([photo.isFavorite boolValue])
			verdict = YES;
	}
	self.hasFavoritePhoto = [NSNumber numberWithBool:verdict];
}

@end
