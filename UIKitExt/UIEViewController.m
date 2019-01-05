//
//  UIEViewController.m
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEViewController.h"










@implementation UIViewController (UIE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIEViewControllerOperation.class;
}

@end










@interface UIEViewController ()

@end



@implementation UIEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nseOperation viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    [self.nseOperation prepareForSegue:segue sender:sender];
}

@end










@interface UIEViewControllerPrepareForSegue ()

@property UIStoryboardSegue *segue;
@property id sender;

@end



@implementation UIEViewControllerPrepareForSegue

- (instancetype)initWithSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self = super.init;
    
    self.segue = segue;
    self.sender = sender;
    
    return self;
}

@end










@interface UIEViewControllerOperation ()

@property (weak) UIEViewControllerPrepareForSegue *prepareForSegue;

@end



@implementation UIEViewControllerOperation

@dynamic object;

- (instancetype)initWithObject:(UIViewController *)object {
    self = [super initWithObject:object];
    
    object.transitioningDelegate = self;
    
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [self.object.view.nseOperation.delegates addObject:self.object];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.prepareForSegue = [UIEViewControllerPrepareForSegue.alloc initWithSegue:segue sender:sender].nseAutorelease;
}

@end
