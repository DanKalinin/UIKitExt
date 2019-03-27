//
//  HandleView.h
//  UIKitExt
//
//  Created by Dan Kalinin on 3/27/19.
//

#import "View.h"



@interface HandleView : View

@property IBInspectable CGFloat length;

@property (weak, nonatomic) IBOutlet UIView *handle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
