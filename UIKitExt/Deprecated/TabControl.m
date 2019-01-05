//
//  UnderscoredButtonsView.m
//  Framework
//
//  Created by Dan Kalinin on 14/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "TabControl.h"



@interface TabControl ()

@property UIButton *button;

@end



@implementation TabControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.disabledAlpha = 0.5;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIButton *button in self.buttons) {
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.initialButton) {
        [self selectButton:self.initialButton animated:NO];
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    self.alpha = enabled ? 1.0 : self.disabledAlpha;
}

- (void)selectButton:(UIButton *)button animated:(BOOL)animated {
    
    self.button.selected = NO;
    button.selected = YES;
    
    self.button = button;
    
    NSTimeInterval duration = 0.25 * animated;
    [self.underscoreView.superview layoutIfNeeded];
    [UIView animateWithDuration:duration animations:^{
        self.leadingConstraint.active = self.widthConstraint.active = NO;
        self.leadingConstraint = [self.underscoreView.leadingAnchor constraintEqualToAnchor:button.leadingAnchor];
        self.widthConstraint = [self.underscoreView.widthAnchor constraintEqualToAnchor:button.widthAnchor];
        self.leadingConstraint.active = self.widthConstraint.active = YES;
        [self.underscoreView.superview layoutIfNeeded];
    }];
    
    CGFloat x = button.frame.origin.x - self.stackView.spacing;
    CGFloat width = button.frame.size.width + 2.0 * self.stackView.spacing;
    CGRect rect = CGRectMake(x, 0.0, width, 1.0);
    [self.scrollView scrollRectToVisible:rect animated:animated];
}

#pragma mark - Actions

- (void)onClick:(UIButton *)sender {
    
    if ([sender isEqual:self.button]) return;
    
    [self selectButton:sender animated:YES];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
