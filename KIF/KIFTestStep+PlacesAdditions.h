//
//  KIFTestStep+PlacesAdditions.h
//  Places_09
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KIFTestStep.h"

@interface KIFTestStep (PlacesAdditions)

// Factory Steps

+ (id)stepToReset;

// Step Collections

// Assumes the application was reset and sitting at the welcome screen
+ (NSArray *)stepsToGoToLoginPage;

@end