//
//  CPRefinedElement.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/24/12.
//

#import "CPRefinedElement.h"

@interface CPRefinedElement ()
{
@private
	NSDictionary *CP_dictionary;
	NSInteger CP_sectionNumber;
	NSString *CP_comparable;
}

@end

@implementation CPRefinedElement

#pragma mark - Synthesize

@synthesize dictionary = CP_dictionary;
@synthesize sectionNumber = CP_sectionNumber;
@synthesize comparable = CP_comparable;

#pragma mark - View lifecycle

- (void)dealloc
{
	[CP_comparable release];
	[CP_dictionary release];
	[super dealloc];
}

#pragma mark - Instance method

- (NSString *)extractComparableFromDictionary:(NSDictionary *)rawElement
{
	return nil;
}

#pragma mark - NSCopying protocol method

- (id)copyWithZone:(NSZone *)zone;
{
	return [[CPRefinedElement alloc] init];
}

@end
