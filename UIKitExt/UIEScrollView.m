//
//  UIEScrollView.m
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEScrollView.h"










@implementation UIScrollView (UIE)

@dynamic uieOperation;

- (Class)uieOperationClass {
    return UIEScrollViewOperation.class;
}

@end










@interface UIEScrollView ()

@end



@implementation UIEScrollView

@end










@interface UIEScrollViewOperation ()

@end



@implementation UIEScrollViewOperation

@dynamic object;

- (instancetype)initWithObject:(UIScrollView *)object {
    self = [super initWithObject:object];
    
    object.delegate = self;
    
    return self;
}

@end
