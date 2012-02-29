//
//  CPMostRecentPhotosRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

//#import "CPRefinedElement.h"
#import <Foundation/Foundation.h>
#import "CPRefinedElementInterfacing.h"


@interface CPMostRecentPhotosRefinedElement : NSObject <CPRefinedElementInterfacing>

#pragma mark - Property

@property (copy, readonly) NSString *comparable;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (retain) id rawElement;
@property NSInteger sectionNumber;

#pragma mark - Instance method

- (void)setComparableWithRawElement;
- (void)setTitleAndSubtitleWithRawElement;

@end
