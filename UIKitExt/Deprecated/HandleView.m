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
    
    if (self.frame.size.height > self.handle.frame.size.height) {
        CGRect frame = self.frame;
        frame.size.height = self.handle.frame.size.height + length;
        
        [self.tableView beginUpdates];
        
        [self layoutIfNeeded];
        NSTimeInterval duration = 0.3 * animated;
        [UIView animateWithDuration:duration animations:^{
            self.frame = frame;
            [self layoutIfNeeded];
        }];
        
        [self.tableView endUpdates];
    }
}

#pragma mark - Accessors

- (void)setHandle:(UIView *)handle {
    _handle = handle;
    
    self.frame = handle.frame;
    
    self.pgr = [UIPanGestureRecognizer.alloc initWithTarget:self action:@selector(onPan:)];
    [handle addGestureRecognizer:self.pgr];
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
    CGRect frame = self.frame;
    
    if ((self.frame.size.height - self.handle.frame.size.height) > (0.5 * self.length)) {
        frame.size.height = self.handle.frame.size.height + self.length;
    } else {
        frame.size.height = self.handle.frame.size.height;
    }
    
    [self.tableView beginUpdates];
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
        [self layoutIfNeeded];
    }];
    
    [self.tableView endUpdates];
}

@end
