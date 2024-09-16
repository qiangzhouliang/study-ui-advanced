//
//  SWMyLotteryViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import "SWMyLotteryViewController.h"
#import "SWSettingTableViewController.h"
#import "SWHelpTableViewController.h"

@interface SWMyLotteryViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation SWMyLotteryViewController

/// 设置按钮点击事件
- (IBAction)settingClick:(id)sender {
    SWSettingTableViewController *setting = [[SWSettingTableViewController alloc] init];
    setting.plistName = @"Setting";
    // 设置标题
    setting.navigationItem.title = @"设置";
    // 右边按钮
    UIBarButtonItem *help = [[UIBarButtonItem alloc] initWithTitle:@"常见问题" style:UIBarButtonItemStylePlain target:self action:@selector(helpClick)];
    setting.navigationItem.rightBarButtonItem = help;

    [self.navigationController pushViewController:setting animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 获取图片
    UIImage *image = [UIImage imageNamed:@"RedButton"];
    // 中间1像素拉伸
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    // 设置按钮的背景图片
    [self.loginButton setBackgroundImage:image forState:UIControlStateNormal];
    
    // 获取图片
    UIImage *imagePressed = [UIImage imageNamed:@"RedButtonPressed"];
    // 中间1像素拉伸
    imagePressed = [imagePressed stretchableImageWithLeftCapWidth:imagePressed.size.width * 0.5 topCapHeight:imagePressed.size.height * 0.5];
    // 设置按钮的背景图片
    [self.loginButton setBackgroundImage:imagePressed forState:UIControlStateHighlighted];
}

/// 点击帮助
- (void)helpClick
{
    // 跳转到常见问题的 TableviewController
    SWHelpTableViewController *help = [[SWHelpTableViewController alloc] init];
    [self.navigationController pushViewController:help animated:YES];
}
@end
