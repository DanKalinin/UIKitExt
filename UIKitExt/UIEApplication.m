//
//  UIEApplication.m
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEApplication.h"










@implementation UIApplication (UIE)

@dynamic uieOperation;

- (Class)uieOperationClass {
    return UIEApplicationOperation.class;
}

@end










@interface UIEApplication ()

@end



@implementation UIEApplication

- (instancetype)init {
    self = super.init;
    
    (void)self.uieOperation;
    
    return self;
}

@end










@interface UIEApplicationOperation ()

@end



@implementation UIEApplicationOperation

@dynamic object;

- (instancetype)initWithObject:(UIApplication *)object {
    self = [super initWithObject:object];
    
    object.delegate = self;
    
    return self;
}

@end
