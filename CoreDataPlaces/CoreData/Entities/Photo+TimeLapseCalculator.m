//
//  Photo+TimeLapseCalculator.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "Photo+TimeLapseCalculator.h"


@implementation Photo (TimeLapseCalculator)

#pragma mark - Synthesize

- (NSNumber *)timeLapseSinceDate:(NSDate *)date;
{
	NSDate *endDate = [NSDate date];
	NSDate *startDate = date;
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	NSUInteger unitFlags = NSHourCalendarUnit;
	NSDateComponents *components = [gregorian components:unitFlags
												fromDate:startDate
												  toDate:endDate 
												 options:0];
	int number = [components hour];
	return [NSNumber numberWithInt:number];
}


- (void)setTheTimeLapse;
{
//	[self setPrimitiveTimeLapseSinceUpload:[self timeLapseSinceDate:self.timeOfUpload]];
//	[self setPrimitiveTimeLapseSinceLastView:[self timeLapseSinceDate:self.timeOfLastView]];
	[self setTimeLapseSinceLastView:[self timeLapseSinceDate:self.timeOfLastView]];
	[self setTimeLapseSinceUpload:[self timeLapseSinceDate:self.timeOfUpload]];
}


- (void)awakeFromInsert;
{
	[super awakeFromInsert];
	[self setTheTimeLapse];
}

- (void)awakeFromFetch;
{
	[super awakeFromFetch];
	[self setTheTimeLapse];
}

//@dynamic timeLapseSinceLastView;
//@dynamic timeLapseSinceUpload;

//#pragma mark - Initialization
//
//- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context;
//{
//	self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
//	if (self)
//	{
//		NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
//		NSLog(@"%@",[NSString stringWithFormat:@"Photo's init is executed."]);
//		NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
//		[self setupKeyValueObserving];
//	}
//	return self;
//}

//#pragma mark - Object lifecycle
////TODO: move this down to convenience method
//- (void)unregisterForChangeNotification
//{
//    [self removeObserver:self forKeyPath:@"timeOfUpload"];
//	[self removeObserver:self forKeyPath:@"timeOfLastView"];
//}
//
//- (void)dealloc;
//{
//	[self unregisterForChangeNotification];
//	[super dealloc];
//}

#pragma mark - Instance method





//- (void)setupKeyValueObserving;
//{
//	[self addObserver:self forKeyPath:@"timeOfUpload" options:NSKeyValueObservingOptionNew context:NULL];
//	[self addObserver:self forKeyPath:@"timeOfLastView" options:NSKeyValueObservingOptionNew context:NULL];
//}


#pragma mark - Convenience method

//- (void)setupTimeLapseSinceUpload;
//{
//	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
//	NSLog(@"%@",[NSString stringWithFormat:@"setupTimeLapseSinceUpload"]);
//	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
//	self.timeLapseSinceUpload = [self timeLapseSinceDate:self.timeOfUpload];
//	//	return [self timeLapseSinceDate:self.timeOfUpload];
//}
//
//- (void)setupTimeLapseSinceLastView;
//{
//	NSLog(@"++++++");NSLog(@"-------");NSLog(@"-------");
//	NSLog(@"%@",[NSString stringWithFormat:@"setupTimeLapseSinceLastView"]);
//	NSLog(@"-------");NSLog(@"-------");NSLog(@"++++++");
//	self.timeLapseSinceLastView = [self timeLapseSinceDate:self.timeOfLastView];
//	//	return [self timeLapseSinceDate:self.timeOfLastView];
//}

- (NSNumber *)timeLapseSinceUpload;
{
//	[self setTimeLapseSinceUpload:[self timeLapseSinceDate:self.timeOfUpload]];
	//TODO: check if this is legal.
	[self setPrimitiveTimeLapseSinceUpload:[self timeLapseSinceDate:self.timeOfUpload]];
    [self willAccessValueForKey:@"timeLapseSinceUpload"];
    NSNumber *hours = [self primitiveTimeLapseSinceUpload];
    [self didAccessValueForKey:@"timeLapseSinceUpload"];
    return hours;
}

- (void)setTimeLapseSinceUpload:(NSNumber *)timeLapseSinceUpload;
{
    [self willChangeValueForKey:@"timeLapseSinceUpload"];
    [self setPrimitiveTimeLapseSinceUpload:timeLapseSinceUpload];
    [self didChangeValueForKey:@"timeLapseSinceUpload"];
}

- (NSNumber *)timeLapseSinceLastView;
{
//	[self setTimeLapseSinceLastView:[self timeLapseSinceDate:self.timeOfLastView]];
	//TODO: check if this is legal.
	[self setPrimitiveTimeLapseSinceLastView:[self timeLapseSinceDate:self.timeOfLastView]];
    [self willAccessValueForKey:@"timeLapseSinceLastView"];
    NSNumber *hours = [self primitiveTimeLapseSinceLastView];
    [self didAccessValueForKey:@"timeLapseSinceLastView"];
    return hours;
}

- (void)setTimeLapseSinceLastView:(NSNumber *)timeLapseSinceLastView;
{
    [self willChangeValueForKey:@"timeLapseSinceLastView"];
    [self setPrimitiveTimeLapseSinceLastView:timeLapseSinceLastView];
    [self didChangeValueForKey:@"timeLapseSinceLastView"];
}


//- (NSNumber *)timeLapseSinceUpload;
//{
//	[self setTimeLapseSinceUpload:[self timeLapseSinceDate:self.timeOfUpload]];
//    [self willAccessValueForKey:@"timeLapseSinceUpload"];
//    id change = [self primitiveValueForKey:@"timeLapseSinceUpload"];
//    [self didAccessValueForKey:@"timeLapseSinceUpload"];
//	return change;
//}

//- (void)setTimeLapseSinceUpload:(NSNumber *)value;
//{
//    [self willChangeValueForKey:@"timeLapseSinceUpload"];
//    [self setPrimitiveValue:value forKey:@"timeLapseSinceUpload"];
//    [self didChangeValueForKey:@"timeLapseSinceUpload"];
//}

//- (NSNumber *)timeLapseSinceLastView;
//{
//	[self setTimeLapseSinceLastView:[self timeLapseSinceDate:self.timeOfLastView]];
//    [self willAccessValueForKey:@"timeLapseSinceLastView"];
//    id change = [self primitiveValueForKey:@"timeLapseSinceLastView"];
//    [self didAccessValueForKey:@"timeLapseSinceLastView"];
//	return change;
//}

//- (void)setTimeLapseSinceLastView:(NSNumber *)value;
//{
//    [self willChangeValueForKey:@"timeLapseSinceLastView"];
//    [self setPrimitiveValue:value forKey:@"timeLapseSinceLastView"];
//    [self didChangeValueForKey:@"timeLapseSinceLastView"];
//}

//- (NSNumber *)timeLapseSinceUpload;
//{
//	NSDate *date = self.timeOfUpload;
//	return [self timeLapseSinceDate:self.timeOfUpload];
//}
//
//- (NSNumber *)timeLapseSinceLastView;
//{
//	return [self timeLapseSinceDate:self.timeOfLastView];
//}



//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
//{
//	if ([keyPath isEqual:@"timeOfUpload"])
//	{
//		[self setupTimeLapseSinceUpload];
//    }
//	if ([keyPath isEqual:@"timeOfLastView"])
//	{
//		[self setupTimeLapseSinceLastView];
//	}
//}

@end
