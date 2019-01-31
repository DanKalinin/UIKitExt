//
//  UIEView.m
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEView.h"










@implementation UIView (UIE)

@dynamic uieOperation;
@dynamic uieStringTag;
@dynamic uieButton1;
@dynamic uieButton2;
@dynamic uieTextField1;
@dynamic uieActivityIndicatorView1;

- (Class)uieOperationClass {
    return UIEViewOperation.class;
}

- (UIColor *)uieLayerBorderColor {
    UIColor *uieLayerBorderColor = [UIColor colorWithCGColor:self.layer.backgroundColor];
    return uieLayerBorderColor;
}

- (void)setUieLayerBorderColor:(UIColor *)uieLayerBorderColor {
    self.layer.borderColor = uieLayerBorderColor.CGColor;
}

@end










@interface UIEView ()

@end



@implementation UIEView

@end










@interface UIEViewOperation ()

@end



@implementation UIEViewOperation

@dynamic object;

@end
