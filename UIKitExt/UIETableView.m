//
//  UIETableView.m
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIETableView.h"










@implementation UITableView (UIE)

@dynamic uieOperation;
@dynamic uieEmptyBackgroundView;

- (Class)uieOperationClass {
    return UIETableViewOperation.class;
}

@end










@interface UIETableView ()

@property UIView *uieEmptyBackgroundView;

@end



@implementation UIETableView

@end










@interface UIETableViewNumberOfSections ()

@end



@implementation UIETableViewNumberOfSections

@end










@interface UIETableViewNumberOfRowsInSection ()

@property NSInteger section;

@end



@implementation UIETableViewNumberOfRowsInSection

- (instancetype)initWithSection:(NSInteger)section {
    self = super.init;
    
    self.section = section;
    
    return self;
}

@end










@interface UIETableViewCellForRowAtIndexPath ()

@property NSIndexPath *indexPath;

@end



@implementation UIETableViewCellForRowAtIndexPath

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath {
    self = super.init;
    
    self.indexPath = indexPath;
    
    return self;
}

@end










@interface UIETableViewDidSelectRowAtIndexPath ()

@property NSIndexPath *indexPath;

@end



@implementation UIETableViewDidSelectRowAtIndexPath

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath {
    self = super.init;
    
    self.indexPath = indexPath;
    
    return self;
}

@end










@interface UIETableViewOperation ()

@property BOOL empty;

@property (weak) UIETableViewNumberOfSections *numberOfSections;
@property (weak) UIETableViewNumberOfRowsInSection *numberOfRowsInSection;
@property (weak) UIETableViewCellForRowAtIndexPath *cellForRowAtIndexPath;
@property (weak) UIETableViewDidSelectRowAtIndexPath *didSelectRowAtIndexPath;

@end



@implementation UIETableViewOperation

@dynamic delegates;
@dynamic object;

- (instancetype)initWithObject:(UITableView *)object {
    self = [super initWithObject:object];
    
    object.dataSource = self;
    
    return self;
}

- (void)setEmpty:(BOOL)empty animated:(BOOL)animated {
    self.empty = empty;
    
    [self.object reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.didSelectRowAtIndexPath = [UIETableViewDidSelectRowAtIndexPath.alloc initWithIndexPath:indexPath].nseAutorelease;
    [self.delegates uieTableViewDidSelectRowAtIndexPath:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    self.numberOfSections = UIETableViewNumberOfSections.new.nseAutorelease;
    [self.delegates uieTableViewNumberOfSections:tableView];
    
    self.numberOfSections.sections *= !self.empty;
    
    if (tableView.uieEmptyBackgroundView) {
        if (self.numberOfSections.sections > 0) {
            tableView.backgroundView = nil;
        } else {
            tableView.backgroundView = tableView.uieEmptyBackgroundView;
        }
    }
    
    return self.numberOfSections.sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.numberOfRowsInSection = [UIETableViewNumberOfRowsInSection.alloc initWithSection:section].nseAutorelease;
    [self.delegates uieTableViewNumberOfRowsInSection:tableView];
    return self.numberOfRowsInSection.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cellForRowAtIndexPath = [UIETableViewCellForRowAtIndexPath.alloc initWithIndexPath:indexPath].nseAutorelease;
    [self.delegates uieTableViewCellForRowAtIndexPath:tableView];
    return self.cellForRowAtIndexPath.cell;
}

@end
