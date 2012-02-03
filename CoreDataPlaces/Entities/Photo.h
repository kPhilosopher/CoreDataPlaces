//
//  Photo.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/31/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * timeLapseSinceLastView;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSDate * timeLapseSinceUpload;
@property (nonatomic, retain) Place *itsPlace;

@end
