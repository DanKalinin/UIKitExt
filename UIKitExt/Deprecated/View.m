//
//  View.m
//  Controls
//
//  Created by Dan Kalinin on 11/16/17.
//

#import "View.h"
#import "TextFields.h"
#import "TimerControl.h"
#import "CircleView.h"

const UIModalPresentationStyle UIModalPresentationPush = -10;










@interface View ()

@end



@implementation View

@end










@interface Label ()

@end



@implementation Label

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.backgroundColor = highlighted ? self.highlightedBackgroundColor : self.defaultBackgroundColor;
}

@end










@interface ImageView ()

@end



@implementation ImageView

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.backgroundColor = highlighted ? self.highlightedBackgroundColor : self.defaultBackgroundColor;
}

@end










@interface TextFieldDelegate : NSObject <UITextFieldDelegate>

@end



@implementation TextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(TextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(TextField *)textField {
    if (textField.clearOnBegin) {
        textField.text = @"";
    }
}

- (BOOL)textField:(TextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {    
    if (textField.pattern.length > 0) {
        NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSRange range = [text rangeOfString:textField.pattern options:NSRegularExpressionSearch];
        if (range.location == NSNotFound) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(TextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(TextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(TextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(TextField *)textField {
    
}

@end










@interface TextView ()

@end



@implementation TextView

@end










@interface TextField ()

@property TextFieldDelegate *textFieldDelegate;
@property SurrogateArray<UITextFieldDelegate> *delegates;

@end



@implementation TextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.textFieldDelegate = TextFieldDelegate.new;
        super.delegate = self.textFieldDelegate;
        self.disabledAlpha = 0.5;
    }
    return self;
}

#pragma mark - Accessors

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    if (delegate) {
        self.delegates = (id)SurrogateArray.new;
        [self.delegates addObject:delegate];
        [self.delegates addObject:self.textFieldDelegate];
        [super setDelegate:self.delegates];
    } else {
        [super setDelegate:self.textFieldDelegate];
    }
}

//- (void)setRightView:(UIButton *)btnEye {
//    [super setRightView:btnEye];
//    if (self.secureTextEntry) {
//        [btnEye addTarget:self action:@selector(onEye:) forControlEvents:UIControlEventTouchUpInside];
//    }
//}

- (BOOL)valid {
    if (self.pattern.length > 0) {
        NSRange range = [self.text rangeOfString:self.pattern options:NSRegularExpressionSearch];
        BOOL valid = (range.location != NSNotFound);
        return valid;
    } else {
        return YES;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    self.alpha = enabled ? 1.0 : self.disabledAlpha;
}

#pragma mark - Actions

- (void)onEye:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.secureTextEntry = !sender.selected;
}

@end










@interface Button ()

@end



@implementation Button

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateState];
    
    if (self.toggle) {
        [self addTarget:self action:@selector(onToggle) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self.subbuttons setValue:@(highlighted) forKey:@"highlighted"];
    [self updateState];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self.subbuttons setValue:@(selected) forKey:@"selected"];
    [self updateState];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self.subbuttons setValue:@(enabled) forKey:@"enabled"];
    [self updateState];
}

#pragma mark - Actions

- (void)onToggle {
    self.selected = !self.selected;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Helpers

- (void)updateState {
    if (self.state == UIControlStateHighlighted) {
        self.backgroundColor = self.highlightedBackgroundColor;
        self.borderColor = self.highlightedBorderColor;
    } else if (self.state == UIControlStateDisabled) {
        self.backgroundColor = self.disabledBackgroundColor;
        self.borderColor = self.disabledBorderColor;
    } else if (self.state == UIControlStateSelected) {
        self.backgroundColor = self.selectedBackgroundColor;
        self.borderColor = self.selectedBorderColor;
    } else {
        self.backgroundColor = self.defaultBackgroundColor;
        self.borderColor = self.defaultBorderColor;
    }
    
    [self setNeedsDisplay];
}

@end










@interface KeyboardContainerView ()

@end



@implementation KeyboardContainerView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.keyboardWillChangeFrameNotification = YES;
        
        UITapGestureRecognizer *tgr = [UITapGestureRecognizer.alloc initWithTarget:self action:@selector(onTap:)];
        tgr.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tgr];
    }
    return self;
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)note {
    BOOL isLocalKeyboard = [note.userInfo[UIKeyboardIsLocalUserInfoKey] boolValue];
    if (isLocalKeyboard) {
        NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        UIViewAnimationCurve curve = [note.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        BOOL shown = endFrame.origin.y < self.window.frame.size.height;
        [self.superview layoutIfNeeded];
        [UIView animateWithDuration:duration delay:0.0 options:(curve << 16) animations:^{
            self.bottomConstraint.constant = shown ? endFrame.size.height : 0.0;
            [self.superview layoutIfNeeded];
        } completion:nil];
    }
}

- (void)onTap:(UITapGestureRecognizer *)tgr {
    [self endEditing:YES];
}

@end










@implementation ShapeLayerView

@dynamic layer;

+ (Class)layerClass {
    return CAShapeLayer.class;
}

#pragma mark - Accessors

- (void)setFillColor:(UIColor *)fillColor {
    self.layer.fillColor = fillColor.CGColor;
}

- (UIColor *)fillColor {
    UIColor *color = [UIColor colorWithCGColor:self.layer.fillColor];
    return color;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    self.layer.strokeColor = strokeColor.CGColor;
}

- (UIColor *)strokeColor {
    UIColor *color = [UIColor colorWithCGColor:self.layer.strokeColor];
    return color;
}

@end










@interface GradientLayerView ()

@end



@implementation GradientLayerView

@dynamic layer;

+ (Class)layerClass {
    return CAGradientLayer.class;
}

@end










@interface GradientLayerView2 ()

@end



@implementation GradientLayerView2

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.startColor = UIColor.blackColor;
        self.endColor = UIColor.whiteColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.uiColors = @[self.startColor, self.endColor];
}

@end










@interface EmitterCellImageView ()

@property CAEmitterCell *cell;

@end



@implementation EmitterCellImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.cell = [CAEmitterCell emitterCell];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cell.contents = (id)self.image.CGImage;
}

@end










@implementation EmitterLayerView

@dynamic layer;

+ (Class)layerClass {
    return CAEmitterLayer.class;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.emitterCells = [self.cells valueForKey:@"cell"];
}

@end










@interface ViewController ()

@property (weak) UIViewController *overlay;

@end



@implementation ViewController

- (void)embedOverlayWithIdentifier:(NSString *)identifier fromStoryboard:(NSString *)storyboard {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboard bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:identifier];
    [self embedViewController:vc toView:self.view];
    [self.view bringSubviewToFront:vc.view];
    self.overlay = vc;
}

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(VoidBlock)completion {
    if (viewController.modalPresentationStyle == UIModalPresentationPush) {
        [self.navigationController pushViewController:viewController animated:animated];
        [self invokeHandler:completion];
    } else {
        [super presentViewController:viewController animated:animated completion:completion];
    }
}

@end










@interface KeyboardViewController ()

@end



@implementation KeyboardViewController

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if (!editing) {
        [self.view endEditing:YES];
    }
}

#pragma mark - Notifications

- (void)keyboardWillShowNotification:(NSNotification *)note {
    [self setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)keyboardWillHideNotification:(NSNotification *)note {
    [self setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - Actions

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

@end
