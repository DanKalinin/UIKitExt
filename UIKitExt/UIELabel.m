//
//  UIELabel.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/6/19.
//

#import "UIELabel.h"










@implementation UILabel (UIE)

@dynamic uieOperation;
@dynamic uieDefaultBackgroundColor;
@dynamic uieHighlightedBackgroundColor;
@dynamic uieDisabledBackgroundColor;
@dynamic uieDefaultLayerBorderColor;
@dynamic uieHighlightedLayerBorderColor;
@dynamic uieDisabledLayerBorderColor;

- (Class)uieOperationClass {
    return UIELabelOperation.class;
}

@end










@interface UIELabel ()

@property UIColor *uieDefaultBackgroundColor;
@property UIColor *uieHighlightedBackgroundColor;
@property UIColor *uieDisabledBackgroundColor;
@property UIColor *uieDefaultLayerBorderColor;
@property UIColor *uieHighlightedLayerBorderColor;
@property UIColor *uieDisabledLayerBorderColor;

@end



@implementation UIELabel

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    [self.uieOperation setEnabled:enabled];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    [self.uieOperation setHighlighted:highlighted];
}

@end










@interface UIELabelOperation ()

@end



@implementation UIELabelOperation

@dynamic object;

- (void)setEnabled:(BOOL)enabled {
    if (enabled) {
        self.object.backgroundColor = self.object.uieDefaultBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieDefaultLayerBorderColor;
    } else {
        self.object.backgroundColor = self.object.uieDisabledBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieDisabledLayerBorderColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.object.backgroundColor = self.object.uieHighlightedBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieHighlightedLayerBorderColor;
    } else {
        self.object.backgroundColor = self.object.uieDefaultBackgroundColor;
        self.object.uieLayerBorderColor = self.object.uieDefaultLayerBorderColor;
    }
}

@end
