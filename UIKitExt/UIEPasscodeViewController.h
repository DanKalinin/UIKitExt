//
//  UIEPasscodeViewController.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/5/19.
//

#import "UIEViewController.h"
#import "UIEPasscodeView.h"

@class UIEPasscodeViewController;
@class UIEPasscodeViewControllerOperation;

@protocol UIEPasscodeViewControllerDelegate;










@interface UIEPasscodeViewController : UIEViewController <UIEPasscodeViewDelegate>

@property (nonatomic) UIEPasscodeView *view;

@property (readonly) UIEPasscodeViewControllerOperation *uieOperation;

@end










@protocol UIEPasscodeViewControllerDelegate <UIEViewControllerDelegate>

@end



@interface UIEPasscodeViewControllerOperation : UIEViewControllerOperation <UIEPasscodeViewControllerDelegate>

@property (weak, readonly) UIEPasscodeViewController *object;

@end
