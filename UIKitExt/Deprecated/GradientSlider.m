//
//  GradientSlider.m
//  Slider
//
//  Created by Dan Kalinin on 18/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "GradientSlider.h"
#import "View.h"
#import <Helpers/Helpers.h>



@interface GradientSlider ()

@property (nonatomic) CGFloat value;

@end



@implementation GradientSlider {
    CGFloat minimumValue;
    CGFloat maximumValue;
    
    NSTimer *buttonTimer;
    CGFloat downValue;
    CGFloat oldValue;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.minusButton.tag = -1;
    [self.minusButton addTarget:self action:@selector(onDown:) forControlEvents:UIControlEventTouchDown];
    [self.minusButton addTarget:self action:@selector(onUp:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside)];
    [self.minusButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchCancel];
    
    self.plusButton.tag = +1;
    [self.plusButton addTarget:self action:@selector(onDown:) forControlEvents:UIControlEventTouchDown];
    [self.plusButton addTarget:self action:@selector(onUp:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside)];
    [self.plusButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchCancel];
    
    [self.minusButton setTitleColor:[self.minusButton titleColorForState:UIControlStateHighlighted] forState:(UIControlStateHighlighted | UIControlStateSelected)];
    [self.plusButton setTitleColor:[self.plusButton titleColorForState:UIControlStateHighlighted] forState:(UIControlStateHighlighted | UIControlStateSelected)];
    
    GradientLayerView *gradientView = [GradientLayerView new];
    gradientView.layer.uiColors = @[self.minimumColor, self.maximumColor];
    gradientView.layer.startPoint = CGPointMake(0.0, 0.0);
    gradientView.layer.endPoint = CGPointMake(1.0, 0.0);
    [self.valueView addSubview:gradientView];
    
    gradientView.translatesAutoresizingMaskIntoConstraints = NO;
    [gradientView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [gradientView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [gradientView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [gradientView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    
    [self setValue:self.value animated:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.valueConstraint.constant = [self constantForValue:self.value];
}

#pragma mark - Accessors

- (void)setValueRange:(CGPoint)valueRange {
    if (CGPointEqualToPoint(valueRange, _valueRange)) return;
    
    _valueRange = valueRange;
    
    minimumValue = valueRange.x;
    maximumValue = valueRange.x + valueRange.y;
    [self setValue:self.value animated:NO];
}

- (void)setValue:(CGFloat)value {
    _value = value;
    self.valueLabel.text = [NSString stringWithFormat:self.valueFormat, value];
}

#pragma mark - Actions

// Buttons

- (void)onDown:(UIButton *)sender {
    downValue = self.value;
    
    buttonTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(onChanged:) userInfo:sender repeats:YES];
    [buttonTimer fire];
}

- (void)onChanged:(NSTimer *)sender {
    UIButton *button = sender.userInfo;
    oldValue = self.value;
    CGFloat value = self.value + self.stepValue * button.tag;
    if (self.continuous && (value != oldValue)) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    [self setValue:value animated:NO];
}

- (void)onUp:(UIButton *)sender {
    [buttonTimer invalidate];
    
    if (!self.continuous && (self.value != downValue)) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)onCancel:(UIButton *)sender {
    [buttonTimer invalidate];
}

// Control

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self valueUpdatedWithTouch:touch];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self valueUpdatedWithTouch:touch];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    if (!self.continuous) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - Helpers

- (void)valueUpdatedWithTouch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self];
    
    CGFloat constant = fmax(0.0, location.x);
    constant = fmin(self.frame.size.width, constant);
    
    oldValue = self.value;
    CGFloat value = [self valueForConstant:constant];
    self.value = [self roudedValue:value];
    if (self.continuous && (self.value != oldValue)) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    [self setConstant:constant animated:NO];
}

- (CGFloat)roudedValue:(CGFloat)value {
    CGFloat steps = floor(value / self.stepValue);
    CGFloat integral = steps * self.stepValue;
    CGFloat remainder = value - integral;
    value = (remainder < 0.5 * self.stepValue) ? integral : integral + self.stepValue;
    return value;
}

- (void)setConstant:(CGFloat)constant animated:(BOOL)animated {
    
    self.minusButton.selected = (constant > self.minusButton.center.x);
    self.valueLabel.highlighted = (constant > [self convertPoint:self.valueLabel.center fromView:self.valueLabel.superview].x);
    self.plusButton.selected = (constant > self.plusButton.center.x);
    
    NSTimeInterval duration = 0.25 * animated;
    [self.valueView.superview layoutIfNeeded];
    [UIView animateWithDuration:duration animations:^{
        self.valueConstraint.constant = constant;
        [self.valueView.superview layoutIfNeeded];
    }];
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
    value = fmax(minimumValue, value);
    self.value = fmin(maximumValue, value);
    CGFloat constant = [self constantForValue:self.value];
    [self setConstant:constant animated:animated];
}

- (CGFloat)constantForValue:(CGFloat)value {
    CGFloat constant = (value - minimumValue) / (maximumValue - minimumValue) * self.frame.size.width;
    return constant;
}

- (CGFloat)valueForConstant:(CGFloat)constant {
    CGFloat value = constant / self.frame.size.width * (maximumValue - minimumValue) + minimumValue;
    return value;
}

@end
