//
//  Photo+TimeLapseCalculator.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "Photo+Logic.h"
#import "Place.h"


@implementation Photo (Logic)

#pragma mark - Object lifecycle

//- (void)awakeFromInsert;
//{
//	[super awakeFromInsert];
//	[self setTheTimeLapse];
//}
//
//- (void)awakeFromFetch;
//{
//	[super awakeFromFetch];
//	[self setTheTimeLapse];
//}

#pragma mark - Accessor method

//- (NSNumber *)timeLapseSinceUpload;
//{
////	[self setTimeLapseSinceUpload:[self timeLapseSinceDate:self.timeOfUpload]];
//	//TODO: check if this is legal.
//	[self setPrimitiveTimeLapseSinceUpload:[self CP_timeLapseSinceDate:self.timeOfUpload]];
//    [self willAccessValueForKey:@"timeLapseSinceUpload"];
//    NSNumber *hours = [self primitiveTimeLapseSinceUpload];
//    [self didAccessValueForKey:@"timeLapseSinceUpload"];
//    return hours;
//}
//
//- (void)setTimeLapseSinceUpload:(NSNumber *)timeLapseSinceUpload;
//{
//    [self willChangeValueForKey:@"timeLapseSinceUpload"];
//    [self setPrimitiveTimeLapseSinceUpload:timeLapseSinceUpload];
//    [self didChangeValueForKey:@"timeLapseSinceUpload"];
//}
//
//- (NSNumber *)timeLapseSinceLastView;
//{
////	[self setTimeLapseSinceLastView:[self timeLapseSinceDate:self.timeOfLastView]];
//	//TODO: check if this is legal.
//	[self setPrimitiveTimeLapseSinceLastView:[self CP_timeLapseSinceDate:self.timeOfLastView]];
//    [self willAccessValueForKey:@"timeLapseSinceLastView"];
//    NSNumber *hours = [self primitiveTimeLapseSinceLastView];
//    [self didAccessValueForKey:@"timeLapseSinceLastView"];
//    return hours;
//}
//
//- (void)setTimeLapseSinceLastView:(NSNumber *)timeLapseSinceLastView;
//{
//    [self willChangeValueForKey:@"timeLapseSinceLastView"];
//    [self setPrimitiveTimeLapseSinceLastView:timeLapseSinceLastView];
//    [self didChangeValueForKey:@"timeLapseSinceLastView"];
//}

- (NSNumber *)isFavorite;
{
	[self willAccessValueForKey:@"isFavorite"];
    NSNumber *boolean = [self primitiveIsFavorite];
    [self didAccessValueForKey:@"isFavorite"];
    return boolean;
}

- (void)setIsFavorite:(NSNumber *)isFavorite;
{
	Place *itsPlace = [self primitiveItsPlace];
	NSNumber *oldBoolean = [self primitiveIsFavorite];
	//TODO: if isFavorite is NO when it was previously YES, send notification to Place to check if any others are still YES.
	
	[self willChangeValueForKey:@"isFavorite"];
	[self setPrimitiveIsFavorite:isFavorite];
	[self didChangeValueForKey:@"isFavorite"];
	
	if ([isFavorite boolValue])
	{
		itsPlace.hasFavoritePhoto = isFavorite;
	}
	else if ([oldBoolean boolValue] && ![isFavorite boolValue])
	{
		[itsPlace checkPhotosToEnsureFavoritePlace];
	}
}

//- (Place *)itsPlace;
//{
//	[self willAccessValueForKey:@"itsPlace"];
//    Place *hours = [self primitiveItsPlace];
//    [self didAccessValueForKey:@"itsPlace"];
//    return hours;
//}
//
//- (void)setItsPlace:(Place *)itsPlace;
//{
//	if (![itsPlace isEqual:[self primitiveItsPlace]])
//	{
//		
//	}
//	[self willChangeValueForKey:@"itsPlace"];
//    [self setPrimitiveItsPlace:itsPlace];
//    [self didChangeValueForKey:@"itsPlace"];
//}

//
//- (void)setTheTimeLapse;
//{
//	[self setTimeLapseSinceUpload:[self CP_timeLapseSinceDate:self.timeOfUpload]];
//	[self setTimeLapseSinceLastView:[self CP_timeLapseSinceDate:self.timeOfLastView]];
//}

#pragma mark - Convenience method

//TODO: maybe accumulate these methods into a category of NSDate
//- (NSNumber *)CP_timeLapseSinceDate:(NSDate *)date;
//{
//	NSDate *endDate = [NSDate date];
//	NSDate *startDate = date;
//	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
//	NSUInteger unitFlags = NSHourCalendarUnit;
//	NSDateComponents *components = [gregorian components:unitFlags
//												fromDate:startDate
//												  toDate:endDate 
//												 options:0];
//	int number = [components hour];
//	return [NSNumber numberWithInt:number];
//}

@end
