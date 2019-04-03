//
//  TableViewCell.h
//  Pods
//
//  Created by Dan Kalinin on 03.03.17.
//
//

#import <UIKit/UIKit.h>
#import "View.h"
#import "PickerControl.h"
#import "NumberPickerControl.h"
#import "MultiselectionControl.h"
#import "EdgeSliderControl.h"

@class TableView;

extern NSString *const TableViewCellReuseIdentifier;

typedef NS_ENUM(NSUInteger, TableViewRowReorderingPolicy) {
    TableViewRowReorderingPolicyNone,
    TableViewRowReorderingPolicyInSection
};










@protocol TableViewDataSource <UITableViewDataSource>

@optional
- (void)tableView:(TableView *)tableView configureHeaderView:(UITableViewHeaderFooterView *)headerView forSection:(NSInteger)section;
- (void)tableView:(TableView *)tableView configureFooterView:(UITableViewHeaderFooterView *)footerView forSection:(NSInteger)section;

// Collapsing

- (BOOL)tableView:(TableView *)tableView isCollapsedSection:(NSInteger)section;
- (BOOL)tableView:(TableView *)tableView isCollapsedIndexPath:(NSIndexPath *)indexPath;

// Grouping

- (BOOL)tableView:(TableView *)tableView canGroupRowAtIndexPath:(NSIndexPath *)sourceIndexPath withIndexPath:(NSIndexPath *)destinationIndexPath;
- (void)tableView:(TableView *)tableView groupRowAtIndexPath:(NSIndexPath *)sourceIndexPath withIndexPath:(NSIndexPath *)destinationIndexPath;

@end










@protocol TableViewDelegate <UITableViewDelegate>

@optional
- (CGFloat)tableView:(TableView *)tableView heightForCollapsedRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(TableView *)tableView heightForExpandedRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)tableView:(TableView *)tableView didToggleSelectAllButton:(UIButton *)button;

// Collapsing

- (void)tableView:(TableView *)tableView didCollapse:(BOOL)collapse section:(NSInteger)section;

// Grouping

- (void)tableView:(TableView *)tableView indexPath:(NSIndexPath *)sourceIndexPath didIntersect:(BOOL)intersect indexPath:(NSIndexPath *)destinationIndexPath;

@end










@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ImageView *imageView1;
@property (weak, nonatomic) IBOutlet ImageView *imageView2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint3;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet UIStackView *stackView1;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label12;
@property (weak, nonatomic) IBOutlet UILabel *label13;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView1;

@property (strong, nonatomic) IBOutlet UILabel *sLabel10;
@property (strong, nonatomic) IBOutlet UILabel *sLabel11;
@property (strong, nonatomic) IBOutlet UILabel *sLabel12;
@property (strong, nonatomic) IBOutlet UILabel *sLabel13;

@property (weak, nonatomic) IBOutlet TextField *textField1;

@property (weak, nonatomic) IBOutlet UIControl *control1;

@property (weak, nonatomic) IBOutlet Button *button1;

@property (weak, nonatomic) IBOutlet UISwitch *switch1;

@property (weak, nonatomic) IBOutlet UISlider *slider1;

@property (weak, nonatomic) IBOutlet PickerControl *pickerControl1;
@property (weak, nonatomic) IBOutlet PickerControl *pickerControl2;

@property (weak, nonatomic) IBOutlet NumberPickerControl *numberPickerControl1;
@property (weak, nonatomic) IBOutlet NumberPickerControl *numberPickerControl2;

@property (weak, nonatomic) IBOutlet DoubleNumberPickerControl *doubleNumberPickerControl1;

@property (weak, nonatomic) IBOutlet TimePickerControl *timePickerControl1;

@property (weak, nonatomic) IBOutlet MultiselectionControl *multiselectionControl1;

@property IBInspectable NSString *string1;
@property IBInspectable NSString *string2;
@property IBInspectable NSString *string3;
@property IBInspectable NSString *string4;
@property IBInspectable NSString *string5;

@property IBInspectable UITableViewCellAccessoryType defaultAccessoryType;
@property IBInspectable UITableViewCellAccessoryType selectedAccessoryType;
@property IBInspectable BOOL editable;
@property IBInspectable CGFloat height;

@property IBInspectable NSString *storyboard;
@property IBInspectable NSString *viewController;

@property IBInspectable CGFloat groupInset;

@property IBInspectable CGFloat disabledAlpha;

@property NSIndexPath *indexPath;
@property id userInfo;

@property (readonly) UITableViewCellStateMask state;

@property (readonly) BOOL enabled;
- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated;

@end










@interface TableViewHeaderFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet Button *button1;
@property (weak, nonatomic) IBOutlet Button *button2;
@property (weak, nonatomic) IBOutlet Button *button3;

@end










@interface TableViewCellVerticalSeparator : GradientLayerView

@property IBInspectable UIColor *topColor;
@property IBInspectable UIColor *centerColor;
@property IBInspectable UIColor *bottomColor;

@end










@interface TableView : UITableView

@property (weak, nonatomic) IBOutlet Button *selectAllButton;

@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIView *emptyView;

@property IBInspectable UITableViewCellSeparatorStyle defaultSeparatorStyle;

@property IBInspectable NSString *headerViewNibIdentifier;
@property IBInspectable NSString *headerViewNibName;

@property IBInspectable NSString *footerViewNibIdentifier;
@property IBInspectable NSString *footerViewNibName;

@property IBInspectable BOOL sectionsCollapsible;
@property IBInspectable BOOL sectionsCollapsed;

@property IBInspectable BOOL rowsCollapsible;
@property IBInspectable BOOL rowsCollapsed;

@property IBInspectable BOOL canMoveRows;
@property IBInspectable BOOL canMoveSingleRow;
@property IBInspectable TableViewRowReorderingPolicy rowReorderingPolicy;

@property IBInspectable UITableViewCellEditingStyle cellEditingStyle;
@property IBInspectable BOOL shouldIndentWhileEditing;

@property (readonly) UIPanGestureRecognizer *pgrGroup; // Enable to support grouping

- (IBAction)onHeaderView:(UIButton *)sender;

@end










@interface TableViewController : UITableViewController <TableViewDataSource, TableViewDelegate>

@property (nonatomic) TableView *view;
@property (nonatomic) TableView *tableView;

@property (weak, nonatomic) IBOutlet View *view1;
@property (weak, nonatomic) IBOutlet View *view2;
@property (weak, nonatomic) IBOutlet View *view3;

@property (strong, nonatomic) IBOutlet View *sView1;
@property (strong, nonatomic) IBOutlet View *sView2;
@property (strong, nonatomic) IBOutlet View *sView3;

@property (weak, nonatomic) IBOutlet TableViewCell *cell1;
@property (weak, nonatomic) IBOutlet TableViewCell *cell2;
@property (weak, nonatomic) IBOutlet TableViewCell *cell3;
@property (weak, nonatomic) IBOutlet TableViewCell *cell4;
@property (weak, nonatomic) IBOutlet TableViewCell *cell5;
@property (weak, nonatomic) IBOutlet TableViewCell *cell6;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (weak, nonatomic) IBOutlet Button *button1;
@property (weak, nonatomic) IBOutlet Button *button2;
@property (weak, nonatomic) IBOutlet Button *button3;
@property (weak, nonatomic) IBOutlet Button *button4;
@property (weak, nonatomic) IBOutlet Button *button5;
@property (weak, nonatomic) IBOutlet Button *button6;

@property (strong, nonatomic) IBOutlet Button *sButton1;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem2;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sBarButtonItem1;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sBarButtonItem2;

@property (strong, nonatomic) IBOutlet EdgeSliderControl *sliderControl1;

@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *cells;

@property IBInspectable NSString *string1;
@property IBInspectable NSString *string2;
@property IBInspectable NSString *string3;

@property IBInspectable NSNumber *number1;
@property IBInspectable NSNumber *number2;
@property IBInspectable NSNumber *number3;

@property IBInspectable CGRect rect1;
@property IBInspectable CGRect rect2;
@property IBInspectable CGRect rect3;

@end
