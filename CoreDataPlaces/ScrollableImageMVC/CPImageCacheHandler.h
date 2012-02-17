//
//  CPImageCacheHandler.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/16/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CPImageCacheHandler : NSObject

#pragma mark - Instance method

- (void)cacheImage:(NSString *)imageLocation;
- (UIImage *)getCachedImage:(NSString *)imageLocation;

@end
