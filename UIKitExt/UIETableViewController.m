//
//  UIETableViewController.m
//  UIKitExt
//
//  Created by Dan Kalinin on 12/30/18.
//

#import "UIETableViewController.h"










@implementation UITableViewController (UIE)

@dynamic nseOperation;

- (Class)nseOperationClass {
    return UIETableViewControllerOperation.class;
}

@end










@interface UIETableViewController ()

@end



@implementation UIETableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nseOperation viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    [self.nseOperation prepareForSegue:segue sender:sender];
}

#pragma mark - UIETableViewDelegate

- (void)uieTableViewNumberOfSections:(UITableView *)tableView {
    tableView.nseOperation.numberOfSections.sections = [self numberOfSectionsInTableView:tableView];
}

- (void)uieTableViewNumberOfRowsInSection:(UITableView *)tableView {
    tableView.nseOperation.numberOfRowsInSection.rows = [self tableView:tableView numberOfRowsInSection:tableView.nseOperation.numberOfRowsInSection.section];
}

- (void)uieTableViewCellForRowAtIndexPath:(UITableView *)tableView {
    tableView.nseOperation.cellForRowAtIndexPath.cell = [self tableView:tableView cellForRowAtIndexPath:tableView.nseOperation.cellForRowAtIndexPath.indexPath];
}

- (void)uieTableViewDidSelectRowAtIndexPath:(UITableView *)tableView {
    
}

@end










@interface UIETableViewControllerOperation ()

@end



@implementation UIETableViewControllerOperation

@dynamic object;

@end
