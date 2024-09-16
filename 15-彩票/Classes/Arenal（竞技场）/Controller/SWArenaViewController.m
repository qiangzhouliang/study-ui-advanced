//
//  SWArenaViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/13.
//

#import "SWArenaViewController.h"

@interface SWArenaViewController ()

@end

@implementation SWArenaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置控制器背景图片（拉伸的）
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"NLArenaBackground"].CGImage;
    
    // 设置 navbar 的图片
    // 覆盖导航栏顶部留白部分
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -60, KScreenWidth, 60)];
    view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"NLArenaNavBar64"]];
    [self.navigationController.navigationBar addSubview:view];
    
    // 设置导航栏图片
    self.navigationController.navigationBar.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"NLArenaNavBar64"]];
    // 不起作用
    //    UIBarMetricsDefault,  // 横屏竖屏都显示
    //    UIBarMetricsCompact,  // 横屏显示 竖屏不显示
    //    UIBarMetricsDefaultPrompt = 101, // 竖屏有副标题显示 横屏有副标题不显示
    //    UIBarMetricsCompactPrompt,// 竖屏有副标题不显示 横屏有副标题显示
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    // 获取 titleView
    UISegmentedControl *seq = (UISegmentedControl *)self.navigationItem.titleView;
    
    
    // 设置默认的背景图片
    [seq setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // 设置选中的背景图片
    [seq setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    // 设置文字颜色
    [seq setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor} forState:UIControlStateNormal];
    [seq setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor} forState:UIControlStateSelected];
    
    // 取消蓝色的线
    [seq setTintColor:UIColor.clearColor];
    
}


@end
