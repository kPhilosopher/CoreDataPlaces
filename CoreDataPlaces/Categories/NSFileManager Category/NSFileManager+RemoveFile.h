//
//  NSFileManager+RemoveFile.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/17/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSFileManager (RemoveFile)

#pragma mark - Class method

+ (BOOL)removeFileAtPath:(NSString *)path;

@end
