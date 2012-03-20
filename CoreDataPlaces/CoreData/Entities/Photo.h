//
//  Photo.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/9/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CPPhotoInterfacing.h"


@class Place;

@interface Photo : NSManagedObject <CPPhotoInterfacing>

@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSNumber * timeLapseSinceUpload;
@property (nonatomic, retain) NSNumber * timeLapseSinceLastView;
@property (nonatomic, retain) Place *itsPlace;

@end

#pragma mark -

@interface Photo (PrimitiveAccessors)

#pragma mark - Primitive accessor method

- (Place *)primitiveItsPlace;
- (void)setPrimitiveItsPlace:(Place *)itsPlace;

- (NSNumber *)primitiveIsFavorite;
- (void)setPrimitiveIsFavorite:(NSNumber *)isFavorite;

@end
