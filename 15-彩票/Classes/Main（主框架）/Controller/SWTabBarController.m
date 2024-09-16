//
//  SWTabBarController.m
//  15-彩票
//
//  Created by swan on 2024/9/12.
//

#import "SWTabBarController.h"
#import "SWTabBar.h"


@interface SWTabBarController ()

@end

@implementation SWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取 5 个子控制器
    UIViewController *v1 = [self loadSubViewControllerWithSBName:@"Hall"];
    UIViewController *v2 = [self loadSubViewControllerWithSBName:@"Arenal"];
    UIViewController *v3 = [self loadSubViewControllerWithSBName:@"Discovery"];
    UIViewController *v4 = [self loadSubViewControllerWithSBName:@"History"];
    UIViewController *v5 = [self loadSubViewControllerWithSBName:@"MyLottery"];
    
    self.viewControllers = @[v1,v2,v3,v4,v5];
    
    // 创建一个自定义的 tabbar
    SWTabBar *tabbar = [[SWTabBar alloc] init];
    
    // 3.使用 block（遵守协议，使用代理方法）
    tabbar.tabbatButtonBlock = ^(NSInteger index) {
        self.selectedIndex = index;
    };
    
    // 设置 tabbar 的frame 为系统的frame
    tabbar.frame = self.tabBar.bounds;
    
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        
        // 设置button图片
        UIImage *image= [UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%d",i+1]];
        UIImage *image_selected = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar_%d_selected",i+1]];
        
        [tabbar addButtonWithImage:image andImageSel:image_selected];
    }
    
    // 添加到 tabbarcontroller
//    [self.view addSubview:tabbar];
    [self.tabBar addSubview:tabbar];
    
    // 覆盖底部留白部分
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.tabBar.frame.size.height, KScreenWidth, self.tabBar.frame.size.height)];
    view.backgroundColor = UIColor.blackColor;
    [self.tabBar addSubview:view];
    
}



/// 根据 storyboard 名字返回 指向的控制器
-(UIViewController *)loadSubViewControllerWithSBName:(NSString *)name{
    // 1 加载storyboard文件
     UIStoryboard *HallBoard = [UIStoryboard storyboardWithName:name bundle:nil];
    // 2. 从 storyboard 文件中实例化控制器
    // 2.1 直接加载带箭头的控制器
    UIViewController *vc = [HallBoard instantiateInitialViewController];
    return  vc;
}

@end
