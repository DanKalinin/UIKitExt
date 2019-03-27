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

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = self.handle.frame;
    
    self.pgr = [UIPanGestureRecognizer.alloc initWithTarget:self action:@selector(onPan:)];
    [self.handle addGestureRecognizer:self.pgr];
}

#pragma mark - Actions

- (void)onPan:(UIPanGestureRecognizer *)pgr {
    if (pgr.state == UIGestureRecognizerStateBegan) {
        [pgr setTranslation:CGPointZero inView:self.window];
        self.startFrame = self.frame;
    } else if (pgr.state == UIGestureRecognizerStateChanged) {
        [self resize];
    } else if (pgr.state >= UIGestureRecognizerStateEnded) {
        [self resize];
    }
    
//    - (void)onPan:(UIPanGestureRecognizer *)pgr {
//        BOOL hide = [pgr isEqual:self.pgrDimming];
//        BOOL show = !hide;
//
//        if (pgr.state == UIGestureRecognizerStateBegan) {
//            MenuView *menu;
//            if (hide) {
//                menu = self.menu;
//            } else if ([pgr isEqual:self.top.pgr]) {
//                menu = self.top;
//            } else if ([pgr isEqual:self.left.pgr]) {
//                menu = self.left;
//            } else if ([pgr isEqual:self.bottom.pgr]) {
//                menu = self.bottom;
//            } else {
//                menu = self.right;
//            }
//
//            [self menu:menu show:show animated:YES];
//            [self.animator pauseAnimation];
//            self.fraction = self.animator.fractionComplete;
//            [pgr setTranslation:CGPointZero inView:self.view];
//        } else if (pgr.state == UIGestureRecognizerStateChanged) {
//            CGPoint translation = [pgr translationInView:self.view];
//            CGFloat fraction = self.fraction;
//            if ([self.menu isEqual:self.top] || [self.menu isEqual:self.bottom]) {
//                if ([self.menu isEqual:self.top]) {
//                    if ((show && (translation.y < 0)) || (hide && (translation.y > 0))) return;
//                } else {
//                    if ((show && (translation.y > 0)) || (hide && (translation.y < 0))) return;
//                }
//                fraction += fabs(translation.y / self.menu.bounds.size.height);
//            } else {
//                if ([self.menu isEqual:self.left]) {
//                    if ((show && (translation.x < 0)) || (hide && (translation.x > 0))) return;
//                } else {
//                    if ((show && (translation.x > 0)) || (hide && (translation.x < 0))) return;
//                }
//                fraction += fabs(translation.x / self.menu.bounds.size.width);
//            }
//
//            self.animator.fractionComplete = fraction;
//        } else if (pgr.state >= UIGestureRecognizerStateEnded) {
//            if (show) {
//                self.animator.reversed = (self.animator.fractionComplete < self.menu.anchor);
//            } else {
//                self.animator.reversed = (self.animator.fractionComplete < (1.0 - self.menu.anchor));
//            }
//            [self.animator continueAnimationWithTimingParameters:nil durationFactor:1.0];
//        }
//    }
}

#pragma mark - Helpers

- (void)resize {
    CGPoint translation = [self.pgr translationInView:self.window];
    
    CGRect frame = self.startFrame;
    frame.size.height = self.startFrame.size.height + translation.y;
    if ((frame.size.height >= self.handle.frame.size.height) && (frame.size.height <= (self.handle.frame.size.height + self.length))) {
        self.frame = frame;
        self.tableView.tableHeaderView = self;
    }
}

@end
