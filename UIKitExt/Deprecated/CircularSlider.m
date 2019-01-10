//
//  CircularSlider.m
//  Control
//
//  Created by Dan Kalinin on 12/21/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "CircularSlider.h"
#import <FoundationExt/FoundationExt.h>










@interface CircularSlider ()

@property (nonatomic) CGFloat angle;

@end



@implementation CircularSlider {
    CGAffineTransform radiusTransform;
    CGAffineTransform angleTransform;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        radiusTransform = CGAffineTransformIdentity;
        angleTransform = CGAffineTransformIdentity;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIPanGestureRecognizer *pgr = [UIPanGestureRecognizer.alloc initWithTarget:self action:@selector(onPan:)];
    [self addGestureRecognizer:pgr];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.center = CGRectGetMidXMidY(self.superview.bounds);
}

- (void)setAngle:(CGFloat)angle animated:(BOOL)animated {
    
    _angle = angle;
    
    angleTransform = CGAffineTransformMakeRotation(angle);
    NSTimeInterval duration = 0.25 * animated;
    [UIView animateWithDuration:duration animations:^{
        self.transform = [self concatenatedTransform];
    }];
}

#pragma mark - Accessors

- (void)setRadius:(CGFloat)radius {
    
    _radius = radius;
    
    radiusTransform = CGAffineTransformMakeTranslation(radius, 0.0);
    self.transform = [self concatenatedTransform];
}

- (void)setPhase:(CGFloat)phase {
    
    _phase = phase;
    
    CGFloat angle = _angle + phase;
    [self setAngle:angle animated:NO];
}

- (CGFloat)angle {
    CGFloat angle = _angle - _phase;
    angle = [self normalizedAngle:angle];
    return angle;
}

#pragma mark - Actions

- (void)onPan:(UIPanGestureRecognizer *)pgr {
    if (pgr.state == UIGestureRecognizerStateBegan) {
        
        CGPoint center = CGRectGetMidXMidY(self.frame);
        [pgr setTranslation:center inView:self.superview];
        
    } else if (pgr.state == UIGestureRecognizerStateChanged) {
        
        CGPoint point = [pgr translationInView:self.superview];
        point = CGPointSubtract(point, self.center);
        CGFloat angle = atan2(point.y, point.x);
        angle = [self normalizedAngle:angle];
        [self setAngle:angle animated:NO];
        
        [self sendActionsForControlEvents:UIControlEventEditingChanged];
        
    } else if (pgr.state >= UIGestureRecognizerStateEnded) {
        
        [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
        
    }
}

#pragma mark - Helpers

- (CGAffineTransform)concatenatedTransform {
    CGAffineTransform transform = CGAffineTransformConcat(radiusTransform, angleTransform);
    return transform;
}

- (CGFloat)normalizedAngle:(CGFloat)angle {
    if (angle < 0.0) {
        angle += 2.0 * M_PI;
    }
    return angle;
}

@end










@interface CircularValueSlider ()

@end



@implementation CircularValueSlider

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.valueRange = UIFloatRangeMake(0.0, 1.0);
    }
    return self;
}

- (CGFloat)value {
    CGFloat value = [self valueFromAngle:self.angle];
    return value;
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
    CGFloat angle = [self angleFromValue:value];
    [self setAngle:angle animated:animated];
}

#pragma mark - Helpers

- (CGFloat)angleFromValue:(CGFloat)value {
    CGFloat length = (self.valueRange.maximum - self.valueRange.minimum);
    CGFloat k = 2.0 * M_PI / length;
    CGFloat angle = k * (value - self.valueRange.minimum);
    
    if (self.mirrored) {
        angle *= 0.5;
        if (self.angle > M_PI) {
            angle = 2.0 * M_PI - angle;
        }
    }
    
    return angle;
}

- (CGFloat)valueFromAngle:(CGFloat)angle {
    
    if (self.mirrored) {
        if (angle > M_PI) {
            angle = 2.0 * M_PI - angle;
        }
        angle *= 2.0;
    }
    
    CGFloat length = (self.valueRange.maximum - self.valueRange.minimum);
    CGFloat k = length / (2.0 * M_PI);
    CGFloat value = self.valueRange.minimum + k * angle;
    return value;
}

@end
