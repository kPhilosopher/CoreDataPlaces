//
//  Place.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/9/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
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

//TODO: put this in a category

//- (void)addPhotosObject:(Photo *)value;
//{
//	if ([value.isFavorite boolValue] == YES)
//	{
//		self.hasFavoritePhoto = [NSNumber numberWithBool:YES];
//	}
//	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//	
//    [self willChangeValueForKey:@"photos"
//				withSetMutation:NSKeyValueUnionSetMutation
//				   usingObjects:changedObjects];
//    [[self primitivePhotos] addObject:value];
//    [self didChangeValueForKey:@"photos"
//			   withSetMutation:NSKeyValueUnionSetMutation
//				  usingObjects:changedObjects];
//	
//    [changedObjects release];
//}
//
//- (void)removePhotosObject:(Photo *)value;
//{
//	NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//	
//    [self willChangeValueForKey:@"photos"
//				withSetMutation:NSKeyValueMinusSetMutation
//				   usingObjects:changedObjects];
//    [[self primitivePhotos] removeObject:value];
//    [self didChangeValueForKey:@"photos"
//			   withSetMutation:NSKeyValueMinusSetMutation
//				  usingObjects:changedObjects];
//	
//    [changedObjects release];
//	
//	if ([value.isFavorite boolValue] == YES)
//	{
//		//check all the remainding photos.
//		NSSet *remaindingPhotos = [self primitivePhotos];
//		for (Photo *value in remaindingPhotos	) {
//			if ([value.isFavorite boolValue] == YES)
//			{
//				self.hasFavoritePhoto = [NSNumber numberWithBool:YES];
//				return;
//			}
//		}
//	}
//}
//
//- (void)addPhotos:(NSSet *)values;
//{
//	if ([self.hasFavoritePhoto boolValue] == YES)
//	{
//		return;
//	}
//	else
//	{
//		for (Photo *value in values) {
//			if ([value.isFavorite boolValue] == YES)
//			{
//				self.hasFavoritePhoto = [NSNumber numberWithBool:YES];
//				return;
//			}
//		}
//	}
//}
//
//- (void)removePhotos:(NSSet *)values;
//{
//	
//}

//
//- (void)removeEmployeesObject:(Employee *)value
//{
//    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
//	
//    [self willChangeValueForKey:@"employees"
//				withSetMutation:NSKeyValueMinusSetMutation
//				   usingObjects:changedObjects];
//    [[self primitiveEmployees] removeObject:value];
//    [self didChangeValueForKey:@"employees"
//			   withSetMutation:NSKeyValueMinusSetMutation
//				  usingObjects:changedObjects];
//	
//    [changedObjects release];
//}
//
//- (void)addEmployees:(NSSet *)value
//{
//    [self willChangeValueForKey:@"employees"
//				withSetMutation:NSKeyValueUnionSetMutation
//				   usingObjects:value];
//    [[self primitiveEmployees] unionSet:value];
//    [self didChangeValueForKey:@"employees"
//			   withSetMutation:NSKeyValueUnionSetMutation
//				  usingObjects:value];
//}
//
//- (void)removeEmployees:(NSSet *)value
//{
//    [self willChangeValueForKey:@"employees"
//				withSetMutation:NSKeyValueMinusSetMutation
//				   usingObjects:value];
//    [[self primitiveEmployees] minusSet:value];
//    [self didChangeValueForKey:@"employees"
//			   withSetMutation:NSKeyValueMinusSetMutation
//				  usingObjects:value];
//}

@end
