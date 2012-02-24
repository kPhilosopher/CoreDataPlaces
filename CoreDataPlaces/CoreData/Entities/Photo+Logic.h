//
//  Photo+TimeLapseCalculator.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "Photo.h"


@interface Photo (Logic)

#pragma mark - Instance method

- (void)setTheTimeLapse;

#pragma mark - Convenience method

- (NSNumber *)CP_timeLapseSinceDate:(NSDate *)date;

@end

#pragma mark -

@interface Photo ()

#pragma mark - Primitive accessor method

- (NSNumber *)primitiveTimeLapseSinceUpload;
- (void)setPrimitiveTimeLapseSinceUpload:(NSNumber *)newTimeLapseSinceUpload;
- (NSNumber *)primitiveTimeLapseSinceLastView;
- (void)setPrimitiveTimeLapseSinceLastView:(NSNumber *)newTimeLapseSinceLastView;

- (Place *)primitiveItsPlace;
- (void)setPrimitiveItsPlace:(Place *)itsPlace;

- (NSNumber *)primitiveIsFavorite;
- (void)setPrimitiveIsFavorite:(NSNumber *)isFavorite;

@end