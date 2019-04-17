//
//  UIESegmentedControl.h
//  UIKitExt
//
//  Created by Dan Kalinin on 4/17/19.
//

#import "UIEControl.h"

@class UIESegmentedControl;
@class UIESegmentedControlOperation;

@protocol UIESegmentedControlDelegate;










@interface UISegmentedControl (UIE)

@end










@interface UIESegmentedControl : UISegmentedControl

// TODO: Views bound to segments - @ hidden = YES | NO

@end










@protocol UIESegmentedControlDelegate <UIEControlDelegate>

@end



@interface UIESegmentedControlOperation : UIEControlOperation <UIESegmentedControlDelegate>

@end
