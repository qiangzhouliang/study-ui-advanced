//
//  HMGreenViewController.m
//  04-导航控制器
//
//  Created by swan on 2024/9/6.
//

#import "HMGreenViewController.h"
#import "HMBlueViewController.h"

@interface HMGreenViewController ()

@end

@implementation HMGreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 4. 当这个控制器不是导航控制器的主控制器，如果在左侧放置了按钮，那么系统生成返回按钮，就不复存在了
    // 绿色控制器左侧的一个按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
    self.navigationItem.leftBarButtonItem = left;
    
    self.navigationItem.title = self.title;
    
}

- (IBAction)goToBlueVc:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    // 返回到根控制器
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    // 返回到指定控制器
//    [self.navigationController popToViewController:vc animated:YES];
}

@end
