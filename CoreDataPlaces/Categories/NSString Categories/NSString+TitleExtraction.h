//
//  NSString+TitleExtractor.h
//  Places
//
//  Created by Jinwoo Baek on 12/26/11.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TitleExtraction)

#pragma mark - Class method

+ (NSCharacterSet *)characterSetWithComma;

#pragma mark - Public method

- (NSString *)initialStringWithDelimiterSet:(NSCharacterSet *)aSet;

@end
