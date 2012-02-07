//
//  Photo.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/7/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSNumber * timeLapseSinceLastView;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * timeLapseSinceUpload;
@property (nonatomic, retain) Place *itsPlace;

@end
