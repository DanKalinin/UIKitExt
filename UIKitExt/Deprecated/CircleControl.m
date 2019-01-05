//
//  CircleControl.m
//  SectorControl
//
//  Created by Dan Kalinin on 2/9/17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import "CircleControl.h"
#import <Helpers/Helpers.h>










@interface CircleControl ()

@property CGFloat angle;

@end



@implementation CircleControl {
    UIFloatRange _angularRange;
    
    CGFloat _currentAngle;
    CGFloat _lastAngle;
    
    CGFloat _bSteps;
    CGFloat _cSteps;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.minAngle = -M_PI;
        self.maxAngle = M_PI;
        self.angularStep = 0.5 / M_PI;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _angularRange = UIFloatRangeMake(self.minAngle, self.maxAngle);
    
    if (self.initialAngle != 0.0) {
        [self setAngle:self.initialAngle animated:NO];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.imageView.highlighted = highlighted;
}

- (void)setAngle:(CGFloat)angle animated:(BOOL)animated {
    
    angle = CGFloatClampToRange(angle, _angularRange);
    
    if (angle == _currentAngle) return;
    
    CGFloat deltaAngle = angle - _currentAngle;
    CGFloat sign = CGFloatSign(deltaAngle);
    deltaAngle = fabs(deltaAngle);
    NSUInteger steps = floor(deltaAngle / M_PI_2);
    double relativeDuration = M_PI_2 / deltaAngle;
    
    CGFloat lastDeltaAngle = deltaAngle - M_PI_2 * steps;
    double lastRelativeDuration = lastDeltaAngle / deltaAngle;
    
    _currentAngle = self.angle = angle;
    
    NSTimeInterval duration = 0.25 * animated;
    
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
        for (NSUInteger step = 0; step < steps; step++) {
            [UIView addKeyframeWithRelativeStartTime:(relativeDuration * step) relativeDuration:relativeDuration animations:^{
                self.transform = CGAffineTransformRotate(self.transform, sign * M_PI_2);
            }];
        }
        if (lastDeltaAngle != 0.0) {
            [UIView addKeyframeWithRelativeStartTime:(1.0 - lastRelativeDuration) relativeDuration:lastRelativeDuration animations:^{
                self.transform = CGAffineTransformRotate(self.transform, sign * lastDeltaAngle);
            }];
        }
    } completion:nil];
}

#pragma mark - Control

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGFloat outerRadius = 0.5 * self.bounds.size.width;
    CGFloat innerRadius = outerRadius - self.circleWidth;
    
    CGPoint center = CGRectGetMidXMidY(self.bounds);
    CGPoint location = [touch locationInView:self];
    CGFloat distance = CGPointDistance(center, location);
    if ((distance < innerRadius) || (distance > outerRadius)) {
        return NO;
    }
    
    _lastAngle = [self angleForTouch:touch];
    
    _bSteps = _cSteps = [self steps];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGFloat angle = [self angleForTouch:touch];
    CGFloat deltaAngle = angle - _lastAngle;
    _lastAngle = angle;
    
    if (deltaAngle < -M_PI) {
        deltaAngle += 2.0 * M_PI;
    }
    
    if (deltaAngle > M_PI) {
        deltaAngle -= 2.0 * M_PI;
    }
    
    _currentAngle += deltaAngle;
    if (self.respectBounds) {
        _currentAngle = CGFloatClampToRange(_currentAngle, _angularRange);
    }
    self.transform = CGAffineTransformMakeRotation(_currentAngle);
    
    NSUInteger steps = [self steps];
    if (steps != _cSteps) {
        _cSteps = steps;
        self.angle = self.minAngle + self.angularStep * steps;
        [self sendActionsForControlEvents:UIControlEventEditingChanged];
    }
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    
    if (_cSteps != _bSteps) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - Helpers

- (CGFloat)angleForTouch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self.superview];
    location = CGPointSubtract(location, self.center);
    CGFloat angle = atan2(location.y, location.x);
    if (angle < 0) {
        angle += 2.0 * M_PI;
    }
    return angle;
}

- (NSUInteger)steps {
    NSUInteger steps = (_currentAngle - self.minAngle) / self.angularStep;
    return steps;
}

@end










@interface CircleValueControl ()

@end



@implementation CircleValueControl {
    CGFloat _k;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.minValue = self.minAngle;
        self.maxValue = self.maxAngle;
        self.valueStep = self.angularStep;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _k = (self.maxValue - self.minValue) / (self.maxAngle - self.minAngle);
    self.angularStep = self.valueStep / _k;
    
    if (self.initialValue != 0.0) {
        [self setValue:self.initialValue animated:NO];
    }
}

- (CGFloat)value {
    CGFloat value = self.minValue + _k * (self.angle - self.minAngle);
    return value;
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
    CGFloat angle = self.minAngle + (value - self.minValue) / _k;
    [self setAngle:angle animated:animated];
}

@end
