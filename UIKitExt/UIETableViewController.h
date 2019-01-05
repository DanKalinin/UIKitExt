//
//  UIETableViewController.h
//  Controls
//
//  Created by Dan Kalinin on 12/30/18.
//

#import <UIKit/UIKit.h>
#import "UIEViewController.h"
#import "UIETableView.h"

@class UIETableViewController;
@class UIETableViewControllerOperation;

@protocol UIETableViewControllerDelegate;










@interface UITableViewController (UIE) <UIETableViewDelegate>

@property (readonly) UIETableViewControllerOperation *nseOperation;

@end










@interface UIETableViewController : UITableViewController

@end










@protocol UIETableViewControllerDelegate <UIEViewControllerDelegate>

@end



@interface UIETableViewControllerOperation : UIEViewControllerOperation <UIETableViewControllerDelegate>

@property (weak, readonly) UITableViewController *object;

@end
