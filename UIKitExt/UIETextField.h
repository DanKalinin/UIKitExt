//
//  UIETextField.h
//  Controls
//
//  Created by Dan Kalinin on 1/2/19.
//

#import <UIKit/UIKit.h>
#import "UIEControl.h"

@class UIETextField;
@class UIETextFieldShouldBeginEditing;
@class UIETextFieldShouldChangeCharactersInRange;
@class UIETextFieldShouldClear;
@class UIETextFieldShouldReturn;
@class UIETextFieldShouldEndEditing;
@class UIETextFieldOperation;

@protocol UIETextFieldDelegate;










@interface UITextField (UIE)

@property (readonly) UIETextFieldOperation *nseOperation;

@property IBInspectable NSString *uiePattern;
@property IBInspectable BOOL uieClearOnBegin;

@end










@interface UIETextField : UITextField

@end










@interface UIETextFieldShouldBeginEditing : NSEObject

@property BOOL should;

@end










@interface UIETextFieldShouldChangeCharactersInRange : NSEObject

@property BOOL should;

@property (readonly) NSRange range;
@property (readonly) NSString *string;

- (instancetype)initWithRange:(NSRange)range string:(NSString *)string;

@end










@interface UIETextFieldShouldClear : NSEObject

@property BOOL should;

@end










@interface UIETextFieldShouldReturn : NSEObject

@property BOOL should;

@end










@interface UIETextFieldShouldEndEditing : NSEObject

@property BOOL should;

@end










@protocol UIETextFieldDelegate <UIEControlDelegate>

@optional
- (void)uieTextFieldEditingDidBegin:(UITextField *)textField;
- (void)uieTextFieldEditingChanged:(UITextField *)textField;
- (void)uieTextFieldEditingDidEnd:(UITextField *)textField;
- (void)uieTextFieldEditingDidEndOnExit:(UITextField *)textField;

- (void)uieTextFieldShouldBeginEditing:(UITextField *)textField;
- (void)uieTextFieldShouldChangeCharactersInRange:(UITextField *)textField;
- (void)uieTextFieldShouldClear:(UITextField *)textField;
- (void)uieTextFieldShouldReturn:(UITextField *)textField;
- (void)uieTextFieldShouldEndEditing:(UITextField *)textField;

@end



@interface UIETextFieldOperation : UIEControlOperation <UIETextFieldDelegate, UITextFieldDelegate>

@property (readonly) HLPArray<UIETextFieldDelegate> *delegates;

@property (weak, readonly) UITextField *object;
@property (weak, readonly) UIETextFieldShouldBeginEditing *shouldBeginEditing;
@property (weak, readonly) UIETextFieldShouldChangeCharactersInRange *shouldChangeCharactersInRange;
@property (weak, readonly) UIETextFieldShouldClear *shouldClear;
@property (weak, readonly) UIETextFieldShouldReturn *shouldReturn;
@property (weak, readonly) UIETextFieldShouldEndEditing *shouldEndEditing;

@end
