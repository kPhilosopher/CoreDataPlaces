//
//  NSDate+HourComparator.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/12/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HourComparator)

- (NSComparisonResult)compareHoursOfTimeInterval:(NSDate *)date;

@end
