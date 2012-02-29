//
//  CPPhotoInterface.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/27/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol CPPhotoInterfacing <NSObject>

@property (nonatomic, retain) NSDate *timeOfLastView;
@property (nonatomic, retain) NSDate *timeOfUpload;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (BOOL)isKindOfClass:(Class)aClass;

@end
