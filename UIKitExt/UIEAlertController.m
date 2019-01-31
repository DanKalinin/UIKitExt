//
//  UIEAlertController.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/4/19.
//

#import "UIEAlertController.h"










@implementation UIAlertAction (UIE)

@dynamic nseOperation;

+ (instancetype)uieActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style delegate:(id<UIEAlertActionDelegate>)delegate {
    UIAlertAction *action = [self actionWithTitle:title style:style handler:^(UIAlertAction *action) {
        [action.nseOperation.delegates uieAlertActionEvent:action];
    }];
    [action.nseOperation.delegates addObject:delegate];
    return action;
}

- (Class)nseOperationClass {
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
