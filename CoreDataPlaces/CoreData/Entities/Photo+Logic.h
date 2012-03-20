//
//  Photo+TimeLapseCalculator.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "Photo.h"


@interface Photo (Logic)

@end

#pragma mark -

@interface Photo ()

#pragma mark - Primitive accessor method

- (Place *)primitiveItsPlace;
- (void)setPrimitiveItsPlace:(Place *)itsPlace;

- (NSNumber *)primitiveIsFavorite;
- (void)setPrimitiveIsFavorite:(NSNumber *)isFavorite;

@end