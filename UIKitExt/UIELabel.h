//
//  UIELabel.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/6/19.
//

#import "UIEView.h"

@class UIELabel;
@class UIELabelOperation;










@interface UILabel (UIE)

@property (readonly) UIELabelOperation *uieOperation;

@property IBInspectable UIColor *uieDefaultBackgroundColor;
@property IBInspectable UIColor *uieHighlightedBackgroundColor;
@property IBInspectable UIColor *uieDisabledBackgroundColor;

@property IBInspectable UIColor *uieDefaultLayerBorderColor;
@property IBInspectable UIColor *uieHighlightedLayerBorderColor;
@property IBInspectable UIColor *uieDisabledLayerBorderColor;

@end










@interface UIELabel : UILabel

@end










@protocol UIELabelDelegate <UIEViewDelegate>

@end



@interface UIELabelOperation : UIEViewOperation

@property (weak, readonly) UILabel *object;

- (void)setEnabled:(BOOL)enabled;
- (void)setHighlighted:(BOOL)highlighted;

@end
