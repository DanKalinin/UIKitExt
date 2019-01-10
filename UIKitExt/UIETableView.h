//
//  UIETableView.h
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIEScrollView.h"

@class UIETableView;
@class UIETableViewNumberOfSections;
@class UIETableViewNumberOfRowsInSection;
@class UIETableViewCellForRowAtIndexPath;
@class UIETableViewDidSelectRowAtIndexPath;
@class UIETableViewOperation;

@protocol UIETableViewDelegate;










@interface UITableView (UIE)

@property IBOutlet UIView *uieEmptyBackgroundView;

@property (readonly) UIETableViewOperation *nseOperation;

@end










@interface UIETableView : UITableView

@end










@interface UIETableViewNumberOfSections : NSEObject

@property NSInteger sections;

@end










@interface UIETableViewNumberOfRowsInSection : NSEObject

@property NSInteger rows;

@property (readonly) NSInteger section;

- (instancetype)initWithSection:(NSInteger)section;

@end










@interface UIETableViewCellForRowAtIndexPath : NSEObject

@property UITableViewCell *cell;

@property (readonly) NSIndexPath *indexPath;

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath;

@end










@interface UIETableViewDidSelectRowAtIndexPath : NSEObject

@property (readonly) NSIndexPath *indexPath;

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath;

@end










@protocol UIETableViewDelegate <UIEScrollViewDelegate>

@optional
- (void)uieTableViewNumberOfSections:(UITableView *)tableView;
- (void)uieTableViewNumberOfRowsInSection:(UITableView *)tableView;
- (void)uieTableViewCellForRowAtIndexPath:(UITableView *)tableView;
- (void)uieTableViewDidSelectRowAtIndexPath:(UITableView *)tableView;

@end



@interface UIETableViewOperation : UIEScrollViewOperation <UIETableViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (readonly) NSEOrderedSet<UIETableViewDelegate> *delegates;
@property (readonly) BOOL empty;

@property (weak, readonly) UITableView *object;
@property (weak, readonly) UIETableViewNumberOfSections *numberOfSections;
@property (weak, readonly) UIETableViewNumberOfRowsInSection *numberOfRowsInSection;
@property (weak, readonly) UIETableViewCellForRowAtIndexPath *cellForRowAtIndexPath;
@property (weak, readonly) UIETableViewDidSelectRowAtIndexPath *didSelectRowAtIndexPath;

- (void)setEmpty:(BOOL)empty animated:(BOOL)animated;

@end
