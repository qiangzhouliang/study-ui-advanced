//
//  SWHelpTableViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/15.
//

#import "SWHelpTableViewController.h"
#import "SWHelp.h"
#import "SWHelpWebController.h"
#import "SWNavigationController.h"

@interface SWHelpTableViewController ()

@property (nonatomic, strong) NSArray *helps;

@end

@implementation SWHelpTableViewController

/// 懒加载
- (NSArray *)helps{
    if (_helps == nil) {
        // 1. 获取文件路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        // 2. 转成 data
        NSData *data = [NSData dataWithContentsOfFile:filePath];

        NSArray *arr =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

        NSMutableArray *array = [NSMutableArray array];

        for (NSDictionary *dict in arr) {

            SWHelp *h = [SWHelp helpWithDict:dict];

            [array addObject:h];
        }
        _helps = array;
    }

    return _helps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置标题
    self.title = @"常见问题";
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.helps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取数据
    SWHelp *h = self.helps[indexPath.row];
    // id
    static NSString * cellid = @"help_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    // 右边的箭头
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];

    // 赋值
    cell.textLabel.text = h.title;

    return cell;
}

/// 点击 cell 调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建需要跳转到的 控制器
    SWHelpWebController *vc = [[SWHelpWebController alloc] init];

    // 把数据传给下一个（web）控制器
    vc.help = self.helps[indexPath.row];

    // push
//    [self.navigationController pushViewController:vc animated:YES];

    // 包装nav
    SWNavigationController *nav = [[SWNavigationController alloc] initWithRootViewController:vc];

    // 添加一个取消按钮
    UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleClick)];
    // 设置左边按钮
    vc.navigationItem.leftBarButtonItem = cancleBtn;
    // modal
    [self presentViewController:nav animated:YES completion:nil];
}

/// 点击取消按钮
-(void)cancleClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
