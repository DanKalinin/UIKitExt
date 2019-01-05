//
//  UIEStoryboardSegue.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/6/19.
//

#import <UIKit/UIKit.h>










@interface UIStoryboardSegue (UIE)

@property (readonly) UINavigationController *uieDestinationNavigationController;

@end










@interface UIEStoryboardSegue : UIStoryboardSegue

@end
