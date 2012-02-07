//
//  Photo.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/6/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CPRefinedElementInterfacing.h"


@class Place;

@interface Photo : NSManagedObject <CPRefinedElementInterfacing>

@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSString * photoURL;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * timeLapseSinceLastView;
@property (nonatomic, retain) NSString * timeLapseSinceUpload;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Place *itsPlace;

@end
