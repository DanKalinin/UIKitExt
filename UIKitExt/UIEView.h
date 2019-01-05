//
//  UIEView.h
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import <UIKit/UIKit.h>
#import "UIEResponder.h"

@class UIEView;
@class UIEViewOperation;

@protocol UIEViewDelegate;










@interface UIView (UIE)

@property (readonly) UIEViewOperation *nseOperation;

@property IBInspectable UIColor *uieLayerBorderColor;
@property IBInspectable NSString *uieStringTag;

@property IBOutlet UIButton *uieButton1;
@property IBOutlet UIButton *uieButton2;

@property IBOutlet UITextField *uieTextField1;

@property IBOutlet UIActivityIndicatorView *uieActivityIndicatorView1;

@end










@interface UIEView : UIView

@end










@protocol UIEViewDelegate <UIEResponderDelegate>

@end



@interface UIEViewOperation : UIEResponderOperation <UIEViewDelegate>

@property (weak, readonly) UIView *object;

@end
