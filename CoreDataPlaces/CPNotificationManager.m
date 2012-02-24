//
//  CPNotificationManager.m
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/18/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPNotificationManager.h"


static CPNotificationManager *sharedNotificationManager = nil;

@interface CPNotificationManager ()

extern NSString *CPAlertTitle;
extern NSString *CPAlertMessage;

@end

#pragma mark -

@implementation CPNotificationManager

NSString *CPAlertTitle = @"Cannot Obtain Data";
NSString *CPAlertMessage = @"We couldn't get the data from Flickr";
NSString *CPNetworkErrorOccuredNotification = @"NetworkErrorOccured";

#pragma mark - Class method

+ (CPNotificationManager*)sharedManager;
{
    if (sharedNotificationManager == nil)
	{
        sharedNotificationManager = [[super allocWithZone:NULL] init];
		[[NSNotificationCenter defaultCenter] addObserver:sharedNotificationManager selector:@selector(displayNetworkErrorAlert:) name:CPNetworkErrorOccuredNotification object:nil];
    }
    return sharedNotificationManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedManager] retain];
}

#pragma mark - Instance method

- (void)dealloc;
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

- (void)displayNetworkErrorAlert:(NSNotification *)notification;
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:CPAlertTitle message:CPAlertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];	
	[alert show];
	[alert release];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end
