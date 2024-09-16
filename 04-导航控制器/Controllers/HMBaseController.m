//
//  HMBaseController.m
//  04-导航控制器
//
//  Created by swan on 2024/9/6.
//

#import "HMBaseController.h"

@interface HMBaseController ()

@end

@implementation HMBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@-------->界面加载完成", [self class]);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@-------->界面即将显示", [self class]);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%@-------->界面已经显示出来", [self class]);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%@-------->界面即将消失", [self class]);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"%@-------->页面已经消失", [self class]);
}

@end
