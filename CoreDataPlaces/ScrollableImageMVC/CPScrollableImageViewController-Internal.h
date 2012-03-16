//
//  CPScrollableImageViewController-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/5/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CPScrollableImageViewController.h"

@interface CPScrollableImageViewController()

#pragma mark - Property

@property (retain) UIImage *image;
@property (retain) UIImageView *imageView;
@property (retain) UIPopoverController *popoverController;
@property (retain) Photo *queuedPhoto;

#pragma mark - Internal method

- (CGRect)CP_getTheRectSizeThatWillUtilizeTheScreenSpace;
- (void)CP_setTheZoomScales;

@end
