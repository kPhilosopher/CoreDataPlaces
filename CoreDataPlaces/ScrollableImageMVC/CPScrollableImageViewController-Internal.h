//
//  CPScrollableImageViewController-Internal.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 3/5/12.
//  Copyright (c) 2012 Jinwoo Baek. All rights reserved.
//

#import "CPScrollableImageViewController.h"

@interface CPScrollableImageViewController()

#pragma mark - Property

@property (retain) UIImage *image;
@property (retain) UIImageView *imageView;
@property (retain) Photo *currentPhoto;
@property (retain) UIActivityIndicatorView *activityIndicator;

#pragma mark - Internal class method

+ (UIImage *)CP_imageDownloadWithPhotoURL:(NSString *)photoURL currentPhotoIsAFavorite:(BOOL)currentPhotoIsAFavorite;

#pragma mark - Internal method

- (void)CP_newPhotoSequence;
- (void)CP_setupTheViewHierarchyWithNewImage:(UIImage *)newImage;
- (CGRect)CP_getTheRectSizeThatWillUtilizeTheScreenSpace;
- (void)CP_setTheZoomScales;
- (void)CP_adjustToChangeInViewSize;

@end
