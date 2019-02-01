//
//  UIEWindow.m
//  UIKitExt
//
//  Created by Dan Kalinin on 1/4/19.
//

#import "UIEWindow.h"










@interface UIEKeyboardUserInfo ()

@property CGRect frameBegin;
@property CGRect frameEnd;
@property NSTimeInterval animationDuration;
@property UIViewAnimationCurve animationCurve;
@property BOOL isLocal;

@end



@implementation UIEKeyboardUserInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    
    self.frameBegin = [dictionary[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    self.frameEnd = [dictionary[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.animationDuration = [dictionary[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.animationCurve = [dictionary[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    self.isLocal = [dictionary[UIKeyboardIsLocalUserInfoKey] boolValue];
    
    return self;
}

@end










@interface UIEKeyboard ()

@property (weak) UIEKeyboardUserInfo *userInfo;

@end



@implementation UIEKeyboard

@dynamic delegates;

+ (instancetype)nseShared {
    static UIEKeyboard *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = self.new;
    });
    return shared;
}

- (instancetype)init {
    self = super.init;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(willShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didShowNotification:) name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(willHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didHideNotification:) name:UIKeyboardDidHideNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(willChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didChangeFrameNotification:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    return self;
}

- (void)willShowNotification:(NSNotification *)notification {
    self.userInfo = [UIEKeyboardUserInfo.alloc initWithDictionary:notification.userInfo].nseAutorelease;
    [self.delegates uieKeyboardWillShow:self];
}

- (void)didShowNotification:(NSNotification *)notification {
    self.userInfo = [UIEKeyboardUserInfo.alloc initWithDictionary:notification.userInfo].nseAutorelease;
    [self.delegates uieKeyboardDidShow:self];
}

- (void)willHideNotification:(NSNotification *)notification {
    self.userInfo = [UIEKeyboardUserInfo.alloc initWithDictionary:notification.userInfo].nseAutorelease;
    [self.delegates uieKeyboardWillHide:self];
}

- (void)didHideNotification:(NSNotification *)notification {
    self.userInfo = [UIEKeyboardUserInfo.alloc initWithDictionary:notification.userInfo].nseAutorelease;
    [self.delegates uieKeyboardDidHide:self];
}

- (void)willChangeFrameNotification:(NSNotification *)notification {
    self.userInfo = [UIEKeyboardUserInfo.alloc initWithDictionary:notification.userInfo].nseAutorelease;
    [self.delegates uieKeyboardWillChangeFrame:self];
}

- (void)didChangeFrameNotification:(NSNotification *)notification {
    self.userInfo = [UIEKeyboardUserInfo.alloc initWithDictionary:notification.userInfo].nseAutorelease;
    [self.delegates uieKeyboardDidChangeFrame:self];
}

@end
