//
//  SWLiveTableViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import "SWLiveTableViewController.h"

@interface SWLiveTableViewController ()

// 日期选择控件
@property (nonatomic, strong) UIDatePicker *datePicker;

// 工具条
@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation SWLiveTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }

    // 创建一个看不见的文本框
    UITextField *text = [[UITextField alloc] init];

    // 获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    // 添加到cell上
    [cell addSubview:text];

    // 创建 datePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    // 中文
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    // 时间格式
    datePicker.datePickerMode = UIDatePickerModeTime;
    // 设置显示样式
    if (@available(iOS 13.4, *)) {
        datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    // 设置文本框 inputview
    text.inputView = datePicker;
    self.datePicker = datePicker;
    // 创建 toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.bounds = CGRectMake(0, 0, 0, 44);
    // 创建三个item
    // 创建按钮放到工具条里面
    // 取消
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleItemClick)];

    // 弹簧
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    // 确认
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(confirmItemClick)];

    toolbar.items = @[cancleItem, flexSpace, confirmItem];
    // 设置文本框 inputAccessoryView
    // 设置工具条
    text.inputAccessoryView = toolbar;
    self.toolbar = toolbar;
    // 让文本款成为第一响应者
    [text becomeFirstResponder];
}
// 点击取消按钮
- (void)cancleItemClick{
    [self.view endEditing:YES];
}

// 点击确认按钮
-(void)confirmItemClick{
    // 1. 获取选中日期
    NSDate *date = self.datePicker.date;
    // 2. 将日期设置给文本框
    // 将日期转字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm"; //yyyy年MM月dd日 HH:mm:ss 时分秒
    NSString *time = [formatter stringFromDate:date];

    // 获取 indexPath
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];

    // 获取cell
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];

    // 修改cell
    cell.detailTextLabel.text = time;

    // 3. 关闭键盘
    [self.view endEditing:YES];
}
@end
