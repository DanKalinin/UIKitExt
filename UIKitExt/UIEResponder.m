//
//  UIEResponder.m
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEResponder.h"










@implementation UIResponder (UIE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIEResponderOperation.class;
}

@end










@interface UIEResponder ()

@end



@implementation UIEResponder

@end










@interface UIEResponderOperation ()

@end



@implementation UIEResponderOperation

@dynamic object;

@end
