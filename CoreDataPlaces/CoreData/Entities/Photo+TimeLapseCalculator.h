//
//  Photo+TimeLapseCalculator.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "Photo.h"


@interface Photo (TimeLapseCalculator)

#pragma mark - Property

//@property (nonatomic, readonly) NSNumber * timeLapseSinceLastView;
//@property (nonatomic, readonly) NSNumber * timeLapseSinceUpload;

#pragma mark - Instance method

- (void)setTheTimeLapse;

@end

@interface Photo ()

- (NSNumber *)primitiveTimeLapseSinceUpload;
- (void)setPrimitiveTimeLapseSinceUpload:(NSNumber *)newTimeLapseSinceUpload;
- (NSNumber *)primitiveTimeLapseSinceLastView;
- (void)setPrimitiveTimeLapseSinceLastView:(NSNumber *)newTimeLapseSinceLastView;

@end
