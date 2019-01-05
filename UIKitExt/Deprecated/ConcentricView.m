//
//  ConcentricView.m
//  Framework
//
//  Created by Dan Kalinin on 13/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "ConcentricView.h"



@interface ConcentricView ()

@property NSMutableArray *views;
@property CGAffineTransform defaultTransform;

@end



@implementation ConcentricView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.views = [NSMutableArray array];
    
    CGFloat width = self.baseWidth;
    for (NSUInteger index = 0; index < self.circles; index++) {
        width *= self.multiplier;
        CGRect frame = CGRectMake(0.0, 0.0, width, width);
        UIView *view = [UIView.alloc initWithFrame:frame];
        view.backgroundColor = self.color;
        view.layer.cornerRadius = 0.5 * width;
        [self insertSubview:view atIndex:0];
        [self.views addObject:view];
    }
    
    CGFloat k = self.baseWidth / width;
    self.defaultTransform = CGAffineTransformMakeScale(k, k);
    [self applyTransform:self.defaultTransform];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint center = CGPointMake(0.5 * self.frame.size.width, 0.5 * self.frame.size.height);
    NSValue *value = [NSValue valueWithCGPoint:center];
    [self.views setValue:value forKey:@"center"];
}

- (void)expand:(BOOL)outside {
    CGAffineTransform transform = outside ? CGAffineTransformIdentity : self.defaultTransform;
    [UIView animateWithDuration:self.duration animations:^{
        [self applyTransform:transform];
    }];
}

- (void)applyTransform:(CGAffineTransform)transform {
    NSValue *value = [NSValue valueWithCGAffineTransform:transform];
    [self.views setValue:value forKey:@"transform"];
}

@end
