//
//  UIEObject.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/31/19.
//

#import "UIEObject.h"










@implementation NSObject (UIE)

- (Class)uieOperationClass {
    return NSEObjectOperation.class;
}

- (NSEObjectOperation *)uieOperation {
    NSEObjectOperation *operation = [self nseOperationForKey:@selector(uieOperation) ofClass:self.uieOperationClass];
    return operation;
}

@end










@interface UIEObject ()

@end



@implementation UIEObject

@end
