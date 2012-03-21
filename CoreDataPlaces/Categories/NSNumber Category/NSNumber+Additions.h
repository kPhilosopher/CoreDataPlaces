//
//  NSNumber+Additions.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/19/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNumber (Additions)

#pragma mark - Class method

+ (NSNumber *)numberInHoursWithDateComponents:(NSDateComponents *)dateComponents;

@end
