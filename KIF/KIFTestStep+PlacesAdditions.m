//
//  KIFTestStep+PlacesAdditions.m
//  Places_09
//
//  Created by Jinwoo Baek on 12/16/11.
//  Copyright (c) 2011 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "KIFTestStep+PlacesAdditions.h"

@implementation KIFTestStep (PlacesAdditions)

#pragma mark - Factory Steps

+ (id)stepToReset;
{
    return [KIFTestStep stepWithDescription:@"Reset the application state." executionBlock:^(KIFTestStep *step, NSError **error) {
        BOOL successfulReset = YES;
		
        // Do the actual reset for your app. Set successfulReset = NO if it fails.
		
        KIFTestCondition(successfulReset, error, @"Failed to reset some part of the application.");
		
        return KIFTestStepResultSuccess;
    }];
}

#pragma mark - Step Collections

+ (NSArray *)stepsToGoToLoginPage;
{
    NSMutableArray *steps = [NSMutableArray array];
	
    // Dismiss the welcome message
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"That's awesome!"]];
	
    // Tap the "I already have an account" button
    [steps addObject:[KIFTestStep stepToTapViewWithAccessibilityLabel:@"I already have an account."]];
	
    return steps;
}

@end