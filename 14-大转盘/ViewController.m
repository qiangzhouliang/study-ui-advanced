//
//  ViewController.m
//  14-大转盘
//
//  Created by swan on 2024/9/11.
//

#import "ViewController.h"
#import "RotateView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置控制器 view 背景图片
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"LuckyBackground"].CGImage;
    
    // 创建这个旋转的 view
    RotateView *rotateView = [RotateView rotateView];
    rotateView.center = self.view.center;
    // 添加到控制器的 view 上
    [self.view addSubview:rotateView];
    // 旋转
    [rotateView startRotate];
}


@end
