//
//  UIETableViewController.m
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIETableViewController.h"










@implementation UITableViewController (UIE)

@dynamic uieOperation;

- (Class)uieOperationClass {
    return UIETableViewControllerOperation.class;
}

@end










@interface UIETableViewController ()

@end



@implementation UIETableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.uieOperation viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    [self.uieOperation prepareForSegue:segue sender:sender];
}

#pragma mark - UIETableViewDelegate

- (void)uieTableViewNumberOfSections:(UITableView *)tableView {
    tableView.uieOperation.numberOfSections.sections = [self numberOfSectionsInTableView:tableView];
}

- (void)uieTableViewNumberOfRowsInSection:(UITableView *)tableView {
    tableView.uieOperation.numberOfRowsInSection.rows = [self tableView:tableView numberOfRowsInSection:tableView.uieOperation.numberOfRowsInSection.section];
}

- (void)uieTableViewCellForRowAtIndexPath:(UITableView *)tableView {
    tableView.uieOperation.cellForRowAtIndexPath.cell = [self tableView:tableView cellForRowAtIndexPath:tableView.uieOperation.cellForRowAtIndexPath.indexPath];
}

- (void)uieTableViewDidSelectRowAtIndexPath:(UITableView *)tableView {
    
}

@end










@interface UIETableViewControllerOperation ()

@end



@implementation UIETableViewControllerOperation

@dynamic object;

@end
