//
//  PickerControl.m
//  PickerControl
//
//  Created by Dan Kalinin on 20/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "NumberPickerControl.h"










@interface NumberPickerControl () <UIPickerViewDataSource, UIPickerViewDelegate>

@property NSUInteger value;

@end



@implementation NumberPickerControl {
    NSInteger _row;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.valueFormat = @"%i";
        self.valueMultiplier = 1;
    }
    return self;
}

- (void)setValue:(NSUInteger)value animated:(BOOL)animated {
    NSInteger row = [self rowFromValue:value];
    [self.pickerView selectRow:row inComponent:0 animated:animated];
    
    _row = row;
    self.value = value;
}

#pragma mark - Accessors

- (void)setPickerView:(UIPickerView *)pickerView {
    _pickerView = pickerView;
    pickerView.dataSource = self;
    pickerView.delegate = self;
}

- (void)setValueRange:(NSRange)valueRange {
    if (NSEqualRanges(valueRange, _valueRange)) return;
    
    _valueRange = valueRange;
    [self.pickerView reloadAllComponents];
    
    NSUInteger minValue = valueRange.location;
    NSUInteger maxValue = NSMaxRange(valueRange);
    self.value = MAX(minValue, self.value);
    self.value = MIN(maxValue, self.value);
}

#pragma mark - Picker view

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.valueRange.length + 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.prototypeLabel.frame.size.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.prototypeLabel.frame.size.height;
}

- (UILabel *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UILabel *)label {
    if (!label) {
        label = self.prototypeLabel.copy;
    }
    int value = (int)[self valueFromRow:row];
    label.text = [NSString stringWithFormat:self.valueFormat, value * self.valueMultiplier];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == _row) return;
    
    _row = row;
    self.value = [self valueFromRow:row];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Helpers

- (NSUInteger)valueFromRow:(NSInteger)row {
    NSUInteger value = self.valueRange.location + row;
    return value;
}

- (NSInteger)rowFromValue:(NSUInteger)value {
    NSInteger row = value - self.valueRange.location;
    return row;
}

@end










@interface DoubleNumberPickerControl ()

@property NSUInteger value;

@end



@implementation DoubleNumberPickerControl {
    NSRange minRightValueRange;
    NSRange standardRightValueRange;
    NSRange maxRightValueRange;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.leftPickerControl addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.rightPickerControl addTarget:self action:@selector(onValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)setValue:(NSUInteger)value animated:(BOOL)animated {
    self.value = value;
    
    NSUInteger leftValue = value / self.divider;
    NSUInteger rightValue = value % self.divider;
    
    [self.leftPickerControl setValue:leftValue animated:animated];
    [self updateRightValueRange];
    [self.rightPickerControl setValue:rightValue animated:animated];
}

#pragma mark - Accessors

- (void)setValueRange:(NSRange)valueRange {
    if (NSEqualRanges(valueRange, _valueRange)) return;
    
    _valueRange = valueRange;
    
    NSUInteger min = valueRange.location / self.divider;
    NSUInteger max = NSMaxRange(valueRange) / self.divider;
    self.leftPickerControl.valueRange = NSMakeRange(min, max - min);
    
    min = valueRange.location % self.divider;
    max = NSMaxRange(valueRange) % self.divider;
    minRightValueRange = NSMakeRange(min, self.divider - 1 - min);
    standardRightValueRange = NSMakeRange(0, self.divider - 1);
    maxRightValueRange = NSMakeRange(0, max);
    [self updateRightValueRange];
}

#pragma mark - Actions

- (void)onValueChanged:(NumberPickerControl *)sender {
    if ([sender isEqual:self.leftPickerControl]) {
        [self updateRightValueRange];
        [self.rightPickerControl setValue:self.rightPickerControl.value animated:NO];
    }
    
    self.value = self.leftPickerControl.value * self.divider + self.rightPickerControl.value;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Helpers

- (void)updateRightValueRange {
    if (self.leftPickerControl.valueRange.length == 0) {
        if (minRightValueRange.location == maxRightValueRange.length) {
            self.rightPickerControl.valueRange = NSMakeRange(minRightValueRange.location, 0);
        } else {
            self.rightPickerControl.valueRange = NSIntersectionRange(minRightValueRange, maxRightValueRange);
        }
    } else if (self.leftPickerControl.value == self.leftPickerControl.valueRange.location) {
        self.rightPickerControl.valueRange = minRightValueRange;
    } else if (self.leftPickerControl.value == NSMaxRange(self.leftPickerControl.valueRange)) {
        self.rightPickerControl.valueRange = maxRightValueRange;
    } else {
        self.rightPickerControl.valueRange = standardRightValueRange;
    }
}

@end










@implementation TimePickerControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.divider = 60;
    }
    return self;
}

- (void)setMinutesRange:(NSRange)minutesRange {
    [self setValueRange:minutesRange];
}

- (NSUInteger)minutes {
    return self.value;
}

- (void)setMinutes:(NSUInteger)minutes animated:(BOOL)animated {
    [self setValue:minutes animated:animated];
}

@end
