//
//  CPScrollableImageViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Photo;
@class Place;
@class CPPhotosRefinedElement;

@interface CPScrollableImageViewController : UIViewController <UIScrollViewDelegate, UISplitViewControllerDelegate>

extern NSString *CPScrollableImageViewAccessibilityLabel;
extern NSString *CPFavoriteSwitchAccessibilityLabel;

#pragma mark - Property

@property (retain) IBOutlet UIScrollView *scrollView;
@property (retain) IBOutlet UISwitch *switchForFavorite;
@property (retain) NSManagedObjectContext *managedObjectContext;
@property (retain) UIPopoverController *popoverController;
@property (retain) Photo *currentPhoto;

#pragma mark - Singleton

+ (CPScrollableImageViewController *)sharedInstance;

#pragma mark - Instance method

- (IBAction)toggleFavoriteSwitch:(id)sender;
- (void)setNewCurrentPhoto:(Photo *)newPhoto;
- (void)setupNewPhotoWithPhotoRefinedElement:(CPPhotosRefinedElement *)photoRefinedElement place:(Place *)place;

@end
