//
//  HandleView.m
//  UIKitExt
//
//  Created by Dan Kalinin on 3/27/19.
//

#import "HandleView.h"



@interface HandleView ()

@property UIPanGestureRecognizer *pgr;
@property CGRect startFrame;

@end



@implementation HandleView

- (void)setLength:(CGFloat)length animated:(BOOL)animated {
    self.length = length;
    
    if (self.expanded) {
        CGRect frame = self.frame;
        frame.size.height = self.handle.frame.size.height + length;
        
        self.frame = frame;
        self.tableView.tableHeaderView = self;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - Accessors

- (void)setHandle:(UIView *)handle {
    _handle = handle;
    
    self.frame = handle.frame;
    
    self.pgr = [UIPanGestureRecognizer.alloc initWithTarget:self action:@selector(onPan:)];
    [handle addGestureRecognizer:self.pgr];
}

- (BOOL)expanded {
    BOOL expanded = (self.frame.size.height > self.handle.frame.size.height);
    return expanded;
}

#pragma mark - Actions

- (void)onPan:(UIPanGestureRecognizer *)pgr {
    if (pgr.state == UIGestureRecognizerStateBegan) {
        [self begin];
    } else if (pgr.state == UIGestureRecognizerStateChanged) {
        [self resize];
    } else if (pgr.state >= UIGestureRecognizerStateEnded) {
        [self resize];
        [self complete];
    }
}

#pragma mark - Helpers

- (void)begin {
    [self.pgr setTranslation:CGPointZero inView:self.window];
    self.startFrame = self.frame;
}

- (void)resize {
    CGPoint translation = [self.pgr translationInView:self.window];
    
    CGRect frame = self.startFrame;
    frame.size.height = self.startFrame.size.height + translation.y;
    if ((frame.size.height >= self.handle.frame.size.height) && (frame.size.height <= (self.handle.frame.size.height + self.length))) {
        self.frame = frame;
        self.tableView.tableHeaderView = self;
    }
}

- (void)complete {
    CGPoint translation = [self.pgr translationInView:self.window];
    CGRect frame = self.frame;
    
    if (translation.y > 0.0) {
        if (translation.y > 0.1 * self.length) {
            frame.size.height = self.handle.frame.size.height + self.length;
        } else {
            frame.size.height = self.handle.frame.size.height;
        }
    } else {
        if (translation.y < -0.1 * self.length) {
            frame.size.height = self.handle.frame.size.height;
        } else {
            frame.size.height = self.handle.frame.size.height + self.length;
        }
    }
    
    [self.tableView beginUpdates];
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }];
    
    [self.tableView endUpdates];
}

@end
