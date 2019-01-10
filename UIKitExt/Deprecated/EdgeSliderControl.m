//
//  SliderView.m
//  PickerControl
//
//  Created by Dan Kalinin on 25/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "EdgeSliderControl.h"
#import <FoundationExt/FoundationExt.h>



@interface EdgeSliderControl ()

@end



@implementation EdgeSliderControl {
    BOOL loaded;
    
    NSLayoutConstraint *topConstraint;
    NSLayoutConstraint *bottomConstraint;
    NSLayoutConstraint *leftConstraint;
    NSLayoutConstraint *rightConstraint;
    
    UIView *dimmingView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.edge = UIRectEdgeBottom;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)didMoveToSuperview {
    
    if (loaded) return;
    loaded = YES;
    
    if (self.edge == UIRectEdgeTop) {
        leftConstraint = [self.leadingAnchor constraintEqualToAnchor:self.superview.leadingAnchor];
        rightConstraint = [self.trailingAnchor constraintEqualToAnchor:self.superview.trailingAnchor];
        bottomConstraint = [self.topAnchor constraintEqualToAnchor:self.superview.topAnchor];
        topConstraint = [self.bottomAnchor constraintEqualToAnchor:self.superview.topAnchor constant:self.inset];
    } else if (self.edge == UIRectEdgeBottom) {
        leftConstraint = [self.leadingAnchor constraintEqualToAnchor:self.superview.leadingAnchor];
        rightConstraint = [self.trailingAnchor constraintEqualToAnchor:self.superview.trailingAnchor];
        bottomConstraint = [self.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor];
        topConstraint = [self.topAnchor constraintEqualToAnchor:self.superview.bottomAnchor constant:-self.inset];
    } else if (self.edge == UIRectEdgeLeft) {
        leftConstraint = [self.topAnchor constraintEqualToAnchor:self.superview.topAnchor];
        rightConstraint = [self.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor];
        bottomConstraint = [self.leadingAnchor constraintEqualToAnchor:self.superview.leadingAnchor];
        topConstraint = [self.trailingAnchor constraintEqualToAnchor:self.superview.leadingAnchor constant:self.inset];
    } else if (self.edge == UIRectEdgeRight) {
        leftConstraint = [self.topAnchor constraintEqualToAnchor:self.superview.topAnchor];
        rightConstraint = [self.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor];
        bottomConstraint = [self.trailingAnchor constraintEqualToAnchor:self.superview.trailingAnchor];
        topConstraint = [self.leadingAnchor constraintEqualToAnchor:self.superview.trailingAnchor constant:-self.inset];
    } else {
        NSAssert(NO, @"Invalid edge");
    }
    
    leftConstraint.active = YES;
    rightConstraint.active = YES;
    topConstraint.active = YES;
    bottomConstraint.active = NO;
    
    dimmingView = [UIView.alloc initWithFrame:self.superview.bounds];
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    dimmingView.backgroundColor = self.dimmingColor;
    dimmingView.alpha = 0.0;
    [self.superview insertSubview:dimmingView belowSubview:self];
    
    UITapGestureRecognizer *tgr = [UITapGestureRecognizer.alloc initWithTarget:self action:@selector(onTap:)];
    [dimmingView addGestureRecognizer:tgr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.selected = selected;
    NSTimeInterval duration = 0.25 * animated;
    [self.superview layoutIfNeeded];
    [UIView animateWithDuration:duration animations:^{
        topConstraint.active = !selected;
        bottomConstraint.active = selected;
        [self.superview layoutIfNeeded];
        dimmingView.alpha = selected;
    }];
}

- (void)toggleAnimated:(BOOL)animated {
    [self setSelected:!self.selected animated:animated];
}

#pragma mark - Accessors

- (BOOL)shown {
    return bottomConstraint.active;
}

#pragma mark - Actions

- (void)onTap:(UITapGestureRecognizer *)tgr {
    if (tgr.state == UIGestureRecognizerStateEnded) {
        [self setSelected:NO animated:YES];
        [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
    }
}

@end
