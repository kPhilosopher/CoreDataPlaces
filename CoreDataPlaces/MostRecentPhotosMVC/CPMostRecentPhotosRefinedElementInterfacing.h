//
//  CPMostRecentPhotosRefinedElementInterfacing.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/2/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPMostRecentPhotosRefinedElement;

@protocol CPMostRecentPhotosRefinedElementInterfacing <NSObject>

@required

#pragma mark - Property

@property (copy) NSString *comparable;
@property (retain) id rawElement;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property NSInteger sectionNumber;

#pragma mark - Instance method

- (id)copyWithZone:(NSZone *)zone;
- (NSComparisonResult)compare:(CPMostRecentPhotosRefinedElement *)refinedElement;

@end
