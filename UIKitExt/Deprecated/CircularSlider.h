//
//  CircularSlider.h
//  Control
//
//  Created by Dan Kalinin on 12/21/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>










@interface CircularSlider : UIControl

@property (nonatomic) IBInspectable CGFloat radius;
@property (nonatomic) IBInspectable CGFloat phase;

@property (readonly) CGFloat angle;
- (void)setAngle:(CGFloat)angle animated:(BOOL)animated;

@end










@interface CircularValueSlider : CircularSlider

@property IBInspectable UIFloatRange valueRange;
@property IBInspectable BOOL mirrored;

@property (readonly) CGFloat value;
- (void)setValue:(CGFloat)value animated:(BOOL)animated;

@end
