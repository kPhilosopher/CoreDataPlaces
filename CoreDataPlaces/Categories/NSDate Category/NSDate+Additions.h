//
//  NSDate+Additions.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/19/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (Additions)

#pragma mark - Class method

+ (NSDate *)dateOfTimeIntervalBetweenNowAndHoursAgo:(int)hour;

@end