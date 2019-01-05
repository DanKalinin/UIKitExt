//
//  UIEButton.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/1/19.
//

#import <UIKit/UIKit.h>
#import "UIEControl.h"

@class UIEButton;
@class UIEButtonOperation;

@protocol UIEButtonDelegate;










@interface UIButton (UIE)

@property (readonly) UIEButtonOperation *nseOperation;

@end










@interface UIEButton : UIButton

@end










@protocol UIEButtonDelegate <UIEControlDelegate>

@optional
- (void)uieButtonTouchUpInside:(UIButton *)button;

@end



@interface UIEButtonOperation : UIEControlOperation <UIEButtonDelegate>

@property (readonly) HLPArray<UIEButtonDelegate> *delegates;

@property (weak, readonly) UIButton *object;

@end
