//
//  PickerControl.h
//  PickerControl
//
//  Created by Dan Kalinin on 20/11/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>










@interface NumberPickerControl : UIControl

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) IBOutlet UILabel *prototypeLabel;

@property (nonatomic) IBInspectable NSRange valueRange;

@property IBInspectable NSUInteger valueMultiplier;
@property IBInspectable NSString *valueFormat;

@property (readonly) NSUInteger value;
- (void)setValue:(NSUInteger)value animated:(BOOL)animated;

@end










@interface DoubleNumberPickerControl : UIControl

@property (weak, nonatomic) IBOutlet NumberPickerControl *rightPickerControl;
@property (weak, nonatomic) IBOutlet NumberPickerControl *leftPickerControl;

@property (nonatomic) IBInspectable NSRange valueRange;
@property IBInspectable NSUInteger divider;

@property (readonly) NSUInteger value;
- (void)setValue:(NSUInteger)value animated:(BOOL)animated;

@end










@interface TimePickerControl : DoubleNumberPickerControl

@property (nonatomic) IBInspectable NSRange minutesRange;

@property (readonly) NSUInteger minutes;
- (void)setMinutes:(NSUInteger)minutes animated:(BOOL)animated;

@end
