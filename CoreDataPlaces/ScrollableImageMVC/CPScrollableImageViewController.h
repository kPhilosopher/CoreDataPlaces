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

@interface CPScrollableImageViewController : UIViewController <UIScrollViewDelegate, UISplitViewControllerDelegate>

extern NSString *ScrollableImageViewAccessibilityLabel;
extern NSString *ScrollableImageBackBarButtonAccessibilityLabel;

#pragma mark - Property

@property (retain) NSDictionary *imageDictionary;
@property (retain) IBOutlet UIScrollView *scrollView;
@property (retain) IBOutlet UISwitch *switchForFavorite;
@property (nonatomic, retain) CPPhotosRefinedElement *photosRefinedElement;
@property (retain) Photo *currentPhoto;
@property (retain) NSManagedObjectContext *managedObjectContext;

#pragma mark - Singleton

+ (CPScrollableImageViewController *)sharedInstance;

#pragma mark - Instance method

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
//- (void)initiateTheImageSetupWithGiven:(UIImage *)givenImage;

- (IBAction)toggleFavoriteSwitch:(id)sender;

@end
