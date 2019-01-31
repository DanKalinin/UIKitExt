//
//  UIEScrollView.h
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEView.h"

@class UIEScrollView;
@class UIEScrollViewOperation;

@protocol UIEScrollViewDelegate;










@interface UIScrollView (UIE)

@property (readonly) UIEScrollViewOperation *uieOperation;

@end










@interface UIEScrollView : UIScrollView

@end










@protocol UIEScrollViewDelegate <UIEViewDelegate>

@end



@interface UIEScrollViewOperation : UIEViewOperation <UIEScrollViewDelegate, UIScrollViewDelegate>

@property (weak, readonly) UIScrollView *object;

@end
