//
//  UIEScrollView.h
//  Controls
//
//  Created by Dan Kalinin on 12/30/18.
//

#import <UIKit/UIKit.h>
#import "UIEView.h"

@class UIEScrollView;
@class UIEScrollViewOperation;

@protocol UIEScrollViewDelegate;










@interface UIScrollView (UIE)

@property (readonly) UIEScrollViewOperation *nseOperation;

@end










@interface UIEScrollView : UIScrollView

@end










@protocol UIEScrollViewDelegate <UIEViewDelegate>

@end



@interface UIEScrollViewOperation : UIEViewOperation <UIEScrollViewDelegate, UIScrollViewDelegate>

@property (weak, readonly) UIScrollView *object;

@end
