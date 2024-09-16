//
//  SWNavigationController.m
//  15-彩票
//
//  Created by swan on 2024/9/12.
//

#import "SWNavigationController.h"

@interface SWNavigationController ()

@end

@implementation SWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 覆盖导航栏顶部留白部分
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -60, KScreenWidth, 60)];
    view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"NavBar64"]];
    [self.navigationBar addSubview:view];
    
    // 设置导航栏图片
    self.navigationBar.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"NavBar64"]];
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    // 设置字体为白色
    [self.navigationBar setTitleTextAttributes:@{
        NSForegroundColorAttributeName: [UIColor whiteColor]
    }];
    
    // 设置渲染的颜色
    self.navigationBar.tintColor = UIColor.whiteColor;
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


///  以后只要使用这个 nav 去push 那么都隐藏tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
