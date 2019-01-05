//
//  UIEBarItem.m
//  Controls
//
//  Created by Dan Kalinin on 12/31/18.
//

#import "UIEBarItem.h"










@implementation UIBarItem (UIE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIEBarItemOperation.class;
}

@end










@interface UIEBarItem ()

@end



@implementation UIEBarItem

@end










@interface UIEBarItemOperation ()

@end



@implementation UIEBarItemOperation

@dynamic object;

@end
