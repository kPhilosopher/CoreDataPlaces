//
//  Place.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/9/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Place : NSManagedObject

#pragma mark - Property

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSNumber * hasFavoritePhoto;
@property (nonatomic, retain) NSString * placeID;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *photos;

#pragma mark - Instance method

- (void)checkPhotosToEnsureFavoritePlace;

@end

@interface Place (CoreDataGeneratedAccessors)

#pragma mark - Accessor method

- (NSMutableSet*)primitivePhotos;
- (void)setPrimitivePhotos:(NSMutableSet*)value;

@end
