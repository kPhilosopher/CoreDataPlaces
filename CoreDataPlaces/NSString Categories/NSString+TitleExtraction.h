//
//  NSString+TitleExtractor.h
//  Places_09
//
//  Created by Jinwoo Baek on 12/26/11.
//

#import <Foundation/Foundation.h>

@interface NSString (TitleExtraction)

#pragma mark - Class method

+ (NSCharacterSet *)characterSetWithComma;

#pragma mark - Public method

- (NSString *)initialStringWithDelimiterSet:(NSCharacterSet *)aSet;

@end
