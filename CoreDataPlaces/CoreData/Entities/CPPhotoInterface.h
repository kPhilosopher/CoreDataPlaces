//
//  CPPhotoInterface.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/27/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CPPhotoInterface <NSObject>

@property (nonatomic, retain) NSDate * timeOfLastView;
@property (nonatomic, retain) NSDate * timeOfUpload;

- (BOOL)isKindOfClass:(Class)aClass;

@end
