//
//  UIEWindow.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/4/19.
//

#import <UIKit/UIKit.h>
#import "UIEView.h"

@class UIEKeyboardUserInfo;
@class UIEKeyboard;

@protocol UIEKeyboardDelegate;










@interface UIEKeyboardUserInfo : NSEDictionaryObject

@property (readonly) CGRect frameBegin;
@property (readonly) CGRect frameEnd;
@property (readonly) NSTimeInterval animationDuration;
@property (readonly) UIViewAnimationCurve animationCurve;
@property (readonly) BOOL isLocal;

@end










@protocol UIEKeyboardDelegate <NSEOperationDelegate>

@optional
- (void)uieKeyboardWillShow:(UIEKeyboard *)keyboard;
- (void)uieKeyboardDidShow:(UIEKeyboard *)keyboard;
- (void)uieKeyboardWillHide:(UIEKeyboard *)keyboard;
- (void)uieKeyboardDidHide:(UIEKeyboard *)keyboard;
- (void)uieKeyboardWillChangeFrame:(UIEKeyboard *)keyboard;
- (void)uieKeyboardDidChangeFrame:(UIEKeyboard *)keyboard;

@end



@interface UIEKeyboard : NSEOperation <UIEKeyboardDelegate>

@property (readonly) HLPArray<UIEKeyboardDelegate> *delegates;

@property (weak, readonly) UIEKeyboardUserInfo *userInfo;

@end
