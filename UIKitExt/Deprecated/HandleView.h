//
//  HandleView.h
//  UIKitExt
//
//  Created by Dan Kalinin on 3/27/19.
//

#import "Control.h"



@interface HandleView : Control

@property IBInspectable CGFloat length;

@property (weak, nonatomic) IBOutlet UIView *handle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (readonly) BOOL expanded;

- (void)setLength:(CGFloat)length animated:(BOOL)animated;

@end
