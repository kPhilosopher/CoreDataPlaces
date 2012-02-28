//
//  CPMostRecentPhotosRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

//#import "CPRefinedElement.h"
#import <Foundation/Foundation.h>


@interface CPMostRecentPhotosRefinedElement : NSObject

#pragma mark - Property

@property (copy, readonly) NSString *comparable;
@property (retain) id rawElement;

#pragma mark - Instance method

- (void)setComparableWithRawElement;

@end
