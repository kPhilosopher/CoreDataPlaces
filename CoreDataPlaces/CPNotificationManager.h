//
//  CPNotificationManager.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/18/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *CPNetworkErrorOccuredNotification;

@interface CPNotificationManager : NSObject

#pragma mark - Class method

+ (CPNotificationManager*)sharedManager;

@end
