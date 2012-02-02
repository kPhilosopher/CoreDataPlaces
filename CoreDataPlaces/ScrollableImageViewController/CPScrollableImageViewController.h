//
//  CPScrollableImageViewController.h
//  CoreDataPlaces
//
//  Created by Jinwoo Baek on 2/1/12.
//

#import <UIKit/UIKit.h>

@interface CPScrollableImageViewController : UIViewController <UIScrollViewDelegate, UISplitViewControllerDelegate>

extern NSString *ScrollableImageViewAccessibilityLabel;
extern NSString *ScrollableImageBackBarButtonAccessibilityLabel;

#pragma mark - Property

@property (retain) NSDictionary *imageDictionary;
@property (retain) IBOutlet UIImageView *imageView;
@property (retain) IBOutlet UIScrollView *scrollView;
@property (retain) IBOutlet UISwitch *switchForFavorite;

#pragma mark - Instance method

//-(void) initiateTheImageSetupWithGiven:(UIImage *)givenImage;

@end
