//
//  CPFlickrDataSource.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/26/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPFlickrDataSource-Internal.h"
#import "CPFlickrDataHandler.h"


@interface CPFlickrDataSource ()
{
@private
	NSArray *CP_flickrTopPlaces;
//    NSMutableArray *CP_flickrMostRecentPlacesArray;
	NSMutableArray *CP_theElementSectionsOfFlickrTopPlaces;
//	NSMutableArray *CP_theElementSectionsOfFlickrMostRecentPlaces;
//	NSMutableSet *CP_flickrMostRecentPlacesSet;
	CPFlickrDataHandler *CP_flickrDataHandler;
	NSString *CP_alertViewSwitch;
}

//extern NSString *CPKeyForMostRecentArray;
//extern NSString *CPKeyForMostRecentSet;

#pragma mark - Property

//@property (nonatomic, retain) NSMutableSet *flickrMostRecentPlacesSet;
@property (nonatomic, retain) CPFlickrDataHandler *flickrDataHandler;

@end

#pragma mark -

@implementation CPFlickrDataSource

@synthesize flickrTopPlaces = CP_flickrTopPlaces;
//@synthesize flickrMostRecentPlacesArray = CP_flickrMostRecentPlacesArray;
//@synthesize flickrMostRecentPlacesSet = CP_flickrMostRecentPlacesSet;
@synthesize theElementSectionsOfFlickrTopPlaces = CP_theElementSectionsOfFlickrTopPlaces;
//@synthesize theElementSectionsOfFlickrMostRecentPlaces = CP_theElementSectionsOfFlickrMostRecentPlaces;
@synthesize flickrDataHandler = CP_flickrDataHandler;
@synthesize alertViewSwitch = CP_alertViewSwitch;

//const int CPMaximumOfMostRecentPlacesList = 10;
//const int CPIndexIsNegativeOne = -1;

//NSString *CPKeyForMostRecentArray = @"mostRecentArrayKey";
//NSString *CPKeyForMostRecentSet = @"mostRecentSetKey";
//TODO: change the location of this extern
//NSString *CPPlaceID = @"place_id";
NSString *CPAlertSwitchOff = @"AlertOff";
NSString *CPAlertSwitchOn = @"AlertOn";

#pragma mark - Initialization sequence

- (id)initWithFlickrDataHandler:(CPFlickrDataHandler *)flickrDataHandler;
{
	self = [super init];
	self.flickrDataHandler = flickrDataHandler;
	self.alertViewSwitch = CPAlertSwitchOff;
	return self;
}

#pragma mark - Object lifecycle

- (void)dealloc
{
//	[CP_flickrMostRecentPlacesArray release];
//	[CP_flickrMostRecentPlacesSet release];
	[CP_flickrTopPlaces release];
	[super dealloc];
}

#pragma mark - Data setup

- (void)setupFlickrTopPlacesWithFlickrFetcher;
{
	//setup so that the following statements can be executed in another thread.
	id undeterminedFlickrTopPlaces = [self.flickrDataHandler flickrTopPlaces];
	if ([undeterminedFlickrTopPlaces isKindOfClass:[NSArray class]])
	{
		self.flickrTopPlaces = (NSArray *)undeterminedFlickrTopPlaces;
	}
	else	[self CP_mutateKeyValueObservedPropertyAlertViewSwitchToAlertSwitchOn];
}

//- (void)setupThePropertiesOfMostRecentPlacesWithNSUserDefaults;
//{
//	self.flickrMostRecentPlacesArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:CPKeyForMostRecentArray]];
//	self.flickrMostRecentPlacesSet = [NSMutableSet setWithSet:[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:CPKeyForMostRecentSet]]];
//}

#pragma mark - Flickr Public Method

- (NSArray *)photoListWithFlickrPlaceID:(NSString *)placeID
{
	NSArray *flickrPhotoList = nil;
	id undeterminedFlickrPhotoList = [self.flickrDataHandler photoListWithPlaceIDString:placeID];
	if ([undeterminedFlickrPhotoList isKindOfClass:[NSArray class]])
		flickrPhotoList = (NSArray *)undeterminedFlickrPhotoList;
	else
		[self CP_mutateKeyValueObservedPropertyAlertViewSwitchToAlertSwitchOn];
	return flickrPhotoList;
}

//- (void)addToTheMostRecentPlacesCollectionsTheFollowingDictionary:(NSDictionary *)dictionary;
//{
//	NSString *placeID;
//	id undeterminedPlaceID = [dictionary objectForKey:CPPlaceID];
//	if ([undeterminedPlaceID isKindOfClass:[NSString class]])
//	{
//		placeID = (NSString *)undeterminedPlaceID;
//		[self RD_determineIfMostRecentPlacesSetIncludesPlaceIDString:placeID];
//		[self RD_enqueueIntoTheMostRecentPlacesArrayTheFollowingDictionary:dictionary];
//		[self RD_dequeueIfTheMostRecentPlacesArrayReachesMaximumSize];
//		[self CP_updateMostRecentPlacesCollectionsInStandardUserDefaults];
//	}
//	//TODO: should I notify the user about a corrupt dictionary?
//}
//
//
//- (void)removeFromTheMostRecentPlacesCollectionsTheFollowingDictionary:(NSDictionary *)dictionaryToDelete;
//{
//	//	[self.flickrMostRecentPlacesSet removeObject:[dictionaryToDelete valueForKey:CPPlaceID]];
//	if ([self.flickrMostRecentPlacesSet member:[dictionaryToDelete valueForKey:CPPlaceID]])
//	{
//		int indexToRemove = [self CP_indexOfFlickrMostRecentPlacesArrayContainingPlaceIDString:
//							 [dictionaryToDelete valueForKey:CPPlaceID]];
//		if ([self RD_nonNegativeValueIsReturnedWithIndexToRemove:indexToRemove])
//		{
//			[self.flickrMostRecentPlacesSet removeObject:[dictionaryToDelete valueForKey:CPPlaceID]];
//			[self.flickrMostRecentPlacesArray removeObjectAtIndex:indexToRemove];
//			[self CP_updateMostRecentPlacesCollectionsInStandardUserDefaults];
//		}
//	}
//}

#pragma mark - Internal method

- (void)CP_mutateKeyValueObservedPropertyAlertViewSwitchToAlertSwitchOn;
{
	self.alertViewSwitch = CPAlertSwitchOn;
}

//- (void)CP_updateMostRecentPlacesCollectionsInStandardUserDefaults;
//{
//	[[NSUserDefaults standardUserDefaults] setObject:self.flickrMostRecentPlacesArray forKey:CPKeyForMostRecentArray];
//	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.flickrMostRecentPlacesSet] forKey:CPKeyForMostRecentSet];
//	[[NSUserDefaults standardUserDefaults] synchronize];
//}

//- (int)CP_indexOfFlickrMostRecentPlacesArrayContainingPlaceIDString:(NSString *)placeID;
//{
//	int indexToRemove = CPIndexIsNegativeOne;
//	for (int counter = 0; self.flickrMostRecentPlacesArray.count > counter ; counter++) 
//	{
//		if ([[self.flickrMostRecentPlacesArray objectAtIndex:counter] isKindOfClass:[NSDictionary class]])
//		{
//			NSDictionary *dictionary = [self.flickrMostRecentPlacesArray objectAtIndex:counter];
//			if ([[dictionary objectForKey:CPPlaceID] isEqual:placeID])
//			{
//				indexToRemove = counter;
//				[self RD_jumpOutOfForLoopWithCounter:counter];
//			}
//		}
//	}
//	return indexToRemove;
//}

#pragma mark - Readability method

//- (void)RD_jumpOutOfForLoopWithCounter:(int)counter;
//{
//	counter = self.flickrMostRecentPlacesArray.count;
//}
//
//- (void)RD_determineIfMostRecentPlacesSetIncludesPlaceIDString:(NSString *)placeID;
//{
//	if ([self.flickrMostRecentPlacesSet containsObject:placeID])
//		[self RD_removeFromFlickrMostRecentPlacesArrayTheDictionaryWithTheFollowingPlaceIDString:placeID];
//	else	
//		[self.flickrMostRecentPlacesSet addObject:placeID];
//}
//- (void)RD_removeFromFlickrMostRecentPlacesArrayTheDictionaryWithTheFollowingPlaceIDString:(NSString *)placeID;
//{
//	int indexToRemove = [self CP_indexOfFlickrMostRecentPlacesArrayContainingPlaceIDString:placeID];
//	if (indexToRemove != CPIndexIsNegativeOne)
//		[self.flickrMostRecentPlacesArray removeObjectAtIndex:indexToRemove];
//}
//- (void)RD_enqueueIntoTheMostRecentPlacesArrayTheFollowingDictionary:(NSDictionary *)dictionary;
//{
//	[self.flickrMostRecentPlacesArray insertObject:dictionary atIndex:0];
//}
//- (void)RD_dequeueIfTheMostRecentPlacesArrayReachesMaximumSize;
//{
//	if ([self.flickrMostRecentPlacesArray count] > CPMaximumOfMostRecentPlacesList) 
//		[self.flickrMostRecentPlacesArray removeLastObject];
//}
//
//- (BOOL)RD_nonNegativeValueIsReturnedWithIndexToRemove:(int)indexToRemove;
//{
//	return (indexToRemove > CPIndexIsNegativeOne);
//}

#pragma mark - Property

//- (NSMutableArray *)flickrMostRecentPlacesArray
//{
//	if (!CP_flickrMostRecentPlacesArray)
//		CP_flickrMostRecentPlacesArray = [[NSMutableArray alloc] init];
//	return CP_flickrMostRecentPlacesArray;
//}
//
//- (NSMutableSet *)flickrMostRecentPlacesSet
//{
//	if (!CP_flickrMostRecentPlacesSet)
//		CP_flickrMostRecentPlacesSet = [[NSMutableSet alloc] init];
//	return CP_flickrMostRecentPlacesSet;
//}

@end
