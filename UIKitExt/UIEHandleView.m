//
//  UIEHandleView.m
//  UIKitExt
//
//  Created by Dan Kalinin on 3/27/19.
//

#import "UIEHandleView.h"










@interface UIEHandleView ()

@end



@implementation UIEHandleView

@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIEHandleViewOperation.class;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGRect frame = self.frame;
    if (frame.size.height > 150.0) {
        frame.size.height = 100.0;
    } else {
        frame.size.height = 200.0;
    }
    
//    [UIView animateWithDuration:0.5 animations:^{
        self.frame = frame;
//    }];
}

@end










@interface UIEHandleViewOperation ()

@end



@implementation UIEHandleViewOperation

@dynamic delegates;
@dynamic object;

- (instancetype)initWithObject:(UIEHandleView *)object {
    self = [super initWithObject:object];
    
    return self;
}

@end
