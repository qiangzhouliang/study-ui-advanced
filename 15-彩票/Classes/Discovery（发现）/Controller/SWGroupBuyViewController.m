//
//  SWGroupBuyViewController.m
//  15-彩票
//
//  Created by swan on 2024/9/14.
//

#import "SWGroupBuyViewController.h"


@interface SWGroupBuyViewController ()

@property (nonatomic, weak) UIView *blueView;

@end

@implementation SWGroupBuyViewController

/// 懒加载
- (UIView *)blueView{
    if (!_blueView) {
        UIView *blueView = [[UIView alloc] init];
        blueView.backgroundColor = UIColor.blueColor;
        blueView.frame = CGRectMake(0, 64, KScreenWidth, 0);
        [self.view addSubview:blueView];
        
        _blueView = blueView;
    }
    return _blueView;
}

/// 全部彩种 点击事件
- (IBAction)groupBuyClick:(UIButton *)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        // 如果高度有值 那么设置为0如果没有值（值为0）那么设置150
        self.blueView.h = self.blueView.h ? 0 : 150;
        
        // 旋转
        sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self blueView];
}

@end
