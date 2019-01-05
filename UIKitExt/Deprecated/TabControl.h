//
//  UnderscoredButtonsView.h
//  Framework
//
//  Created by Dan Kalinin on 14/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TabControl : UIControl

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (weak, nonatomic) IBOutlet UIView *underscoreView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *initialButton;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property IBInspectable CGFloat disabledAlpha;

@property (readonly) UIButton *button;
- (void)selectButton:(UIButton *)button animated:(BOOL)animated;

@end
