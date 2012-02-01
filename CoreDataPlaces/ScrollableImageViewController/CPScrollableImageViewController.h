//
//  CPScrollableImageViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPScrollableImageViewController : UIViewController <UIScrollViewDelegate, UISplitViewControllerDelegate>

extern NSString *ScrollableImageViewAccessibilityLabel;
extern NSString *ScrollableImageBackBarButtonAccessibilityLabel;

#pragma mark - Property

@property (retain) UIImageView *imageView;
@property (retain) NSDictionary *imageDictionary;

#pragma mark - Instance method

-(void) initiateTheImageSetupWithGiven:(UIImage *)givenImage;

@end
