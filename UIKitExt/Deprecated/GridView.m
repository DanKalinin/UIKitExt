//
//  GridView.m
//  Control
//
//  Created by Dan Kalinin on 12/15/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "GridView.h"



@interface GridView ()

@end



@implementation GridView {
    NSUInteger m;
    NSUInteger n;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = UIEdgeInsetsInsetRect(self.frame, self.insets);
    m = floor(frame.size.width / self.step.dx) + 1;
    n = floor(frame.size.height / self.step.dy) + 1;
}

- (void)moveView:(UIView *)view toIndexPath:(NSIndexPath *)ip animated:(BOOL)animated {
    NSTimeInterval duration = 0.25 * animated;
    [UIView animateWithDuration:duration animations:^{
        view.center = [self pointForIndexPath:ip];
    }];
}

- (void)moveView:(UIView *)view toNextSection:(BOOL)animated {
    NSIndexPath *ip = [self indexPathForView:view];
    NSInteger section = ip.section;
    NSInteger row = ip.row;
    section++;
    if (section >= m) {
        section = 0;
        row++;
    }
    ip = [NSIndexPath indexPathForRow:row inSection:section];
    [self moveView:view toIndexPath:ip animated:animated];
}

- (void)moveView:(UIView *)view toPreviousSection:(BOOL)animated {
    NSIndexPath *ip = [self indexPathForView:view];
    NSInteger section = ip.section;
    NSInteger row = ip.row;
    section--;
    if (section < 0) {
        section = m - 1;
        row--;
    }
    ip = [NSIndexPath indexPathForRow:row inSection:section];
    [self moveView:view toIndexPath:ip animated:animated];
}

- (void)moveView:(UIView *)view toNextRow:(BOOL)animated {
    NSIndexPath *ip = [self indexPathForView:view];
    NSInteger section = ip.section;
    NSInteger row = ip.row;
    row++;
    if (row >= n) {
        row = 0;
        section++;
    }
    ip = [NSIndexPath indexPathForRow:row inSection:section];
    [self moveView:view toIndexPath:ip animated:animated];
}

- (void)moveView:(UIView *)view toPreviousRow:(BOOL)animated {
    NSIndexPath *ip = [self indexPathForView:view];
    NSInteger section = ip.section;
    NSInteger row = ip.row;
    row--;
    if (row < 0) {
        row = n - 1;
        section--;
    }
    ip = [NSIndexPath indexPathForRow:row inSection:section];
    [self moveView:view toIndexPath:ip animated:animated];
}

- (void)snapView:(UIView *)view animated:(BOOL)animated {
    NSIndexPath *ip = [self indexPathForView:view];
    [self moveView:view toIndexPath:ip animated:animated];
}

- (void)snap:(BOOL)animated {
    for (UIView *view in self.subviews) {
        [self snapView:view animated:animated];
    }
}

- (NSIndexPath *)indexPathForView:(UIView *)view {
    NSIndexPath *ip = [self indexPathForPoint:view.center];
    return ip;
}

- (UIView *)viewForIndexPath:(NSIndexPath *)ip {
    CGPoint p = [self pointForIndexPath:ip];
    UIView *v = [self hitTest:p withEvent:nil];
    if ([v isEqual:self]) return nil;
    return v;
}

#pragma mark - Helpers

- (CGPoint)pointForIndexPath:(NSIndexPath *)ip {
    NSInteger section = ip.section % m;
    NSInteger row = ip.row % n;
    
    CGFloat x = self.insets.left + section * self.step.dx;
    CGFloat y = self.insets.top + row * self.step.dy;
    
    CGPoint p = CGPointMake(x, y);
    return p;
}

- (NSIndexPath *)indexPathForPoint:(CGPoint)p {
    NSInteger section = round((p.x - self.insets.left) / self.step.dx);
    NSInteger row = round((p.y - self.insets.top) / self.step.dy);
    NSIndexPath *ip = [NSIndexPath indexPathForRow:row inSection:section];
    return ip;
}

@end
