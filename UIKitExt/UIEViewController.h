//
//  UIEViewController.h
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEResponder.h"
#import "UIEView.h"

@class UIEViewController;
@class UIEViewControllerPrepareForSegue;
@class UIEViewControllerOperation;

@protocol UIEViewControllerDelegate;










@interface UIViewController (UIE) <UIEViewDelegate>

@property (readonly) UIEViewControllerOperation *nseOperation;

@end










@interface UIEViewController : UIViewController

@end










@interface UIEViewControllerPrepareForSegue : NSEObject

@property (readonly) UIStoryboardSegue *segue;
@property (readonly) id sender;

- (instancetype)initWithSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end










@protocol UIEViewControllerDelegate <UIEResponderDelegate>

@end



@interface UIEViewControllerOperation : UIEResponderOperation <UIEViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (weak, readonly) UIViewController *object;
@property (weak, readonly) UIEViewControllerPrepareForSegue *prepareForSegue;

- (void)viewDidLoad;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
