//
//  UIEHandleView.h
//  UIKitExt
//
//  Created by Dan Kalinin on 3/27/19.
//

#import "UIEView.h"

@class UIEHandleView;
@class UIEHandleViewOperation;










@interface UIEHandleView : UIEView

@property IBInspectable UIFloatRange range;

@property (readonly) UIEHandleViewOperation *nseOperation;

@end










@protocol UIEHandleViewDelegate <UIEViewDelegate>

@end



@interface UIEHandleViewOperation : UIEViewOperation <UIEHandleViewDelegate>

@property (readonly) NSMutableOrderedSet<UIEHandleViewDelegate> *delegates;

@property (weak, readonly) UIEHandleView *object;

@end
