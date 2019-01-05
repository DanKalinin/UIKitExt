//
//  UIETextField.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/2/19.
//

#import "UIETextField.h"










@implementation UITextField (UIE)

@dynamic nseOperation;
@dynamic uiePattern;
@dynamic uieClearOnBegin;

- (Class)nseOperationClass {
    return UIETextFieldOperation.class;
}

@end










@interface UIETextField ()

@property NSString *uiePattern;
@property BOOL uieClearOnBegin;

@end



@implementation UIETextField

@end










@interface UIETextFieldShouldBeginEditing ()

@end



@implementation UIETextFieldShouldBeginEditing

- (instancetype)init {
    self = super.init;
    
    self.should = YES;
    
    return self;
}

@end










@interface UIETextFieldShouldChangeCharactersInRange ()

@property NSRange range;
@property NSString *string;

@end



@implementation UIETextFieldShouldChangeCharactersInRange

- (instancetype)initWithRange:(NSRange)range string:(NSString *)string {
    self = super.init;
    
    self.range = range;
    self.string = string;
    
    self.should = YES;
    
    return self;
}

@end










@interface UIETextFieldShouldClear ()

@end



@implementation UIETextFieldShouldClear

- (instancetype)init {
    self = super.init;
    
    self.should = YES;
    
    return self;
}

@end










@interface UIETextFieldShouldReturn ()

@end



@implementation UIETextFieldShouldReturn

- (instancetype)init {
    self = super.init;
    
    self.should = YES;
    
    return self;
}

@end










@interface UIETextFieldShouldEndEditing ()

@end



@implementation UIETextFieldShouldEndEditing

- (instancetype)init {
    self = super.init;
    
    self.should = YES;
    
    return self;
}

@end










@interface UIETextFieldOperation ()

@property (weak) UIETextFieldShouldBeginEditing *shouldBeginEditing;
@property (weak) UIETextFieldShouldChangeCharactersInRange *shouldChangeCharactersInRange;
@property (weak) UIETextFieldShouldClear *shouldClear;
@property (weak) UIETextFieldShouldReturn *shouldReturn;
@property (weak) UIETextFieldShouldEndEditing *shouldEndEditing;

@end



@implementation UIETextFieldOperation

@dynamic delegates;
@dynamic object;

- (instancetype)initWithObject:(UITextField *)object {
    self = [super initWithObject:object];
    
    object.delegate = self;
    
    return self;
}

- (void)editingDidBegin:(UITextField *)sender event:(UIEvent *)event {
    [super editingDidBegin:sender event:event];
    
    [self.delegates uieControlEditingDidBegin:sender];
}

- (void)editingChanged:(UITextField *)sender event:(UIEvent *)event {
    [super editingChanged:sender event:event];
    
    [self.delegates uieControlEditingChanged:sender];
}

- (void)editingDidEnd:(UITextField *)sender event:(UIEvent *)event {
    [super editingDidEnd:sender event:event];
    
    [self.delegates uieControlEditingDidEnd:sender];
}

- (void)editingDidEndOnExit:(UITextField *)sender event:(UIEvent *)event {
    [super editingDidEndOnExit:sender event:event];
    
    [self.delegates uieControlEditingDidEndOnExit:sender];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.shouldBeginEditing = UIETextFieldShouldBeginEditing.new.nseAutorelease;
    [self.delegates uieTextFieldShouldBeginEditing:textField];
    return self.shouldBeginEditing.should;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.uieClearOnBegin) {
        textField.text = @"";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.shouldChangeCharactersInRange = [UIETextFieldShouldChangeCharactersInRange.alloc initWithRange:range string:string].nseAutorelease;
    
    if (textField.uiePattern.length > 0) {
        NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        range = [text rangeOfString:textField.uiePattern options:NSRegularExpressionSearch];
        if (range.location == NSNotFound) {
            self.shouldChangeCharactersInRange.should = NO;
        } else {
            self.shouldChangeCharactersInRange.should = YES;
        }
    } else {
        self.shouldChangeCharactersInRange.should = YES;
    }
    
    [self.delegates uieTextFieldShouldChangeCharactersInRange:textField];
    return self.shouldChangeCharactersInRange.should;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.shouldClear = UIETextFieldShouldClear.new.nseAutorelease;
    [self.delegates uieTextFieldShouldClear:textField];
    return self.shouldClear.should;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.shouldReturn = UIETextFieldShouldReturn.new.nseAutorelease;
    [self.delegates uieTextFieldShouldReturn:textField];
    return self.shouldReturn.should;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.shouldEndEditing = UIETextFieldShouldEndEditing.new.nseAutorelease;
    [self.delegates uieTextFieldShouldEndEditing:textField];
    return self.shouldEndEditing.should;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

@end
