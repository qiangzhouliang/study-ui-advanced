//
//  GestureUnlockViewController.m
//  09-触摸事件
//
//  Created by swan on 2024/9/10.
//

#import "GestureUnlockViewController.h"
#import "SWView.h"

@interface GestureUnlockViewController ()
@property (weak, nonatomic) IBOutlet SWView *passwordView;

@end

@implementation GestureUnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置控制器 view 的背景为一张图片（平铺）
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    // 密码
    NSString *str = @"012";
    self.passwordView.passwordBlock = ^BOOL(NSString * pwd) {
        if ([pwd isEqualToString:str]) {
            NSLog(@"正确");
            return YES;
        } else {
            NSLog(@"错误");
            return NO;
        }
    };
}

@end
