//
//  SWSettingTableViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import "SWSettingTableViewController.h"
#import "Setting/SWRedeemViewController.h"
#import "SWSettingCell.h"

#import "MBProgressHUD+XMG.h"


@interface SWSettingTableViewController ()

@property (nonatomic, strong) NSArray *groups;

@end

@implementation SWSettingTableViewController
-(instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}
-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

/// 懒加载
-(NSArray *)groups{
    if (!_groups) {
        // 获取路径
        NSString *path = [[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"];
        
        // 解析成数组
        _groups = [NSArray arrayWithContentsOfFile:path];
        
    }
    return _groups;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@", self.groups);
}

#pragma mark - Table view data source
/// 有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

/// 每一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 获取组
    NSDictionary *group = self.groups[section];
    // 获取当前组 所有的 cell 信息
    NSArray *items = group[@"items"];
    return items.count;
}

/// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1. 获取组
    NSDictionary *group = self.groups[indexPath.section];
    // 2. 获取当前组 所有的 cell 信息
    NSArray *items = group[@"items"];
    // 3. 取当前 cell 的信息
    NSDictionary *item = items[indexPath.row];
    
    static NSString *cellId = @"setting_cell";
    // 缓存中找
    SWSettingCell *cell = [SWSettingCell settingCellWithTableView:tableView andItem:item];
    
    // 赋值
    cell.item = item;
    
    return cell;
}

/// header 信息
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // 获取组
    NSDictionary *group = self.groups[section];
    return group[@"header"];
}

/// footer 信息
-(NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    // 获取组
    NSDictionary *group = self.groups[section];
    return group[@"footer"];
}

/// 检查新版本
-(void)checkUpdate{
    NSLog(@"检查新版本");
    [MBProgressHUD showSuccess:@"当前没有最新版本"];
}

/// 打电话
-(void)makeCall{
    // 获取APP
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"tel://10010"];
    [app openURL:url];
}

/// 发短信
-(void)sendMessage{
    // 获取APP
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"sms://10010"];
    [app openURL:url];
}


/// 点击cell调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        // 使用兑换码
//        SWRedeemViewController *vc = [[SWRedeemViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }

    // 1. 获取组
    NSDictionary *group = self.groups[indexPath.section];
    // 2. 获取当前组 所有的 cell 信息
    NSArray *items = group[@"items"];
    // 3. 取当前 cell 的信息
    NSDictionary *item = items[indexPath.row];
    if (item[@"targetVC"] && [item[@"targetVC"] length] > 0) {
        Class Clz = NSClassFromString(item[@"targetVC"]); // SWRedeemViewController
        UIViewController *vc = [[Clz alloc] init];
        if ([vc isKindOfClass:[SWSettingTableViewController class]]) {
            // 如果 setting 类型的 需要传入一个 plistname
            SWSettingTableViewController *setting = (SWSettingTableViewController *) vc;
            setting.plistName = item[@"plistName"];
        }

        vc.navigationItem.title = item[@"title"];     // 设置 title
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (item[@"funcName"] && [item[@"funcName"] length] > 0) {
        // 执行 item[@"funcName"] 方法
//        item[@"funcName"] // 把字符串转换成一个方法
        SEL funcName = NSSelectorFromString(item[@"funcName"]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // 执行方法
        [self performSelector:funcName];
#pragma clang diagnostic pop


    }

}

@end
