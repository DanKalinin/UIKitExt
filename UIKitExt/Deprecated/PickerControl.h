//
//  PickerControl.h
//  Framework
//
//  Created by Dan Kalinin on 15.03.17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PickerControl : UIControl

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *defaultView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *views;

@property (readonly) UIView *view;
- (void)setView:(UIView *)view animated:(BOOL)animated;

@end
