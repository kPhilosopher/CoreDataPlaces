//
//  CPFlickrDataSource.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/26/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPFlickrDataHandler.h"

@interface CPFlickrDataSource : NSObject

extern NSString *CPAlertSwitchOff;
extern NSString *CPAlertSwitchOn;
extern NSString *CPPlaceID;

#pragma mark - Property

@property (nonatomic, retain) NSArray *flickrTopPlaces;
@property (nonatomic, retain) NSMutableArray *flickrMostRecentPlacesArray;
@property (nonatomic, retain) NSMutableArray *theElementSectionsOfFlickrTopPlaces;
@property (nonatomic, retain) NSMutableArray *theElementSectionsOfFlickrMostRecentPlaces;
@property (assign) NSString *alertViewSwitch;

#pragma mark - Public method

- (id)initWithFlickrDataHandler:(CPFlickrDataHandler *)flickrDataHandler;
- (NSArray *)photoListWithFlickrPlaceID:(NSString *)placeID;
- (void)addToTheMostRecentPlacesCollectionsTheFollowingDictionary:(NSDictionary *)dictionaryToAddToMostRecentList;
- (void)removeFromTheMostRecentPlacesCollectionsTheFollowingDictionary:(NSDictionary *)dictionaryToDelete;
//TODO: add tests for these methods.
- (void)setupFlickrTopPlacesWithFlickrFetcher;
- (void)setupThePropertiesOfMostRecentPlacesWithNSUserDefaults;

@end
