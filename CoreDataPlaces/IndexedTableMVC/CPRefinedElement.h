//
//  CPRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPRefinedElementInterfacing.h"

@interface CPRefinedElement : NSObject <NSCopying, CPRefinedElementInterfacing>
{
	@protected
	NSString *CP_title;
	NSString *CP_subtitle;
}

#pragma mark - Property

@property (copy) NSString *title;
@property (copy) NSString *subtitle;
@property (copy) NSString *comparable;
@property (retain) NSDictionary *dictionary;
@property NSInteger sectionNumber;

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement;

#pragma mark - Recommended to override

- (id)copyWithZone:(NSZone *)zone;

@end
