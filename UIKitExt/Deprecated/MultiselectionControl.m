//
//  MultiselectionControl.m
//  Pods
//
//  Created by Dan Kalinin on 03.03.17.
//
//

#import "MultiselectionControl.h"



@interface MultiselectionControl ()

@property (readonly) NSArray *selectedButtons;

@end



@implementation MultiselectionControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.itemKeyPath = @"self";
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIButton *button in self.buttons) {
        [button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (NSArray *)selectedItems {
    NSArray *items = [self.selectedButtons valueForKeyPath:self.itemKeyPath];
    return items;
}

- (void)selectItems:(NSArray *)items animated:(BOOL)animated {
    [self.buttons setValue:@NO forKey:@"selected"];
    
    for (UIButton *button in self.buttons) {
        id item = [button valueForKeyPath:self.itemKeyPath];
        if ([items containsObject:item]) {
            button.selected = YES;
        }
    }
}

#pragma mark - Accessors

- (NSArray *)selectedButtons {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected = YES"];
    NSArray *buttons = [self.buttons filteredArrayUsingPredicate:predicate];
    return buttons;
}

#pragma mark - Actions

- (void)onButton:(UIButton *)sender {
    if (sender.selected && (self.selectedButtons.count <= self.minimumSelectedButtonCount)) return;
    
    sender.selected = !sender.selected;
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
