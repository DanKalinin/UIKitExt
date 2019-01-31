//
//  UIEPasscodeViewController.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/5/19.
//

#import "UIEPasscodeViewController.h"










@interface UIEPasscodeViewController ()

@end



@implementation UIEPasscodeViewController

@dynamic view;
@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIEPasscodeViewControllerOperation.class;
}

@end










@interface UIEPasscodeViewControllerOperation ()

@end



@implementation UIEPasscodeViewControllerOperation

@dynamic object;

#pragma mark - UIEPasscodeViewDelegate

@end
