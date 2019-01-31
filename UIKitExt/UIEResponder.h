//
//  UIEResponder.h
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEObject.h"

@class UIEResponder;
@class UIEResponderOperation;

@protocol UIEResponderDelegate;










@interface UIResponder (UIE)

@property (readonly) UIEResponderOperation *uieOperation;

@end










@interface UIEResponder : UIResponder

@end










@protocol UIEResponderDelegate <NSEObjectDelegate>

@end



@interface UIEResponderOperation : NSEObjectOperation <UIEResponderDelegate>

@property (weak, readonly) UIResponder *object;

@end
