//
//  UIEPasscodeView.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/5/19.
//

#import "UIEPasscodeView.h"










@interface UIEPasscodeView ()

@end



@implementation UIEPasscodeView

@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIEPasscodeViewOperation.class;
}

@end










@interface UIEPasscodeViewOperation ()

@property NSMutableString *passcode;
@property UINotificationFeedbackGenerator *generator;

@end



@implementation UIEPasscodeViewOperation

@dynamic delegates;
@dynamic object;

- (instancetype)initWithObject:(UIEPasscodeView *)object {
    self = [super initWithObject:object];
    
    self.passcode = NSMutableString.string;
    
    self.generator = UINotificationFeedbackGenerator.new;
    
    [object.buttonDelete.nseOperation.delegates addObject:self];
    
    for (UIButton *button in object.buttons) {
        [button.nseOperation.delegates addObject:self];
    }
    
    return self;
}

- (void)editingDidBegin:(UIEPasscodeView *)sender event:(UIEvent *)event {
    [super editingDidBegin:sender event:event];
    
    [self.delegates uiePasscodeViewEditingDidBegin:sender];
}

- (void)editingChanged:(UIEPasscodeView *)sender event:(UIEvent *)event {
    [super editingChanged:sender event:event];
    
    [self.delegates uiePasscodeViewEditingChanged:sender];
}

- (void)editingDidEnd:(UIEPasscodeView *)sender event:(UIEvent *)event {
    [super editingDidEnd:sender event:event];
    
    [self.delegates uiePasscodeViewEditingDidEnd:sender];
}

- (void)reset {
    self.passcode.string = @"";
    
    for (UILabel *label in self.object.labels) {
        label.text = @"";
        label.highlighted = NO;
    }
    
    self.object.buttonDelete.enabled = NO;
}

- (void)resetWithError:(NSString *)error {
    [self.generator notificationOccurred:UINotificationFeedbackTypeError];
    
    self.object.labelError.text = error;
    self.object.labelError.hidden = NO;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.object.labels.firstObject.superview.transform = CGAffineTransformMakeTranslation(-40.0, 0.0);
    } completion:^(BOOL finished) {
        [self reset];
        
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.5 options:0 animations:^{
            self.object.labels.firstObject.superview.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self.delegates uiePasscodeViewDidResetWithError:self.object];
        }];
    }];
}

#pragma mark - UIEButtonDelegate

- (void)uieButtonTouchUpInside:(UIButton *)button {
    if ([button isEqual:self.object.buttonDelete]) {
        if (self.passcode.length > 0) {
            NSUInteger location = self.passcode.length - 1;
            NSRange range = NSMakeRange(location, 1);
            [self.passcode deleteCharactersInRange:range];
            
            UILabel *label = self.object.labels[self.passcode.length];
            label.text = @"";
            label.highlighted = NO;
            
            self.object.buttonDelete.enabled = (self.passcode.length > 0);
            
            [self.object sendActionsForControlEvents:UIControlEventEditingChanged];
        }
    } else {
        if (self.passcode.length < self.object.labels.count) {
            self.object.labelError.hidden = YES;
            
            UILabel *label = self.object.labels[self.passcode.length];
            label.text = button.uieStringTag;
            label.highlighted = YES;
            
            [self.passcode appendString:button.uieStringTag];
            
            self.object.buttonDelete.enabled = YES;
            
            [self.object sendActionsForControlEvents:UIControlEventEditingChanged];
            
            if (self.passcode.length == 1) {
                [self.object sendActionsForControlEvents:UIControlEventEditingDidBegin];
            } else if (self.passcode.length == self.object.labels.count) {
                [self.generator prepare];
                
                [self.object sendActionsForControlEvents:UIControlEventEditingDidEnd];
            }
        }
    }
}

@end
