//
//  CPTableViewControllerDataMutating.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/25/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CPTableViewControllerDataMutating <NSObject>

#pragma mark - Protocol method

- (void)setTheElementSections:(NSMutableArray *)array;

- (NSMutableArray *)theElementSections;

- (NSArray *)theRawData;

@end
