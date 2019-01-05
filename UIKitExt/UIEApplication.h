//
//  UIEApplication.h
//  Controls
//
//  Created by Dan Kalinin on 12/30/18.
//

#import <UIKit/UIKit.h>
#import "UIEResponder.h"

@class UIEApplication;
@class UIEApplicationOperation;

@protocol UIEApplicationDelegate;










@interface UIApplication (UIE)

@property (readonly) UIEApplicationOperation *nseOperation;

@end










@interface UIEApplication : UIApplication

@end










@protocol UIEApplicationDelegate <UIEResponderDelegate>

@end



@interface UIEApplicationOperation : UIEResponderOperation <UIEApplicationDelegate, UIApplicationDelegate>

@property (nonatomic) UIWindow *window;

@property (weak, readonly) UIApplication *object;

@end
