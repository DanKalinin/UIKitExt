//
//  UIEAlertController.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/4/19.
//

#import "UIEViewController.h"

@class UIEAlertAction;
@class UIEAlertActionOperation;

@protocol UIEAlertActionDelegate;










@interface UIAlertAction (UIE)

@property (readonly) UIEAlertActionOperation *uieOperation;

+ (instancetype)uieActionWithTitle:(NSString *)title style:(UIAlertActionStyle)style delegate:(id<UIEAlertActionDelegate>)delegate;

@end










@interface UIEAlertAction : UIAlertAction

@end










@protocol UIEAlertActionDelegate <NSEObjectDelegate>

@optional
- (void)uieAlertActionEvent:(UIAlertAction *)action;

@end



@interface UIEAlertActionOperation : NSEObjectOperation

@property (readonly) NSMutableOrderedSet<UIEAlertActionDelegate> *delegates;

@property (weak, readonly) UIAlertAction *object;

@end
