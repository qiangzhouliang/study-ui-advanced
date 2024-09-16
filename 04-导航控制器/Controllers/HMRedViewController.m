//
//  HMRedViewController.m
//  04-导航控制器
//
//  Created by swan on 2024/9/6.
//

#import "HMRedViewController.h"
#import "HMGreenViewController.h"

@interface HMRedViewController ()

@end

@implementation HMRedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark - 设置导航控制器的导航栏的内容
//    self.navigationItem  : 获取当前控制器的导航栏
    // 1. 设置标题
    // 文字
//    self.navigationItem.title = @"红色控制器";
    // 设置控件
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.titleView = addButton;
    
    // 2. 设置按钮
    // 创建一个 UIBarButton 类型的按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    self.navigationItem.rightBarButtonItem = right;
    
    // 3. 返回按钮（控制的是下一个页面的 箭头 旁边的返回）
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

- (IBAction)goToGreenVC:(id)sender {
    // 1. 创建绿色控制器
    HMGreenViewController *greenVC = [HMGreenViewController new];
    // 给控制器属性赋值
    greenVC.title = @"红色控制器跳过来的";
    
    // 2. 跳转
    [self.navigationController pushViewController:greenVC animated:YES];
    
    
}

#pragma mark - Navigation
// 通过 storyboard拖线的方式实现跳转的时候就会调用这个方法
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    // 获取文本框的内容
//    NSString *text = self.textField.text;
//    //获取目标控制器
//    HMGreenViewController *greenVc = segue.destinationViewController;
//    // 设置标題
//    greenVc. navigationItem. title = text;
//}


@end
