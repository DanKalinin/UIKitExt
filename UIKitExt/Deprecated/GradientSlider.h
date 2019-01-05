//
//  GradientSlider.h
//  Slider
//
//  Created by Dan Kalinin on 18/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GradientSlider : UIControl

@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *valueView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *valueConstraint;

@property (nonatomic) IBInspectable CGPoint valueRange;
@property IBInspectable UIColor *minimumColor;
@property IBInspectable UIColor *maximumColor;
@property IBInspectable CGFloat stepValue;
@property IBInspectable NSString *valueFormat;
@property IBInspectable BOOL continuous;
@property (readonly) CGFloat value;
- (void)setValue:(CGFloat)value animated:(BOOL)animated;

@end
