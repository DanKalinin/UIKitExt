//
//  UIEStoryboardSegue.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/6/19.
//

#import "UIEMain.h"
#import "UIENavigationController.h"

@class UIEStoryboardSegue;










@interface UIStoryboardSegue (UIE)

@property (readonly) UINavigationController *uieDestinationNavigationController;

@end










@interface UIEStoryboardSegue : UIStoryboardSegue

@end
