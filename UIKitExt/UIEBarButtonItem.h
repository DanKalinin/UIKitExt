//
//  UIEBarButtonItem.h
//  UIKitExt
//
//  Created by Dan Kalinin on 12/31/18.
//

#import <UIKit/UIKit.h>
#import "UIEBarItem.h"

@class UIEBarButtonItem;
@class UIEBarButtonItemOperation;

@protocol UIEBarButtonItemDelegate;










@interface UIBarButtonItem (UIE)

@property (readonly) UIEBarButtonItemOperation *nseOperation;

@end










@interface UIEBarButtonItem : UIBarButtonItem

@end










@protocol UIEBarButtonItemDelegate <UIEBarItemDelegate>

@optional
- (void)uieBarButtonItemEvent:(UIBarButtonItem *)item;

@end



@interface UIEBarButtonItemOperation : UIEBarItemOperation <UIEBarButtonItemDelegate>

@property (readonly) NSEOrderedSet<UIEBarButtonItemDelegate> *delegates;

@property (weak, readonly) UIBarButtonItem *object;
@property (weak, readonly) UIEvent *event;

@end
