//
//  ViewController.m
//  02-自定义键盘时间选择DatePicker
//
//  Created by swan on 2024/9/6.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)test:(id)sender;
// 文本框
@property (weak, nonatomic) IBOutlet UITextField *textField;

// 日期选择控件
@property (nonatomic, strong) UIDatePicker *datePicker;

// 工具条
@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置文本框的输入界面为 datePicker
    self.textField.inputView = self.datePicker;
    // 设置工具条
    self.textField.inputAccessoryView = self.toolbar;
    
}


#pragma mark - 懒加载控件 用strong
-(UIToolbar *)toolbar{
    if (!_toolbar) {
        // 只需要高度就够了
        _toolbar = [[UIToolbar alloc] init];
        _toolbar.bounds = CGRectMake(0, 0, 0, 44);
        
        // 创建按钮放到工具条里面
        // 取消
        UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleItemClick)];
        
        // 弹簧
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        // 确认
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(confirmItemClick)];
        
        _toolbar.items = @[cancleItem, flexSpace, confirmItem];
    }
    return _toolbar;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        // 不需要设置frame 自动占据键盘的位置
        _datePicker = [[UIDatePicker alloc] init];
//        _datePicker.frame = CGRectMake(0, 200, self.view.bounds.size.width, 216);
        // 日期模式
        _datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置显示样式
        _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        // 本地化
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        
    }
    return _datePicker;
}

- (IBAction)Test:(id)sender {
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
    formatter.dateFormat = @"yyyy年MM月dd日"; // HH:mm:ss 时分秒
    NSString *str = [formatter stringFromDate:date];
    
    self.textField.text = str;
    
    // 3. 关闭键盘
    [self.view endEditing:YES];
}
- (IBAction)test:(id)sender {
}
@end
