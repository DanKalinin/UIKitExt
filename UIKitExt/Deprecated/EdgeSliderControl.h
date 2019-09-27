//
//  SliderView.h
//  PickerControl
//
//  Created by Dan Kalinin on 25/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"
#import "PickerControl.h"
#import "NumberPickerControl.h"



@interface EdgeSliderControl : UIControl

@property (weak, nonatomic) IBOutlet View *view1;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl1;

@property (weak, nonatomic) IBOutlet PickerControl *pickerControl1;
@property (weak, nonatomic) IBOutlet PickerControl *pickerControl2;

@property (weak, nonatomic) IBOutlet NumberPickerControl *numberPickerControl1;
@property (weak, nonatomic) IBOutlet NumberPickerControl *numberPickerControl2;
@property (weak, nonatomic) IBOutlet NumberPickerControl *numberPickerControl3;

@property (weak, nonatomic) IBOutlet TimePickerControl *timePickerControl1;
@property (weak, nonatomic) IBOutlet TimePickerControl *timePickerControl2;

@property IBInspectable UIRectEdge edge;
@property IBInspectable CGFloat inset;
@property IBInspectable UIColor *dimmingColor;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)toggleAnimated:(BOOL)animated;

@end
