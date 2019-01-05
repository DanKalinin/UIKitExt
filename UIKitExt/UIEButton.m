//
//  UIEButton.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/1/19.
//

#import "UIEButton.h"










@implementation UIButton (UIE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIEButtonOperation.class;
}

@end










@interface UIEButton ()

@property NSString *uieStringTag;
@property UIButton *uieButton1;
@property UIColor *uieDefaultBackgroundColor;
@property UIColor *uieHighlightedBackgroundColor;
@property UIColor *uieSelectedBackgroundColor;
@property UIColor *uieDisabledBackgroundColor;
@property UIColor *uieDefaultLayerBorderColor;
@property UIColor *uieHighlightedLayerBorderColor;
@property UIColor *uieSelectedLayerBorderColor;
@property UIColor *uieDisabledLayerBorderColor;

@end



@implementation UIEButton

- (void)setEnabled:(BOOL)enabled {
    super.enabled = enabled;
    
    self.nseOperation.enabled = enabled;
}

- (void)setSelected:(BOOL)selected {
    super.selected = selected;
    
    self.nseOperation.selected = selected;
}

- (void)setHighlighted:(BOOL)highlighted {
    super.highlighted = highlighted;
    
    self.nseOperation.highlighted = highlighted;
}

@end










@interface UIEButtonOperation ()

@end



@implementation UIEButtonOperation

@dynamic delegates;
@dynamic object;

- (void)touchUpInside:(UIButton *)sender event:(UIEvent *)event {
    [super touchUpInside:sender event:event];
    
    [self.delegates uieButtonTouchUpInside:sender];
}

@end
