//
//  CPScrollableImageViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Photo;
@class CPPhotosRefinedElement;

//TODO: erase this when the function below is moved
@class Place;

@interface CPScrollableImageViewController : UIViewController <UIScrollViewDelegate, UISplitViewControllerDelegate>

extern NSString *CPScrollableImageViewAccessibilityLabel;
extern NSString *CPFavoriteSwitchAccessibilityLabel;

#pragma mark - Property

//@property (retain) NSDictionary *imageDictionary;
@property (retain) IBOutlet UIScrollView *scrollView;
@property (retain) IBOutlet UISwitch *switchForFavorite;
//@property (nonatomic, retain) CPPhotosRefinedElement *photoRefinedElement;
@property (retain) Photo *currentPhoto;
@property (retain) NSManagedObjectContext *managedObjectContext;

#pragma mark - Singleton

+ (CPScrollableImageViewController *)sharedInstance;

//TODO: change the location of this funciton.
+ (Photo *)photoWithPhotoRefinedElement:(CPPhotosRefinedElement *)photoRefinedElement managedObjectContext:(NSManagedObjectContext *)managedObjectContext itsPlace:(Place *)itsPlace;

#pragma mark - Instance method

- (IBAction)toggleFavoriteSwitch:(id)sender;
- (void)setNewCurrentPhoto:(Photo *)newPhoto;
- (void)setupNewPhotoWithPhotoRefinedElement:(CPPhotosRefinedElement *)photoRefinedElement place:(Place *)place;

@end
