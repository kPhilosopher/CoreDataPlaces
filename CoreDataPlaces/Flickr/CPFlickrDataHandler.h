//
//  CPFlickrDataHandler.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/26/12.
//

#import <Foundation/Foundation.h>
#import "FlickrFetcher.h"

@interface CPFlickrDataHandler : NSObject

#pragma mark - Instance method.

- (NSArray *)flickrTopPlaces;

- (NSArray *)photoListWithPlaceIDString:(NSString *)flickrPlaceId;

@end
