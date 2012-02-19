//
//  CPNotificationManager.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/18/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPNotificationManager : NSObject

extern NSString *CPNetworkErrorOccuredNotification;

#pragma mark - Class method

+ (CPNotificationManager*)sharedManager;

@end
