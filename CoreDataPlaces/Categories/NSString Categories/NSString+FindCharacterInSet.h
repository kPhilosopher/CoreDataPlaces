//
//  NSString+FindCharacterInSet.h
//  Places_09
//
//  Created by Jinwoo Baek on 1/8/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FindCharacterInSet)

#pragma mark - Public method

- (BOOL)enumerateStringToDetermineTheExistanceOfCharacterInSet:(NSCharacterSet *)aSet;

@end
