//
//  UIETableViewCell.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/2/19.
//

#import "UIETableViewCell.h"










@implementation UITableViewCell (UIE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIETableViewCellOperation.class;
}

@end










@interface UIETableViewCell ()

@property UIButton *uieButton1;
@property UIButton *uieButton2;
@property UITextField *uieTextField1;
@property UIActivityIndicatorView *uieActivityIndicatorView1;

@end



@implementation UIETableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self.nseOperation setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    [self.nseOperation setHighlighted:highlighted animated:animated];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.nseOperation setEditing:editing animated:animated];
}

@end










@interface UIETableViewCellOperation ()

@property BOOL enabled;

@end



@implementation UIETableViewCellOperation

@dynamic object;

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated {
    self.enabled = enabled;
    
    self.object.userInteractionEnabled = enabled;
    
    self.object.uieButton1.enabled = enabled;
    self.object.uieButton2.enabled = enabled;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.object.uieButton1.selected = selected;
    self.object.uieButton2.selected = selected;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    self.object.uieButton1.highlighted = highlighted;
    self.object.uieButton2.highlighted = highlighted;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
}

@end
