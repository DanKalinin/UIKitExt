//
//  UIEBarItem.h
//  UIKitExt
//
//  Created by Dan Kalinin on 12/31/18.
//

#import <UIKit/UIKit.h>
#import <FoundationExt/FoundationExt.h>

@class UIEBarItem;
@class UIEBarItemOperation;

@protocol UIEBarItemDelegate;










@interface UIBarItem (UIE)

@property (readonly) UIEBarItemOperation *nseOperation;

@end










@interface UIEBarItem : UIBarItem

@end










@protocol UIEBarItemDelegate <NSEObjectDelegate>

@end



@interface UIEBarItemOperation : NSEObjectOperation <UIEBarItemDelegate>

@property (weak, readonly) UIBarItem *object;

@end
