//
//  OnboardingPVC.h
//  SmartHome
//
//  Created by Dan Kalinin on 1/13/17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"



@interface PageVC : ViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property IBInspectable NSInteger currentPage;
@property IBInspectable BOOL recursive;

@property (readonly) UIPageViewController *pageViewController;
@property (readonly) NSArray *pages;
@property (readonly) UIViewController *page;

- (void)setPage:(UIViewController *)page animated:(BOOL)animated;
- (void)setNextPage:(BOOL)animated;
- (void)setPreviousPage:(BOOL)animated;

- (void)pageDidSet; // Use to configure static content. Called from -viewDidLoad and -pageViewController:didFinishAnimating:previousViewControllers:transitionCompleted: methods.

@end
