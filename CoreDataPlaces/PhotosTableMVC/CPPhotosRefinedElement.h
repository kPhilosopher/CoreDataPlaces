//
//  CPPhotosRefinedElement.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/27/12.
//

#import <Foundation/Foundation.h>
#import "CPRefinedElement.h"

@interface CPPhotosRefinedElement : CPRefinedElement

#pragma mark - Property

@property (copy) NSString *title;
@property (copy) NSString *subtitle;

#pragma mark - Instance method

- (NSComparisonResult)compare:(CPPhotosRefinedElement *)aRefinedElementPicture;

@end
