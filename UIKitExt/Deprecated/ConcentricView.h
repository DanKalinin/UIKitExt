//
//  ConcentricView.h
//  Framework
//
//  Created by Dan Kalinin on 13/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"



@interface ConcentricView : ShapeLayerView

@property IBInspectable UIColor *color;
@property IBInspectable CGFloat baseWidth;
@property IBInspectable CGFloat multiplier;
@property IBInspectable NSUInteger circles;
@property IBInspectable NSTimeInterval duration;

- (void)expand:(BOOL)outside;

@end
