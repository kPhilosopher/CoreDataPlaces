//
//  CPRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

// !!!:This is an abstract class. It must be subclassed with appropriate implementation.

#import <Foundation/Foundation.h>


@interface CPRefinedElement : NSObject <NSCopying>

#pragma mark - Property

@property (copy) NSString *comparable;
@property (retain) id rawElement;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property NSInteger sectionNumber;

#pragma mark - Instance method

- (id)copyWithZone:(NSZone *)zone;
- (NSComparisonResult)compare:(CPRefinedElement *)refinedElement;

@end
