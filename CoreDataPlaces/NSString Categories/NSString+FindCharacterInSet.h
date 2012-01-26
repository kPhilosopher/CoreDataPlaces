//
//  NSString+FindCharacterInSet.h
//  Places_09
//
//  Created by Jinwoo Baek on 1/8/12.
//

#import <Foundation/Foundation.h>

@interface NSString (FindCharacterInSet)

#pragma mark - Public method

- (BOOL)enumerateStringToDetermineTheExistanceOfCharacterInSet:(NSCharacterSet *)aSet;

@end
