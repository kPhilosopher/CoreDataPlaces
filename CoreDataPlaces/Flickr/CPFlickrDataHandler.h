//
//  CPFlickrDataHandler.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrFetcher.h"

@interface CPFlickrDataHandler : NSObject

#pragma mark - Instance method.

- (NSArray *)flickrTopPlaces;

- (NSArray *)flickrPhotoListWithPlaceID:(NSString *)flickrPlaceId;

@end
