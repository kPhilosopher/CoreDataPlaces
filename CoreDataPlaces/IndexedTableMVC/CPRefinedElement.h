//
//  CPRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import <Foundation/Foundation.h>

@interface CPRefinedElement : NSObject <NSCopying>

#pragma mark - Property

@property (retain) NSDictionary *dictionary;
@property (copy) NSString *comparable;
@property NSInteger sectionNumber;

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement;

#pragma mark - Recommended to override

- (id)copyWithZone:(NSZone *)zone;

@end
