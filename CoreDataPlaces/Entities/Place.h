//
//  Place.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 1/31/12.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * placeID;
@property (nonatomic, retain) NSNumber * hasFavoritePhoto;
@property (nonatomic, retain) NSSet *photos;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
