//
//  GridView.h
//  Control
//
//  Created by Dan Kalinin on 12/15/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GridView : UIView

@property IBInspectable UIEdgeInsets insets;
@property IBInspectable CGVector step;

- (void)moveView:(UIView *)view toIndexPath:(NSIndexPath *)ip animated:(BOOL)animated;
- (void)moveView:(UIView *)view toNextSection:(BOOL)animated;
- (void)moveView:(UIView *)view toPreviousSection:(BOOL)animated;
- (void)moveView:(UIView *)view toNextRow:(BOOL)animated;
- (void)moveView:(UIView *)view toPreviousRow:(BOOL)animated;

- (void)snapView:(UIView *)view animated:(BOOL)animated;
- (void)snap:(BOOL)animated;

- (NSIndexPath *)indexPathForView:(UIView *)view;
- (UIView *)viewForIndexPath:(NSIndexPath *)ip;

@end
