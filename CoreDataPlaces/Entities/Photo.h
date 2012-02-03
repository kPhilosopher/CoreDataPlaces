//
//  Photo.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/2/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Place;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSDate * timeLapseSinceLastView;
@property (nonatomic, retain) NSDate * timeLapseSinceUpload;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Place *itsPlace;

@end
