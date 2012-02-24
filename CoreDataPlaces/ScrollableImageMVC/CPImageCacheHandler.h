//
//  CPImageCacheHandler.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/16/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CPImageCacheHandler : NSObject

#pragma mark - Instance method

- (void)cacheImage:(NSString *)imageLocation UIImage:(UIImage *)image;
- (UIImage *)getCachedImage:(NSString *)imageLocation;
- (BOOL)deleteCacheImage:(NSString *)imageLocation;

@end
