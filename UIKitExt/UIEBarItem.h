//
//  UIEBarItem.h
//  UIKitExt
//
//  Created by Dan Kalinin on 12/31/18.
//

#import "UIEObject.h"

@class UIEBarItem;
@class UIEBarItemOperation;

@protocol UIEBarItemDelegate;










@interface UIBarItem (UIE)

@property (readonly) UIEBarItemOperation *uieOperation;

@end










@interface UIEBarItem : UIBarItem

@end










@protocol UIEBarItemDelegate <NSEObjectDelegate>

@end



@interface UIEBarItemOperation : NSEObjectOperation <UIEBarItemDelegate>

@property (weak, readonly) UIBarItem *object;

@end
