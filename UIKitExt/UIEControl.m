//
//  UIEControl.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/1/19.
//

#import "UIEControl.h"










@implementation UIControl (UIE)

@dynamic nseOperation;
@dynamic uieDefaultBackgroundColor;
@dynamic uieHighlightedBackgroundColor;
@dynamic uieSelectedBackgroundColor;
@dynamic uieDisabledBackgroundColor;
@dynamic uieDefaultLayerBorderColor;
@dynamic uieHighlightedLayerBorderColor;
@dynamic uieSelectedLayerBorderColor;
@dynamic uieDisabledLayerBorderColor;

- (Class)nseOperationClass {
    return UIEControlOperation.class;
}

@end










@interface UIEControl ()

@property UIColor *uieDefaultBackgroundColor;
@property UIColor *uieHighlightedBackgroundColor;
@property UIColor *uieSelectedBackgroundColor;
@property UIColor *uieDisabledBackgroundColor;
@property UIColor *uieDefaultLayerBorderColor;
@property UIColor *uieHighlightedLayerBorderColor;
@property UIColor *uieSelectedLayerBorderColor;
@property UIColor *uieDisabledLayerBorderColor;

@end



@implementation UIEControl

- (void)setEnabled:(BOOL)enabled {
    super.enabled = enabled;
    
    self.nseOperation.enabled = enabled;
}

- (void)setSelected:(BOOL)selected {
    super.selected = selected;
    
    self.nseOperation.selected = selected;
}

- (void)setHighlighted:(BOOL)highlighted {
    super.highlighted = highlighted;
    
    self.nseOperation.highlighted = highlighted;
}

@end










@interface UIEControlOperation ()

@property (weak) UIEvent *event;

@end



@implementation UIEControlOperation

@dynamic delegates;
@dynamic object;

- (instancetype)initWithObject:(UIControl *)object {
    self = [super initWithObject:object];
    
    [object addTarget:self action:@selector(touchDown:event:) forControlEvents:UIControlEventTouchDown];
    [object addTarget:self action:@selector(touchDownRepeat:event:) forControlEvents:UIControlEventTouchDownRepeat];
    [object addTarget:self action:@selector(touchDragInside:event:) forControlEvents:UIControlEventTouchDragInside];
    [object addTarget:self action:@selector(touchDragOutside:event:) forControlEvents:UIControlEventTouchDragOutside];
    [object addTarget:self action:@selector(touchDragEnter:event:) forControlEvents:UIControlEventTouchDragEnter];
    [object addTarget:self action:@selector(touchDragExit:event:) forControlEvents:UIControlEventTouchDragExit];
    [object addTarget:self action:@selector(touchUpInside:event:) forControlEvents:UIControlEventTouchUpInside];
    [object addTarget:self action:@selector(touchUpOutside:event:) forControlEvents:UIControlEventTouchUpOutside];
    [object addTarget:self action:@selector(touchCancel:event:) forControlEvents:UIControlEventTouchCancel];

    [object addTarget:self action:@selector(valueChanged:event:) forControlEvents:UIControlEventValueChanged];
    [object addTarget:self action:@selector(primaryActionTriggered:event:) forControlEvents:UIControlEventPrimaryActionTriggered];
    
    [object addTarget:self action:@selector(editingDidBegin:event:) forControlEvents:UIControlEventEditingDidBegin];
    [object addTarget:self action:@selector(editingChanged:event:) forControlEvents:UIControlEventEditingChanged];
    [object addTarget:self action:@selector(editingDidEnd:event:) forControlEvents:UIControlEventEditingDidEnd];
    [object addTarget:self action:@selector(editingDidEndOnExit:event:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    return self;
}

- (void)touchDown:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchDown:sender];
}

- (void)touchDownRepeat:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchDownRepeat:sender];
}

- (void)touchDragInside:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchDragInside:sender];
}

- (void)touchDragOutside:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchDragOutside:sender];
}

- (void)touchDragEnter:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchDragEnter:sender];
}

- (void)touchDragExit:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchDragExit:sender];
}

- (void)touchUpInside:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchUpInside:sender];
}

- (void)touchUpOutside:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchUpOutside:sender];
}

- (void)touchCancel:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlTouchCancel:sender];
}

- (void)valueChanged:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlValueChanged:sender];
}

- (void)primaryActionTriggered:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlPrimaryActionTriggered:sender];
}

- (void)editingDidBegin:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlEditingDidBegin:sender];
}

- (void)editingChanged:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlEditingChanged:sender];
}

- (void)editingDidEnd:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlEditingDidEnd:sender];
}

- (void)editingDidEndOnExit:(UIControl *)sender event:(UIEvent *)event {
    self.event = event.nseAutorelease;
    [self.delegates uieControlEditingDidEndOnExit:sender];
}

#pragma mark - UIControl

- (void)setEnabled:(BOOL)enabled {
    if (enabled) {
        self.object.backgroundColor = self.object.uieDefaultBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieDefaultLayerBorderColor;
    } else {
        self.object.backgroundColor = self.object.uieDisabledBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieDisabledLayerBorderColor;
    }
    
    self.object.uieButton1.enabled = enabled;
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.object.backgroundColor = self.object.uieSelectedBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieSelectedLayerBorderColor;
    } else {
        self.object.backgroundColor = self.object.uieDefaultBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieDefaultLayerBorderColor;
    }
    
    self.object.uieButton1.selected = selected;
}

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.object.backgroundColor = self.object.uieHighlightedBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieHighlightedLayerBorderColor;
    } else {
        self.object.backgroundColor = self.object.uieDefaultBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieDefaultLayerBorderColor;
    }
    
    self.object.uieButton1.highlighted = highlighted;
}

@end
