//
//  CircleControl.h
//  SectorControl
//
//  Created by Dan Kalinin on 2/9/17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>










@interface CircleControl : UIControl

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property IBInspectable CGFloat circleWidth;
@property IBInspectable CGFloat minAngle;
@property IBInspectable CGFloat maxAngle;
@property IBInspectable CGFloat angularStep;
@property IBInspectable BOOL respectBounds;
@property IBInspectable CGFloat initialAngle;

@property (readonly) CGFloat angle;
- (void)setAngle:(CGFloat)angle animated:(BOOL)animated;

@end










@interface CircleValueControl : CircleControl

@property IBInspectable CGFloat minValue;
@property IBInspectable CGFloat maxValue;
@property IBInspectable CGFloat valueStep;
@property IBInspectable CGFloat initialValue;

@property (readonly) CGFloat value;
- (void)setValue:(CGFloat)value animated:(BOOL)animated;

@end
