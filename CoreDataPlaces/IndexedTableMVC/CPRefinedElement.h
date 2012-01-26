//
//  CPRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import <Foundation/Foundation.h>

@interface CPRefinedElement : NSObject <NSCopying>

@property (retain) NSDictionary *dictionary;
@property NSInteger sectionNumber;
@property (copy) NSString *comparable;

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement;

@end
