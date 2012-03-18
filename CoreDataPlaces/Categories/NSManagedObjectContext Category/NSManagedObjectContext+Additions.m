//
//  NSManagedObjectContext+Additions.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/17/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "NSManagedObjectContext+Additions.h"


@implementation NSManagedObjectContext (Additions)

#pragma mark - Internal method

- (void)processPendingChangesThenSave;
{
	[self processPendingChanges];
	NSError *error = nil;
	if (![self save:&error])
	{
		//handle the error.
		NSLog(@"%@ %@", [error localizedDescription], [error localizedFailureReason]);
	}
}

@end
