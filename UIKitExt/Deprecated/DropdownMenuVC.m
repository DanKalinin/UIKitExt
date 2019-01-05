//
//  DropdownMenuVC.m
//  Dropdown
//
//  Created by Dan Kalinin on 12/9/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "DropdownMenuVC.h"
#import <Helpers/Helpers.h>










@interface DropdownMenuVC ()

@end



@implementation DropdownMenuVC {
    __weak UITableViewController *menuTVC;
    __weak UIViewController *childVC;
    
    NSString *buttonTitle, *selectedButtonTitle;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sliderControl.edge = UIRectEdgeTop;
    self.sliderControl.inset = 0.0;
    [self.sliderControl addTarget:self action:@selector(onDimmingView:) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonTitle = [self.button titleForState:UIControlStateNormal];
    selectedButtonTitle = [self.button titleForState:UIControlStateSelected];
    
    UIImage *image = [self.button imageForState:UIControlStateSelected];
    [self.button setImage:image forState:(UIControlStateSelected | UIControlStateHighlighted)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.sliderControl];
    
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc.view.superview isEqual:self.sliderControl]) {
            menuTVC = (UITableViewController *)vc;
            break;
        }
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    if (menuTVC.tableView.contentSize.height < self.view.frame.size.height) {
        self.sliderControl.intrinsicContentSize = menuTVC.tableView.contentSize;
    } else {
        self.sliderControl.intrinsicContentSize = self.view.frame.size;
    }
}

- (void)showViewController:(UIViewController *)vc {
    [self removeEmbeddedViewController:childVC];
    [self embedViewController:vc toView:self.view];
    childVC = vc;
    
    NSString *title = vc.title ? vc.title : buttonTitle;
    NSString *selectedTitle = vc.title ? vc.title : selectedButtonTitle;
    
    [self.button setTitle:title forState:UIControlStateNormal];
    [self.button setTitle:selectedTitle forState:UIControlStateSelected];
}

#pragma mark - Actions

- (void)onButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.sliderControl setSelected:sender.selected animated:YES];
}

- (void)onDimmingView:(EdgeSliderControl *)sender {
    self.button.selected = NO;
}

@end










@interface DropdownMenuSegue ()

@end



@implementation DropdownMenuSegue {
    __weak DropdownMenuVC *menuVC;
}

- (instancetype)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination {
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        menuVC = (DropdownMenuVC *)source.parentViewController;
    }
    return self;
}

- (void)perform {
    [menuVC onButton:menuVC.button];
    [menuVC showViewController:self.destinationViewController];
}

@end
