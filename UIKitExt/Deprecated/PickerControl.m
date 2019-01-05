//
//  PickerControl.m
//  Framework
//
//  Created by Dan Kalinin on 15.03.17.
//  Copyright © 2017 Dan Kalinin. All rights reserved.
//

#import "PickerControl.h"



@interface PickerControl () <UIPickerViewDataSource, UIPickerViewDelegate>

@property UIView *view;

@end



@implementation PickerControl {
    NSInteger _row;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.defaultView) {
        [self setView:self.defaultView animated:NO];
    } else {
        self.view = self.views.firstObject;
    }
}

- (void)setView:(UIView *)view animated:(BOOL)animated {
    NSUInteger row = [self.views indexOfObject:view];
    [self.pickerView selectRow:row inComponent:0 animated:animated];
    
    _row = row;
    self.view = view;
}

#pragma mark - Accessors

- (void)setPickerView:(UIPickerView *)pickerView {
    _pickerView = pickerView;
    pickerView.dataSource = self;
    pickerView.delegate = self;
}

#pragma mark - Picker view

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.views.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    UIView *view = self.views.firstObject;
    return view.frame.size.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    UIView *view = self.views.firstObject;
    return view.frame.size.height;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    view = self.views[row];
    view = view.copy;
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == _row) return;
    
    _row = row;
    self.view = self.views[row];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
