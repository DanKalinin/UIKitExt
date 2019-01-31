//
//  UIETableViewCell.h
//  UIKitExt
//
//  Created by Dan Kalinin on 1/2/19.
//

#import "UIEView.h"

@class UIETableViewCell;
@class UIETableViewCellOperation;

@protocol UIETableViewCellDelegate;










@interface UITableViewCell (UIE)

@property (readonly) UIETableViewCellOperation *uieOperation;

@end










@interface UIETableViewCell : UITableViewCell

@end










@protocol UIETableViewCellDelegate <UIEViewDelegate>

@end



@interface UIETableViewCellOperation : UIEViewOperation <UIETableViewCellDelegate>

@property (weak, readonly) UITableViewCell *object;

@property (readonly) BOOL enabled;

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end
