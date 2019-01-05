//
//  UIEPasscodeView.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/5/19.
//

#import "UIEControl.h"
#import "UIEButton.h"

@class UIEPasscodeView;
@class UIEPasscodeViewOperation;

@protocol UIEPasscodeViewDelegate;










@interface UIEPasscodeView : UIEControl

@property IBOutlet UILabel *labelError;
@property IBOutlet UIButton *buttonDelete;

@property IBOutletCollection(UILabel) NSArray<UILabel *> *labels;
@property IBOutletCollection(UIButton) NSArray<UIButton *> *buttons;

@property (readonly) UIEPasscodeViewOperation *nseOperation;

@end










@protocol UIEPasscodeViewDelegate <UIEControlDelegate>

@optional
- (void)uiePasscodeViewEditingDidBegin:(UIEPasscodeView *)passcodeView;
- (void)uiePasscodeViewEditingChanged:(UIEPasscodeView *)passcodeView;
- (void)uiePasscodeViewEditingDidEnd:(UIEPasscodeView *)passcodeView;

- (void)uiePasscodeViewDidResetWithError:(UIEPasscodeView *)passcodeView;

@end



@interface UIEPasscodeViewOperation : UIEControlOperation <UIEPasscodeViewDelegate, UIEButtonDelegate>

@property (readonly) HLPArray<UIEPasscodeViewDelegate> *delegates;
@property (readonly) NSMutableString *passcode;
@property (readonly) UINotificationFeedbackGenerator *generator;

@property (weak, readonly) UIEPasscodeView *object;

- (void)reset;
- (void)resetWithError:(NSString *)error;

@end
