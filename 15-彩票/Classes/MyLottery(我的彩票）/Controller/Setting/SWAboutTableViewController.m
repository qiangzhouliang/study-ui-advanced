//
//  SWAboutTableViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWAboutTableViewController.h"
#import "SWAboutHeaderView.h"

@interface SWAboutTableViewController ()

@end

@implementation SWAboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置 header 头
    self.tableView.tableHeaderView = [SWAboutHeaderView aboutHeaderView];
}

#pragma mark - Table view data source

@end
