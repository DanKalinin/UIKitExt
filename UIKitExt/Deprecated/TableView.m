//
//  TableViewCell.m
//  Pods
//
//  Created by Dan Kalinin on 03.03.17.
//
//

#import "TableView.h"
#import <Helpers/Helpers.h>

NSString *const TableViewCellReuseIdentifier = @"Cell";










@interface TableViewCell ()

@property UITableViewCellStateMask state;
@property BOOL enabled;

@end



@implementation TableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.disabledAlpha = 0.5;
        self.enabled = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (self.selectedAccessoryType == self.defaultAccessoryType) return;
    
    self.accessoryType = selected ? self.selectedAccessoryType : self.defaultAccessoryType;
}

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated {
    self.enabled = enabled;
    self.userInteractionEnabled = enabled;
    self.contentView.alpha = enabled ? 1.0 : self.disabledAlpha;
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    [super willTransitionToState:state];
    
    self.state = state;
}

@end










@interface TableViewHeaderFooterView ()

@end



@implementation TableViewHeaderFooterView

@end










@interface TableViewCellVerticalSeparator ()

@end



@implementation TableViewCellVerticalSeparator

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.topColor = [UIColor whiteColor];
        self.centerColor = [UIColor colorWithHexString:@"c8c7cc"];
        self.bottomColor = self.centerColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.uiColors = @[self.topColor, self.centerColor, self.bottomColor];
    self.layer.startPoint = CGPointZero;
    self.layer.endPoint = CGPointMake(0.0, 1.0);
}

@end










@interface TableView () <TableViewDataSource, TableViewDelegate, UIGestureRecognizerDelegate>

@property SurrogateArray<TableViewDataSource> *originalDataSource;
@property SurrogateArray<TableViewDelegate> *originalDelegate;

@property SurrogateArray<TableViewDataSource> *dataSources;
@property SurrogateArray<TableViewDelegate> *delegates;

@property NSMutableIndexSet *collapsedSections;
@property NSMutableSet *collapsedRows;

@property TableViewCell *sourceCell;
@property TableViewCell *destinationCell;
@property NSIndexPath *sourceIndexPath;

@property UIPanGestureRecognizer *pgrGroup;

@end



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"

@implementation TableView

@dynamic backgroundView;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        super.dataSource = self;
        super.delegate = self;
        
        self.canMoveSingleRow = YES;
        
        self.cellEditingStyle = UITableViewCellEditingStyleDelete;
        self.shouldIndentWhileEditing = YES;
        
        self.pgrGroup = [UIPanGestureRecognizer.alloc initWithTarget:self action:@selector(onPan:)];
        self.pgrGroup.enabled = NO;
        self.pgrGroup.cancelsTouchesInView = NO;
        self.pgrGroup.delegate = self;
        [self addGestureRecognizer:self.pgrGroup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.defaultSeparatorStyle = self.separatorStyle;
    
    self.collapsedSections = [NSMutableIndexSet indexSet];
    self.collapsedRows = [NSMutableSet set];
    
    if (self.headerViewNibName) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:self.headerViewNibIdentifier];
        UINib *nib = [UINib nibWithNibName:self.headerViewNibName bundle:bundle];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:self.headerViewNibName];
    }
    
    if (self.footerViewNibName) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:self.footerViewNibIdentifier];
        UINib *nib = [UINib nibWithNibName:self.footerViewNibName bundle:bundle];
        [self registerNib:nib forHeaderFooterViewReuseIdentifier:self.footerViewNibName];
    }
    
    [self.selectAllButton addTarget:self action:@selector(onSelectAll:) forControlEvents:UIControlEventValueChanged];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    
    if (!newWindow) return;
    
    if (self.selectAllButton) {
        self.selectAllButton.selected = (self.indexPathsForSelectedRows.count == self.numberOfRows);
    }
}

#pragma mark - Accessors

- (void)setDataSource:(id<TableViewDataSource>)dataSource {
    if (dataSource) {
        self.originalDataSource = (id)SurrogateArray.new;
        [self.originalDataSource addObject:dataSource];
        
        self.dataSources = (id)SurrogateArray.new;
        [self.dataSources addObject:dataSource];
        [self.dataSources addObject:self];
        [super setDataSource:self.dataSources];
    } else {
        [super setDataSource:self];
    }
}

- (void)setDelegate:(id<TableViewDelegate>)delegate {
    if (delegate) {
        self.originalDelegate = (id)SurrogateArray.new;
        [self.originalDelegate addObject:delegate];
        
        self.delegates = (id)SurrogateArray.new;
        [self.delegates addObject:delegate];
        [self.delegates addObject:self];
        [super setDelegate:self.delegates];
    } else {
        [super setDelegate:self];
    }
}

#pragma mark - Table view

- (void)reloadData {
    [super reloadData];
    
    if (self.sectionsCollapsed) {
        NSRange range = NSMakeRange(0, self.numberOfSections);
        [self.collapsedSections addIndexesInRange:range];
    } else {
        SEL selector = @selector(tableView:isCollapsedSection:);
        if ([self.originalDataSource respondsToSelector:selector]) {
            for (NSInteger section = 0; section < self.numberOfSections; section++) {
                BOOL collapsed = [self.originalDataSource tableView:self isCollapsedSection:section];
                if (collapsed) {
                    [self.collapsedSections addIndex:section];
                }
            }
        }
    }
    
    if (self.rowsCollapsed) {
        [self.collapsedRows addObjectsFromArray:self.indexPaths];
    } else {
        SEL selector = @selector(tableView:isCollapsedIndexPath:);
        if ([self.originalDataSource respondsToSelector:selector]) {
            for (NSIndexPath *indexPath in self.indexPaths) {
                BOOL collapsed = [self.originalDataSource tableView:self isCollapsedIndexPath:indexPath];
                if (collapsed) {
                    [self.collapsedRows addObject:indexPath];
                }
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(TableView *)tableView {
    NSInteger sections = [self.dataSources.lastReturnValue integerValue];
    if (self.emptyView) {
        BOOL show = (sections == 0);
        if (sections == 1) {
            NSInteger rows = [self.originalDataSource tableView:self numberOfRowsInSection:0];
            show = (rows == 0);
        }
        self.backgroundView = show ? self.emptyView : nil;
        self.separatorStyle = show ? UITableViewCellSeparatorStyleNone : self.defaultSeparatorStyle;
    }
    return sections;
}

- (CGFloat)tableView:(TableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionsCollapsible) {
        BOOL collapsed = [self.collapsedSections containsIndex:indexPath.section];
        if (collapsed) {
            return 0.0;
        }
    }
    
    CGFloat height = tableView.rowHeight;
    
    SEL selector;
    if (self.rowsCollapsible) {
        BOOL collapsed = [self.collapsedRows containsObject:indexPath];
        if (collapsed) {
            selector = @selector(tableView:heightForCollapsedRowAtIndexPath:);
            if ([self.originalDelegate respondsToSelector:selector]) {
                height = [self.originalDelegate tableView:tableView heightForCollapsedRowAtIndexPath:indexPath];
            }
        } else {
            selector = @selector(tableView:heightForExpandedRowAtIndexPath:);
            if ([self.originalDelegate respondsToSelector:selector]) {
                height = [self.originalDelegate tableView:tableView heightForExpandedRowAtIndexPath:indexPath];
            }
        }
    } else {
        selector = @selector(tableView:heightForRowAtIndexPath:);
        if ([self.originalDelegate respondsToSelector:selector]) {
            height = [self.originalDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
    
    return height;
}

- (UIView *)tableView:(TableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view;
    
    SEL selector = @selector(tableView:viewForHeaderInSection:);
    if ([self.originalDelegate respondsToSelector:selector]) {
        view = [self.originalDelegate tableView:tableView viewForHeaderInSection:section];
    } else {
        TableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerViewNibName];
        if (self.sectionsCollapsible) {
            headerView.button1.tag = section;
            headerView.button1.selected = [self.collapsedSections containsIndex:section];
            UIImage *image = [headerView.button3 imageForState:UIControlStateSelected];
            [headerView.button3 setImage:image forState:(UIControlStateSelected | UIControlStateHighlighted)];
        }
        selector = @selector(tableView:configureHeaderView:forSection:);
        if ([self.originalDataSource respondsToSelector:selector]) {
            [self.originalDataSource tableView:tableView configureHeaderView:headerView forSection:section];
        }
        view = headerView;
    }
    
    return view;
}

- (CGFloat)tableView:(TableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height;
    
    SEL selector = @selector(tableView:heightForHeaderInSection:);
    if ([self.originalDelegate respondsToSelector:selector]) {
        height = [self.originalDelegate tableView:tableView heightForHeaderInSection:section];
    } else {
        height = tableView.sectionHeaderHeight;
    }
    
    return height;
}

- (UIView *)tableView:(TableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view;
    
    SEL selector = @selector(tableView:viewForFooterInSection:);
    if ([self.originalDelegate respondsToSelector:selector]) {
        view = [self.originalDelegate tableView:tableView viewForFooterInSection:section];
    } else {
        TableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerViewNibName];
        selector = @selector(tableView:configureFooterView:forSection:);
        if ([self.originalDataSource respondsToSelector:selector]) {
            [self.originalDataSource tableView:tableView configureFooterView:footerView forSection:section];
        }
        view = footerView;
    }
    
    return view;
}

- (CGFloat)tableView:(TableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.sectionsCollapsible) {
        BOOL collapsed = [self.collapsedSections containsIndex:section];
        if (!collapsed) {
            return CGFLOAT_MIN;
        }
    }
    
    CGFloat height;
    
    SEL selector = @selector(tableView:heightForFooterInSection:);
    if ([self.originalDelegate respondsToSelector:selector]) {
        height = [self.originalDelegate tableView:tableView heightForFooterInSection:section];
    } else {
        height = tableView.sectionFooterHeight;
    }
    
    return height;
}

- (void)tableView:(TableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectAllButton.selected = (self.indexPathsForSelectedRows.count == self.numberOfRows);
    
    if (self.rowsCollapsible) {
        if ([self.collapsedRows containsObject:indexPath]) {
            [self.collapsedRows removeObject:indexPath];
        } else {
            [self.collapsedRows addObject:indexPath];
        }
        
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

- (void)tableView:(TableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectAllButton.selected = NO;
    
    if (self.rowsCollapsible) {
        [self.collapsedRows addObject:indexPath];
        
        [tableView beginUpdates];
        [tableView endUpdates];
    }
}

// Reordering

- (BOOL)tableView:(TableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL canMove = NO;
    if (self.canMoveRows) {
        if (self.canMoveSingleRow) {
            canMove = YES;
        } else {
            NSInteger rowsInSection = [self numberOfRowsInSection:indexPath.section];
            canMove = (rowsInSection > 1);
        }
    }
    return canMove;
}

- (NSIndexPath *)tableView:(TableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    NSIndexPath *ip;
    if (self.rowReorderingPolicy == TableViewRowReorderingPolicyNone) {
        ip = proposedDestinationIndexPath;
    } else if (self.rowReorderingPolicy == TableViewRowReorderingPolicyInSection) {
        if (proposedDestinationIndexPath.section > sourceIndexPath.section) {
            NSInteger rowsInSection = [self numberOfRowsInSection:sourceIndexPath.section];
            ip = [NSIndexPath indexPathForRow:(rowsInSection - 1) inSection:sourceIndexPath.section];
        } else if (proposedDestinationIndexPath.section < sourceIndexPath.section) {
            ip = [NSIndexPath indexPathForRow:0 inSection:sourceIndexPath.section];
        } else {
            ip = proposedDestinationIndexPath;
        }
    }
    return ip;
}

// Editing

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCellEditingStyle style = self.cellEditingStyle;
    
    if ([self.originalDelegate respondsToSelector:_cmd]) {
        style = [self.originalDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    
    return style;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL should = self.shouldIndentWhileEditing;
    
    if ([self.originalDelegate respondsToSelector:_cmd]) {
        should = [self.originalDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    
    return should;
}

#pragma mark - Gesture recognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL shouldRecognize = (self.pgrGroup && ([gestureRecognizer isEqual:self.pgrGroup] || [otherGestureRecognizer isEqual:self.pgrGroup]));
    return shouldRecognize;
}

#pragma mark - Actions

- (IBAction)onHeaderView:(UIButton *)sender {
    if (sender.selected) {
        [self.collapsedSections addIndex:sender.tag];
    } else {
        [self.collapsedSections removeIndex:sender.tag];
    }
    
    [self beginUpdates];
    [self endUpdates];
    
    SEL selector = @selector(tableView:didCollapse:section:);
    if ([self.originalDelegate respondsToSelector:selector]) {
        [self.originalDelegate tableView:self didCollapse:sender.selected section:sender.tag];
    }
}

- (void)onSelectAll:(Button *)sender {
    for (NSInteger section = 0; section < self.numberOfSections; section++) {
        NSInteger rows = [self numberOfRowsInSection:section];
        for (NSInteger row = 0; row < rows; row++) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:row inSection:section];
            if (sender.selected) {
                [self selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionNone];
            } else {
                [self deselectRowAtIndexPath:ip animated:YES];
            }
        }
    }
    
    SEL selector = @selector(tableView:didToggleSelectAllButton:);
    if ([self.originalDelegate respondsToSelector:selector]) {
        [self.originalDelegate tableView:self didToggleSelectAllButton:sender];
    }
}

- (void)onPan:(UIPanGestureRecognizer *)pgr {
    if (pgr.state == UIGestureRecognizerStateBegan) {
        
        CGPoint location = [pgr locationInView:self];
        UIView *view = [self hitTest:location withEvent:nil];
        if (view && [NSStringFromClass(view.class) isEqualToString:@"UITableViewCellReorderControl"]) {
            UIView *superview = view.superview;
            if (superview && [superview isKindOfClass:TableViewCell.class]) {
                self.sourceCell = (TableViewCell *)view.superview;
                self.sourceIndexPath = [self indexPathForCell:self.sourceCell];
                self.destinationCell = nil;
            }
        }
        
    } else if (pgr.state >= UIGestureRecognizerStateChanged) {
        
        if (!self.sourceCell) return;
        
        CGFloat xCenter = CGRectGetMidX(self.sourceCell.frame);
        CGFloat yTop = CGRectGetMinY(self.sourceCell.frame) + self.sourceCell.groupInset;
        CGFloat yBottom = CGRectGetMaxY(self.sourceCell.frame) - self.sourceCell.groupInset;
        
        CGPoint pTop = CGPointMake(xCenter, yTop);
        CGPoint pBottom = CGPointMake(xCenter, yBottom);
        
        TableViewCell *destinationCell = nil;
        for (TableViewCell *cell in self.visibleCells) {
            if ([cell isEqual:self.sourceCell]) continue;
            if (CGRectContainsPoint(cell.frame, pTop)) {
                destinationCell = cell;
                break;
            }
            if (CGRectContainsPoint(cell.frame, pBottom)) {
                destinationCell = cell;
                break;
            }
        }
        
        if (pgr.state == UIGestureRecognizerStateChanged) {
            if (destinationCell && ![destinationCell isEqual:self.destinationCell]) {
                self.destinationCell = destinationCell;
                
                SEL selector = @selector(tableView:canGroupRowAtIndexPath:withIndexPath:);
                if ([self.originalDataSource respondsToSelector:selector]) {
                    NSIndexPath *destinationIndexPath = [self indexPathForCell:destinationCell];
                    BOOL canGroup = [self.originalDataSource tableView:self canGroupRowAtIndexPath:self.sourceIndexPath withIndexPath:destinationIndexPath];
                    if (canGroup) {
                        selector = @selector(tableView:indexPath:didIntersect:indexPath:);
                        if ([self.originalDelegate respondsToSelector:selector]) {
                            [self.originalDelegate tableView:self indexPath:self.sourceIndexPath didIntersect:YES indexPath:destinationIndexPath];
                        }
                    }
                }
            } else if (self.destinationCell && ![self.destinationCell isEqual:destinationCell]) {
                SEL selector = @selector(tableView:indexPath:didIntersect:indexPath:);
                if ([self.originalDelegate respondsToSelector:selector]) {
                    NSIndexPath *destinationIndexPath = [self indexPathForCell:self.destinationCell];
                    [self.originalDelegate tableView:self indexPath:self.sourceIndexPath didIntersect:NO indexPath:destinationIndexPath];
                }
                
                self.destinationCell = destinationCell;
            }
        } else {
            if (destinationCell) {
                SEL selector = @selector(tableView:canGroupRowAtIndexPath:withIndexPath:);
                if ([self.originalDataSource respondsToSelector:selector]) {
                    NSIndexPath *destinationIndexPath = [self indexPathForCell:destinationCell];
                    BOOL canGroup = [self.originalDataSource tableView:self canGroupRowAtIndexPath:self.sourceIndexPath withIndexPath:destinationIndexPath];
                    if (canGroup) {
                        selector = @selector(tableView:groupRowAtIndexPath:withIndexPath:);
                        if ([self.originalDataSource respondsToSelector:selector]) {
                            NSIndexPath *destinationIndexPath = [self indexPathForCell:destinationCell];
                            [self.originalDataSource tableView:self groupRowAtIndexPath:self.sourceIndexPath withIndexPath:destinationIndexPath];
                        }
                    }
                }
            }
            
            self.sourceCell = nil;
        }
        
    }
}

#pragma mark - Helpers

@end

#pragma clang diagnostic pop










@interface TableViewController ()

@end



@implementation TableViewController

@dynamic view;
@dynamic tableView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows;
    if (self.cells.count > 0) {
        rows = self.cells.count;
    } else {
        rows = [super tableView:tableView numberOfRowsInSection:section];
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.cells.count > 0) {
        cell = self.cells[indexPath.row];
    } else {
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (self.cells.count > 0) {
        TableViewCell *cell = self.cells[indexPath.row];
        height = cell.height * !cell.hidden;
    } else {
        height = [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return height;
}

@end
