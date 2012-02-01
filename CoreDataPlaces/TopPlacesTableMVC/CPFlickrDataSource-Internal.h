//
//  CPFlickrDataSource-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/26/12.
//

#import "CPFlickrDataSource.h"

@interface CPFlickrDataSource ()

#pragma mark - Internal method

//- (void)CP_updateMostRecentPlacesCollectionsInStandardUserDefaults;
//- (int)CP_indexOfFlickrMostRecentPlacesArrayContainingPlaceIDString:(NSString *)placeID;
- (void)CP_mutateKeyValueObservedPropertyAlertViewSwitchToAlertSwitchOn;

#pragma mark - Readability method

//- (void)RD_removeFromFlickrMostRecentPlacesArrayTheDictionaryWithTheFollowingPlaceIDString:(NSString *)placeID;
//- (void)RD_enqueueIntoTheMostRecentPlacesArrayTheFollowingDictionary:(NSDictionary *)dictionary;
//- (void)RD_dequeueIfTheMostRecentPlacesArrayReachesMaximumSize;
//- (void)RD_determineIfMostRecentPlacesSetIncludesPlaceIDString:(NSString *)placeID;
//- (void)RD_jumpOutOfForLoopWithCounter:(int)counter;
//- (BOOL)RD_nonNegativeValueIsReturnedWithIndexToRemove:(int)indexToRemove;

@end
