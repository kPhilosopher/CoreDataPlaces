//
//  CPRefinedElementInterfacing.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/6/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CPRefinedElement;

@protocol CPRefinedElementInterfacing <NSObject>

@required

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
