//
//  UIEAlertController.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/4/19.
//

#import "UIEAlertController.h"










@implementation UIAlertAction (UIE)

@dynamic uieOperation;

+ (instancetype)uieActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style delegate:(id<UIEAlertActionDelegate>)delegate {
    UIAlertAction *action = [self actionWithTitle:title style:style handler:^(UIAlertAction *action) {
        [action.uieOperation.delegates uieAlertActionEvent:action];
    }];
    [action.uieOperation.delegates addObject:delegate];
    return action;
}

- (Class)uieOperationClass {
    return UIEAlertActionOperation.class;
}

@end










@interface UIEAlertAction ()

@end



@implementation UIEAlertAction

@end










@interface UIEAlertActionOperation ()

@end



@implementation UIEAlertActionOperation

@dynamic delegates;
@dynamic object;

@end
