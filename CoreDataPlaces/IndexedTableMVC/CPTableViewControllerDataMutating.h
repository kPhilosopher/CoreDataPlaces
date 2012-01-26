//
//  CPTableViewControllerDataMutating.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/25/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CPTableViewControllerDataMutating <NSObject>

#pragma mark - Protocol method

- (void)setTheElementSectionsToTheFollowingArray:(NSMutableArray *)array;
- (NSMutableArray *)fetchTheElementSections;
- (NSArray *)fetchTheRawData;

@end
