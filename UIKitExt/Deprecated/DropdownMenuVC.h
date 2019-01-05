//
//  DropdownMenuVC.h
//  Dropdown
//
//  Created by Dan Kalinin on 12/9/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EdgeSliderControl.h"










@interface DropdownMenuVC : UIViewController

@property (strong, nonatomic) IBOutlet EdgeSliderControl *sliderControl;
@property (weak, nonatomic) IBOutlet UIButton *button;

- (void)showViewController:(UIViewController *)vc;

@end










@interface DropdownMenuSegue : UIStoryboardSegue

@end
