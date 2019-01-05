//
//  CircleView.m
//  Controls
//
//  Created by Dan Kalinin on 3/26/18.
//

#import "CircleView.h"



@implementation CircleView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    self.layer.path = path.CGPath;
}

@end
