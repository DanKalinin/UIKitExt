//
//  TimerControl.m
//  Controls
//
//  Created by Dan Kalinin on 11/17/17.
//

#import "TimerControl.h"










@interface TimerControl ()

@property NSTimer *timer;
@property NSRunLoop *runLoop;
@property NSUInteger value;

@end



@implementation TimerControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.runLoop = NSRunLoop.currentRunLoop;
        self.interval = 1.0;
        self.repeats = 1;
    }
    return self;
}

#pragma mark - Accessors

- (NSTimer *)timer {
    if (_timer.valid) return _timer;
    
    _timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(onFire) userInfo:nil repeats:YES];
    self.value = self.repeats;
    return _timer;
}

#pragma mark - Actions

- (void)onFire {
    self.value--;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    if (self.value == 0) {
        [self.timer invalidate];
    }
}

@end










@interface TimerViewController ()

@end



@implementation TimerViewController

@dynamic view;

- (void)dealloc {
    [self.view.timer invalidate];
}

@end
